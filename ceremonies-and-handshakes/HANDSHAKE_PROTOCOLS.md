# Inter-Role Handshake Protocols & Transition Criteria

In fast-paced product development, delays and quality failures almost always occur at the **transitions between roles**. These six Handshake Protocols eliminate ambiguity by establishing explicit inputs, required artifacts, and acceptance criteria for every handoff.

---

## Handshake 1: Product Owner ➔ Technical Lead (Scoping Handshake)
*Occurs during Stage 0 prior to Gate 0.*

- **Delivering Role:** Product Owner / PM
- **Receiving Role:** Technical Lead / Architect
- **Handoff Artifacts:**
  1. Draft PRD with MoSCoW scoping ([`templates/PRD_TEMPLATE.md`](../templates/PRD_TEMPLATE.md)).
  2. Draft SOW & Project Charter ([`templates/PROJECT_CHARTER_AND_SOW.md`](../templates/PROJECT_CHARTER_AND_SOW.md)).
- **Receiving Acceptance Criteria:**
  - [ ] Business objectives and KPIs are quantitatively defined.
  - [ ] Must-Have vs Won't-Have scope is delineated (no vague open-ended asks).
  - [ ] Client budget and timeline expectations align with initial engineering estimation.
  - [ ] Technical feasibility spike completed with no blocking technical risks.

---

## Handshake 2: Technical Lead ➔ Software Engineers (Design Handshake)
*Occurs during Stage 1 prior to Gate 1.*

- **Delivering Role:** Technical Lead / Architect
- **Receiving Role:** Software Engineering Team
- **Handoff Artifacts:**
  1. System Architecture Document ([`templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md`](../templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md)).
  2. Contract-First API Specification ([`templates/API_CONTRACT_AND_INTEGRATION_SPEC.md`](../templates/API_CONTRACT_AND_INTEGRATION_SPEC.md)).
  3. Working Local Environment Scaffold (`docker compose up` functioning).
  4. Architecture Decision Records (ADRs) recorded.
- **Receiving Acceptance Criteria:**
  - [ ] API mock server is live and responsive for frontend/client decoupling.
  - [ ] Database schemas and migration strategies are approved.
  - [ ] Developers can spin up the full local development stack in < 10 minutes.

---

## Handshake 3: Software Engineer ➔ QA Engineer (Feature Delivery Handshake)
*Occurs continuously throughout Stage 2 on every Pull Request.*

- **Delivering Role:** Software Engineer
- **Receiving Role:** QA Engineer
- **Handoff Artifacts:**
  1. Pull Request satisfying the **Definition of Done** ([`templates/DEFINITION_OF_DONE_AND_CODE_REVIEW.md`](../templates/DEFINITION_OF_DONE_AND_CODE_REVIEW.md)).
  2. Ephemeral preview environment link or Staging deployment URL.
  3. Inline test documentation and seed data instructions.
- **Receiving Acceptance Criteria:**
  - [ ] All automated unit & integration tests green in CI pipeline (coverage >= 80%).
  - [ ] Zero un-sanitized inputs or hardcoded secrets.
  - [ ] Feature verified against acceptance criteria on preview environment.

---

## Handshake 4: QA & Product Owner ➔ Client Sponsor (UAT Handshake)
*Occurs at the beginning of Stage 3.*

- **Delivering Roles:** QA Lead & Product Owner
- **Receiving Role:** Client Sponsor / Client Testing Team
- **Handoff Artifacts:**
  1. Master Test Plan & Client UAT Register ([`templates/TEST_PLAN_AND_UAT_SIGNOFF.md`](../templates/TEST_PLAN_AND_UAT_SIGNOFF.md)).
  2. Stable Staging/UAT Environment with sanitized demo data.
  3. Step-by-step UAT execution scripts linked to PRD user stories.
- **Receiving Acceptance Criteria:**
  - [ ] Client test team has active credentials and environment access.
  - [ ] Client UAT walkthrough completed on Day 1.
  - [ ] Defect severity rules (P1–P4) agreed to in writing.

---

## Handshake 5: Engineering & QA ➔ Operations / SRE Lead (Service Transition Handshake)
*Occurs during Stage 4 prior to Gate 4.*

- **Delivering Roles:** Technical Lead & QA Lead
- **Receiving Role:** DevOps, SRE & Operations Lead
- **Handoff Artifacts:**
  1. Signed **Client UAT Sign-off Certificate**.
  2. **Operations Runbook** ([`templates/OPERATIONS_RUNBOOK.md`](../templates/OPERATIONS_RUNBOOK.md)) with SOPs and recovery steps.
  3. **Deployment & Rollback Guide** ([`templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md`](../templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md)).
  4. Executed **Service Transition Checklist** ([`templates/SERVICE_TRANSITION_CHECKLIST.md`](../templates/SERVICE_TRANSITION_CHECKLIST.md)).
- **Receiving Acceptance Criteria:**
  - [ ] Infrastructure-as-Code (Terraform) verified in production environment.
  - [ ] Secrets stored securely in Secrets Manager (zero plaintext).
  - [ ] Monitoring, alerting, and APM dashboards operational and tested.
  - [ ] Database backup and Point-In-Time-Recovery (PITR) dry-run verified.

---

## Handshake 6: Operations Lead ➔ Product & Engineering (Feedback & Hypercare Handshake)
*Occurs throughout Stage 5 (Hypercare & Steady-State).*

- **Delivering Role:** Operations / SRE Lead
- **Receiving Roles:** Product Owner & Technical Lead
- **Handoff Artifacts:**
  1. Blameless Post-Mortems & 5-Whys RCAs ([`templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md`](../templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md)).
  2. Weekly SLA & Error Budget consumption reports.
  3. Production telemetry and performance bottleneck insights.
- **Receiving Acceptance Criteria:**
  - [ ] Corrective and Preventative Actions (CAPA) converted to backlog tickets.
  - [ ] Error budgets respected; feature work paused if budget is exhausted.
  - [ ] Final **Warranty Acceptance Sign-Off** executed to transition to steady-state.

