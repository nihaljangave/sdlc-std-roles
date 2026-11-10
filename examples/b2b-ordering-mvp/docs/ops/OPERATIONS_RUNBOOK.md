# Production Operations Runbook (Day-2 Playbook)
## QuickDistro B2B Wholesale Portal - Operational Runbook

| Service Metadata | Details |
|---|---|
| **System / Service Name** | QuickDistro Wholesale Platform |
| **Tier / Criticality** | Tier 1 (Mission-Critical B2B Ingress) |
| **Owner Team** | Metro Cloud SRE & Operations Team |
| **Escalation Channel** | Slack `#quickdistro-ops` \| `ops-oncall@metrowholesale.com` |
| **Primary Cloud Provider** | AWS (us-east-1) / ECS Fargate Containers |
| **Last Updated** | 2026-11-10 |

---

## 1. System Topology & Critical Service Dependencies

```mermaid
graph LR
    subgraph Ingress
        DNS["Route 53 (api.distrocorp.com)"] --> CDN["CloudFront + AWS WAF"]
        CDN --> ALB["Application Load Balancer"]
    end

    subgraph Compute (VPC Private Subnet)
        ALB --> API_Tasks["Wholesale API Service (ECS Fargate)"]
        API_Tasks --> RedisCluster[("ElastiCache Redis 7 (Idempotency & Sessions)")]
        API_Tasks --> RDS_Master[("RDS Aurora PostgreSQL 16 (Primary)")]
        RDS_Master -.-> RDS_Replica[("RDS Read Replica (Catalog Queries)")]
        API_Tasks --> SQS_Queue["AWS SQS (ERP Dispatch Queue)"]
        SQS_Queue --> Worker_Tasks["Webhook Dispatch Workers (ECS)"]
    end

    subgraph External Dependencies
        Worker_Tasks --> MetroERP["Metro Legacy Mainframe ERP (HTTPS)"]
        Worker_Tasks --> SendGrid["SendGrid (Order Confirmation Emails)"]
    end
```

### Operational Asset Registry:
- **Application Repository:** `https://github.com/metrowholesale/quickdistro-api`
- **Infrastructure as Code (Terraform):** `https://github.com/metrowholesale/quickdistro-infra`
- **Secrets Store:** AWS Secrets Manager (`prod/quickdistro/credentials`)
- **Container Registry:** Amazon ECR (`123456789.dkr.ecr.us-east-1.amazonaws.com/quickdistro-api:v1.0.0`)

---

## 2. Health Checks, Dashboards & Telemetry

| Purpose | URL / Tool | Access Method | Expected Response / Baseline |
|---|---|---|---|
| **Liveness Check** | `GET https://api.distrocorp.com/health/live` | Public / Pingdom | HTTP 200 `{"status": "ok"}` (< 30ms) |
| **Readiness Check** | `GET https://api.distrocorp.com/health/ready` | Internal VPC only | HTTP 200 `{"database": "connected", "redis": "connected"}` |
| **APM Dashboard** | `https://app.datadoghq.com/dashboard/quickdistro-prod` | SSO Login | Real-time throughput, p95 latency, 5xx error rate |
| **Log Search** | `https://app.datadoghq.com/logs?query=service:quickdistro-api` | SSO Login | Structured JSON logs with `trace_id` and `distributor_id` |
| **Webhook DLQ Monitor**| AWS SQS Console -> `quickdistro-erp-webhooks-dlq` | Cloud VPN | Approximate message count must remain 0 |

---

## 3. High-Priority Alert Thresholds & Automatic Triggers

| Alert Identifier | Condition | Severity | Notification Channel | Auto-Remediation Behavior |
|---|---|---|---|---|
| **HighOrderErrorRate** | HTTP 5xx > 1% of total traffic for 2 mins | P1 (Critical) | PagerDuty On-Call (Voice/SMS) | None (Requires immediate war room) |
| **DBConnectionSaturation** | Active DB connection pool > 80% for 3 mins | P1 (Critical) | PagerDuty On-Call | None (Investigate un-indexed queries) |
| **RedisMemorySpike** | Redis memory utilization > 80% | P2 (Major) | Slack `#quickdistro-ops` | Auto-evict least recently used cache items |
| **WebhookQueueBacklog** | SQS queue depth > 500 messages for 5 mins | P2 (Major) | Slack `#quickdistro-ops` | Auto-scale worker tasks from 2 to 6 |

---

## 4. Routine Maintenance Standard Operating Procedures (SOPs)

### SOP-01: Rotating Webhook HMAC Secret
```bash
# 1. Generate new 32-byte secret
NEW_SECRET=$(openssl rand -hex 32)

# 2. Update secret in AWS Secrets Manager
aws secretsmanager update-secret \
    --secret-id prod/quickdistro/credentials \
    --secret-string "{\"WEBHOOK_SECRET\":\"$NEW_SECRET\"}"

# 3. Trigger rolling restart of background workers
aws ecs update-service \
    --cluster quickdistro-prod-cluster \
    --service webhook-dispatcher \
    --force-new-deployment
```

### SOP-02: Flushing Outdated Catalog Cache Safely
```bash
# Targeted namespace invalidation (prevents cache stampede):
redis-cli -h prod-redis.internal -p 6379 --scan --pattern "catalog:v1:*" | xargs -L 100 redis-cli -h prod-redis.internal -p 6379 del
```

---

## 5. Emergency Incident Troubleshooting Playbooks

### Playbook A: Spiking 504 Gateway Timeouts on Bulk SKU Validation
1. **Identify Slow Queries in PostgreSQL:**
   ```sql
   SELECT pid, now() - pg_stat_activity.query_start AS duration, query 
   FROM pg_stat_activity 
   WHERE state != 'idle' AND (now() - pg_stat_activity.query_start) > interval '5 seconds'
   ORDER BY duration DESC;
   ```
2. **Terminate Hanging Query:**
   ```sql
   SELECT pg_terminate_backend(<pid>);
   ```
3. **Scale API Tasks Horizontally:**
   ```bash
   aws ecs update-service --cluster quickdistro-prod-cluster --service api-service --desired-count 6
   ```

### Playbook B: Metro Legacy ERP Webhook Ingress Down
1. Confirm messages are accumulating in SQS without message loss:
   ```bash
   aws sqs get-queue-attributes --queue-url https://sqs.us-east-1.amazonaws.com/12345/quickdistro-erp-webhooks \
       --attribute-names ApproximateNumberOfMessages
   ```
2. Check network connectivity between AWS NAT Gateway and Metro Mainframe IP `198.51.100.42`.
3. SQS retains messages up to 14 days; once Metro ERP restores, worker tasks automatically drain backlog at 100 msgs/sec.
