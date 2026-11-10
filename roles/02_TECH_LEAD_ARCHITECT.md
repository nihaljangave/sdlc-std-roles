# Standard Role Playbook: Technical Lead & System Architect

| Role Profile | Details |
|---|---|
| **Role Title** | Technical Lead & System Architect |
| **Primary Accountability** | Technical Strategy, Architecture Integrity, Code Quality & Non-Functional SLOs |
| **Key Collaborators** | Product Owner, Software Engineers, Security Lead, DevOps/SRE Lead |
| **Primary Gate Ownership**| Gate 1 (Architecture & Security) & Gate 2 (Code Freeze / Quality) |

---

## 1. Core Mission & Objectives
The Tech Lead / Architect designs the blueprint of the system and guarantees its scalability, resilience, and security. They eliminate guesswork for software engineers by defining clean abstractions, contract-first APIs, and strict quality guardrails, ensuring that code is written cleanly and documented continuously.

---

## 2. Responsibilities by SDLC Stage

### Stage 0: Discovery & Scoping
- Lead the 2–3 day **Technical Feasibility Spike** on unknown dependencies or complex integrations.
- Estimate technical effort, cloud resource cost, and operational footprint.
- Review and sign off on technical feasibility in the Project Charter.

### Stage 1: Architecture & System Design
- Author the **System Architecture Document (SAD)** incorporating C4 diagrams (Context & Container levels).
- Define the **Contract-First API Specification** (OpenAPI / Swagger 3.0) and mock server.
- Author **Architecture Decision Records (ADRs)** for every major technical decision.
- Conduct threat modeling and complete the **Security & Data Privacy Checklist**.
- Secure architectural sign-off to pass **Gate 1**.

### Stage 2: Development & Build
- Enforce the **Definition of Done (DoD)** across all Pull Requests.
- Conduct high-level architecture reviews on critical PRs (core domain models, DB migrations, security-sensitive logic).
- Ensure test coverage >= 80% on business logic and resolve technical debt proactively.
- Monitor CI/CD build health, ensuring builds complete in < 10 minutes.

### Stage 3: Verification & Client UAT
- Lead the technical triage of defects alongside QA Lead.
- Resolve any architectural bottlenecks surfaced during performance or stress testing.
- Review third-party penetration test and vulnerability assessment reports; patch critical CVEs.

### Stage 4: Release & Ops Handover
- Co-author the **Deployment & Rollback Guide** with the DevOps/SRE Lead.
- Conduct the formal **Architecture & Troubleshooting Walkthrough** with the Operations team.
- Validate database migration backward compatibility (Expand/Contract pattern).
- Co-sign the **Service Transition Checklist** to pass **Gate 4**.

### Stage 5: Post-Production & Hypercare
- Act as Tier 3 Engineering Escalation for P1/P2 production incidents.
- Lead the technical investigation during blameless post-mortems (5 Whys).
- Translate post-mortem corrective actions into preventative backlog tasks.

---

## 3. Essential Artifacts Owned

| Artifact Name | Template Reference | Frequency |
|---|---|---|
| **System Architecture Document (SAD)** | [`templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md`](../templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md) | Initial build + major architectural changes |
| **Architecture Decision Records (ADRs)** | [`templates/ARCHITECTURE_DECISION_RECORD_ADR.md`](../templates/ARCHITECTURE_DECISION_RECORD_ADR.md) | Whenever a significant tech decision is made |
| **API Contract & Schema** | [`templates/API_CONTRACT_AND_INTEGRATION_SPEC.md`](../templates/API_CONTRACT_AND_INTEGRATION_SPEC.md) | Maintained continuously in git |
| **Security & Privacy Review** | [`templates/SECURITY_AND_DATA_PRIVACY_CHECKLIST.md`](../templates/SECURITY_AND_DATA_PRIVACY_CHECKLIST.md) | Prior to Gate 1 and production release |
| **Service Transition Checklist** | [`templates/SERVICE_TRANSITION_CHECKLIST.md`](../templates/SERVICE_TRANSITION_CHECKLIST.md) | Gate 4 handover |

---

## 4. Key Performance Indicators (KPIs)
- **Technical Debt Ratio:** < 5% of sprint velocity spent on unplanned rework.
- **API Contract Drift:** Zero breaking schema changes without backward-compatible versioning.
- **CI Build Reliability:** CI pipeline pass rate > 95% on `main`.
- **System SLO Compliance:** p95 latency < 300ms, availability >= 99.9%.

