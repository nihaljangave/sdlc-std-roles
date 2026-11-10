# Service Transition Checklist (Operations Handover Gate)

This document serves as the formal operational readiness gate (Gate 4) between the Engineering / Development Team and the Operations / IT Support / SRE Team.

| Transition Information | Details |
|---|---|
| **Service / Product Name** | [Product Name] |
| **Release Version** | v[1.0.0] |
| **Development Lead** | [Name / Email] |
| **Operations / SRE Lead** | [Name / Email] |
| **Handover Date** | YYYY-MM-DD |
| **Status** | `Accepted` \| `Conditionally Accepted` \| `Rejected` |

---

## 1. Documentation & Knowledge Transfer

| Verification Item | Status (Yes/No/NA) | Evidence / Reference Link | Reviewed By |
|---|---|---|---|
| **System Architecture Document (SAD)** completed and approved | [ ] Yes | `docs/architecture/SAD.md` | Ops Lead |
| **Operations Runbook** published with all emergency SOPs | [ ] Yes | `docs/ops/RUNBOOK.md` | Ops Lead |
| **API Contract & Integration Specs** available | [ ] Yes | `docs/api/openapi.yaml` | Support Lead |
| **Formal Architecture & Troubleshooting Walkthrough** held | [ ] Yes | Meeting recording link | Dev Lead |
| **End-User / Client Admin Guide** published | [ ] Yes | `docs/user-guide.pdf` | Client PM |

---

## 2. Infrastructure, Secrets & Access Management

| Verification Item | Status (Yes/No/NA) | Evidence / Reference Link | Reviewed By |
|---|---|---|---|
| Infrastructure provisioned 100% via **Infrastructure-as-Code (Terraform)** | [ ] Yes | `infra/terraform/` | SRE Lead |
| All secrets stored securely in Secrets Manager (zero plaintext) | [ ] Yes | AWS Secrets Manager path | Security Lead |
| Operations team granted administrative IAM / Kubernetes access | [ ] Yes | IAM Role: `OpsAdminRole` | SecOps |
| Offboarding complete: Developer personal access to prod DB revoked | [ ] Yes | Bastion access audit log | SecOps |
| SSL / TLS Certificates configured with automated auto-renewal (Cert-Manager/ACM) | [ ] Yes | Expiry date checked | SRE Lead |

---

## 3. Observability, Telemetry & Alerting

| Verification Item | Status (Yes/No/NA) | Evidence / Reference Link | Reviewed By |
|---|---|---|---|
| Centralized logging operational with JSON format & correlation IDs | [ ] Yes | Datadog / CloudWatch Logs | SRE Lead |
| Core application metrics dashboard active (Traffic, Latency, Errors, Saturation) | [ ] Yes | Dashboard URL | Ops Lead |
| High-priority P1/P2 alerts integrated with PagerDuty / Opsgenie | [ ] Yes | Test alert triggered & confirmed | Ops Lead |
| Health endpoints `/health/live` and `/health/ready` monitored | [ ] Yes | Uptime monitor active | SRE Lead |

---

## 4. Disaster Recovery & Continuity

| Verification Item | Status (Yes/No/NA) | Evidence / Reference Link | Reviewed By |
|---|---|---|---|
| Automated daily database snapshots configured with retention policy (30 days) | [ ] Yes | RDS automated snapshot verified | DBA Lead |
| Point-In-Time-Recovery (PITR) successfully tested on replica | [ ] Yes | PITR restore completed in <20 mins | SRE Lead |
| Recovery Time Objective (RTO < 30 mins) and RPO (< 5 mins) validated | [ ] Yes | DR Test Report | Ops Lead |

---

## 5. Support Model & Escalation Protocol

| Verification Item | Status (Yes/No/NA) | Evidence / Reference Link | Reviewed By |
|---|---|---|---|
| Severity level definitions and SLA targets agreed | [ ] Yes | `docs/ops/SLA_MATRIX.md` | Account Mgr |
| Hypercare daily standup scheduled for the first [14/30] days | [ ] Yes | Calendar invite accepted | Dev Lead |
| Tier 3 engineering escalation roster published in PagerDuty | [ ] Yes | PagerDuty schedule URL | Dev Lead |

---

## 6. Handover Sign-Off & Acceptance

### Formal Statement:
The Operations / SRE team confirms that the service has met the production readiness criteria outlined above. The team formally accepts operational responsibility for the service in accordance with the agreed SLA and Hypercare charter.

**Delivering Tech Lead:**
Signature: _____________________________________________  
Name: [Engineering Lead Name]  
Date: ________________________  

**Receiving Operations Lead:**
Signature: _____________________________________________  
Name: [Operations / SRE Director Name]  
Date: ________________________  

**Client / Executive Sponsor:**
Signature: _____________________________________________  
Name: [Client Account Sponsor Name]  
Date: ________________________  

