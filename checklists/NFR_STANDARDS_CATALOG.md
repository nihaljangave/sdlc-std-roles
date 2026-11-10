# Non-Functional Requirements (NFR) Benchmark Catalog
## Tailoring Standards for Prototypes, MVPs, and Enterprise Production

Non-functional requirements (NFRs) often derail fast-paced prototypes when teams either **ignore them completely** (leading to operational collapse) or **over-engineer them prematurely** (wasting weeks on multi-region enterprise clustering).

Use this benchmark catalog to select the appropriate NFR tier during **Stage 0 (Scoping)** and **Stage 1 (Architecture)**.

---

## 1. NFR Tier Comparison Matrix

| Quality Attribute | Tier 1: Prototype / Proof-of-Concept (2-4 Weeks) | Tier 2: Commercial MVP / Pilot (6-10 Weeks) | Tier 3: Enterprise Production (Steady State) |
|---|---|---|---|
| **Availability (SLA)** | 95.0% (Best effort, business hours) | 99.0% (~7.3 hrs downtime/month) | 99.9% (<43 mins downtime/month) |
| **API Latency (p95)** | < 1,000ms | < 400ms | < 150ms |
| **Throughput / Concurrency** | 50 concurrent users | 500 concurrent users | 5,000+ auto-scaling concurrent users |
| **Recovery Time (RTO)** | < 4 hours | < 1 hour | < 15 minutes |
| **Recovery Point (RPO)** | 24 hours (Daily snapshot) | 1 hour (Hourly WAL archive) | < 5 minutes (Continuous replication) |
| **Security & Auth** | Single-tenant OAuth / Basic JWT | RBAC, TLS 1.3, Secrets Manager | SSO / SAML, MFA, WAF, SIEM integration |
| **Data Privacy & Compliance** | Data masking in logs | GDPR / CCPA right-to-forget policy | SOC 2 Type II, ISO 27001, HIPAA / PCI |
| **Observability** | Console logs + free-tier CloudWatch | Structured JSON logs + Sentry | Distributed tracing (OpenTelemetry), Datadog/ELK, APM |
| **Disaster Recovery** | Single-AZ deployment | Multi-AZ database, automated snapshots | Multi-AZ compute/data + cross-region backup |
| **Accessibility (a11y)** | Keyboard navigable | WCAG 2.1 Level A | WCAG 2.1 Level AA certified |

---

## 2. Standardized NFR Checklist by Category

### 2.1 Performance & Scalability
- [ ] **Response Time:** 95% of read requests complete in `< [X]ms`; 95% of write requests complete in `< [Y]ms`.
- [ ] **Database Connection Management:** Application utilizes connection pooling with max pool size configured to avoid DB saturation.
- [ ] **Payload Limits:** Maximum HTTP request body size capped (e.g., 5MB for JSON, 25MB for file uploads).
- [ ] **Horizontal Scalability:** Stateless backend services capable of horizontal pod auto-scaling (HPA) at 70% CPU/Memory threshold.

### 2.2 Security & Protection
- [ ] **Encryption In-Transit:** All external and internal ingress enforced via TLS 1.3.
- [ ] **Encryption At-Rest:** AES-256 enabled on all databases, S3 buckets, and cache volumes.
- [ ] **Vulnerability Posture:** Zero unresolved Critical or High CVEs in application dependencies.
- [ ] **Rate Limiting:** Ingress protected by token-bucket or sliding-window rate limiting (e.g., 100 requests/minute/IP).
- [ ] **Credential Safety:** Zero static credentials in application configuration or source control.

### 2.3 Reliability & Resilience
- [ ] **Graceful Degradation:** External service outages (e.g., email service, analytics) must not block core business transactions.
- [ ] **Timeouts & Circuit Breakers:** All outbound HTTP/gRPC calls must have explicit connection and read timeouts (e.g., max 3s) with circuit breakers.
- [ ] **Idempotency:** Critical write operations (payments, order creations, account mutations) must support `Idempotency-Key` headers.

### 2.4 Maintainability & Operability
- [ ] **Containerization:** Application buildable into an immutable OCI-compliant container image running as non-root.
- [ ] **Configuration as Code:** 100% of runtime configuration injected via environment variables (12-Factor App methodology).
- [ ] **Zero-Downtime Deployment:** Rolling updates or blue/green deployments supported without terminating active user sessions.
- [ ] **Health Checks:** Liveness (`/health/live`) and readiness (`/health/ready`) probes responding with HTTP 200 within 50ms.

