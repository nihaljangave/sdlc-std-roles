# Standard Role Playbook: DevOps, SRE & Operations Lead

| Role Profile | Details |
|---|---|
| **Role Title** | DevOps, SRE & Operations Lead |
| **Primary Accountability** | CI/CD Infrastructure, Production Reliability, Observability & Operational Readiness |
| **Key Collaborators** | Tech Lead, Software Engineers, QA Engineer, Cloud Security Officer |
| **Primary Gate Ownership**| Gate 4 (Release & Operations Handover) & Gate 5 (Steady-State Operations) |

---

## 1. Core Mission & Objectives
The DevOps / SRE / Operations Lead bridges the gap between software development and post-production operations. They automate the delivery pipeline, maintain infrastructure as code, establish centralized observability, and guarantee that the system can be operated, monitored, and recovered by Tier-1/Tier-2 operations engineers with zero surprises.

---

## 2. Responsibilities by SDLC Stage

### Stage 1: Architecture & System Design
- Review the High-Level Architecture for operational viability, cloud costs, and scaling limits.
- Define infrastructure topology and write Infrastructure-as-Code (Terraform / Pulumi / CloudFormation).
- Agree on Service Level Objectives (SLOs) and error budgets with product and client teams.
- Establish centralized logging standards (JSON schema, correlation IDs) and secret management strategies.

### Stage 2: Development & Build
- Build and maintain the automated CI/CD pipeline (GitHub Actions / GitLab CI) with embedded quality gates.
- Implement automated container security scanning (Trivy), static analysis (SonarQube), and dependency checks (Snyk).
- Provide developers with reproducible local environments (Docker Compose) and ephemeral PR preview sandboxes.

### Stage 3: Verification & Client UAT
- Maintain stable, production-equivalent Staging and UAT environments.
- Execute infrastructure load and chaos tests (validating auto-scaling and failover behavior).
- Conduct database backup and Point-In-Time-Recovery (PITR) restore dry-runs.

### Stage 4: Release & Ops Handover
- Review and finalize the **Production Operations Runbook (Day-2 Playbook)**.
- Author and lead the **Deployment & Rollback Guide** execution (Canary / Blue-Green cutover).
- Configure production monitoring dashboards (Datadog/Grafana) and alert routing (PagerDuty/Opsgenie).
- Conduct the **Pre-Deployment Operations Readiness Review (ORR)**.
- Verify that receiving Operations engineers understand SOPs and emergency procedures.
- Execute the **Service Transition Checklist** to clear **Gate 4**.

### Stage 5: Post-Production & Hypercare
- Lead 24/7 production operations and incident response under agreed SLAs.
- Run the War Room during P1/P2 incidents and enforce MTTR targets (< 2h for P1).
- Facilitate the blameless post-mortem meeting within 48 hours of any major incident.
- Monitor SLO consumption and trigger feature freezes if error budget is exhausted.
- Formally accept steady-state support at the conclusion of hypercare to clear **Gate 5**.

---

## 3. Essential Artifacts Owned

| Artifact Name | Template Reference | Frequency |
|---|---|---|
| **Operations Runbook (Day-2 Playbook)** | [`templates/OPERATIONS_RUNBOOK.md`](../templates/OPERATIONS_RUNBOOK.md) | Created prior to Gate 4, living document |
| **Deployment & Rollback Guide** | [`templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md`](../templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md) | Executed per production release |
| **Service Transition Checklist** | [`templates/SERVICE_TRANSITION_CHECKLIST.md`](../templates/SERVICE_TRANSITION_CHECKLIST.md) | Gate 4 handover gate |
| **Infrastructure-as-Code (IaC)** | Version-controlled in repository (`/infra`) | Updated with architecture changes |
| **Incident Management & SLA Matrix** | [`templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md`](../templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md) | Governs production support |

---

## 4. Key Performance Indicators (KPIs)
- **Deployment Frequency:** Multiple automated staging deploys per day; zero-downtime production deploys.
- **Mean Time to Recover (MTTR):** < 30 minutes for production incidents.
- **Rollback Execution Time:** Automated rollback completed in < 3 minutes if criteria met.
- **Service Availability (SLA):** >= 99.9% production uptime.
- **Disaster Recovery RTO/RPO:** RTO < 30 minutes, RPO < 5 minutes verified via drills.

