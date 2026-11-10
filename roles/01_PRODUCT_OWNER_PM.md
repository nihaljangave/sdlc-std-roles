# Standard Role Playbook: Product Owner & Project Manager (PO / PM)

| Role Profile | Details |
|---|---|
| **Role Title** | Product Owner / Project Manager (PO / PM) |
| **Primary Accountability** | Product Vision, Scope Baseline, Client Alignment & Acceptance Sign-off |
| **Key Collaborators** | Client Sponsor, Tech Lead, QA Lead, Operations Lead |
| **Primary Gate Ownership**| Gate 0 (Charter Sign-off) & Co-sign Gate 3 (Client Acceptance) |

---

## 1. Core Mission & Objectives
The Product Owner / PM ensures that the team builds the *right product* with maximum speed and zero ambiguity. They serve as the single interface to the client and business leadership, protecting engineering velocity by shielding developers from mid-sprint scope creep and ensuring that every feature has unambiguous acceptance criteria.

---

## 2. Responsibilities by SDLC Stage

### Stage 0: Discovery & Scoping
- Conduct client discovery workshops to extract business drivers and KPIs.
- Apply the **MoSCoW framework** (Must, Should, Could, Won't have) to constrain prototype scope.
- Draft the **Product Requirements Document (PRD)** and **Statement of Work (SOW)** using standard repository templates.
- Secure written sign-off from Client Sponsor to pass **Gate 0**.

### Stage 1: Architecture & Design
- Review the High-Level System Architecture with the Tech Lead to verify alignment with business goals and budget.
- Facilitate client review of UI/UX wireframes and user interaction flows.
- Ensure API contract reflects all user scenarios and edge cases.

### Stage 2: Development & Build
- Own and prioritize the product backlog in Jira/Linear.
- Ensure all user stories satisfy the **Definition of Ready (DoR)** before entering a sprint:
  - User story format (`As a... I want to... So that...`).
  - Gherkin acceptance criteria (`Given... When... Then...`).
  - UI mockups attached (Figma).
  - Dependencies and data schemas identified.
- Run Sprint Demos for client stakeholders; collect structured feedback within 24 hours.

### Stage 3: Verification & Client UAT
- Deliver the **Client UAT Script** and organize kickoff with client testers.
- Triage reported defects daily against the agreed Severity Matrix (P1–P4).
- Secure the formal **Client UAT Sign-off Certificate** to clear **Gate 3**.

### Stage 4: Release & Ops Handover
- Draft client-facing **Release Notes** and user onboarding manuals.
- Ensure business stakeholders and end-user teams are trained.
- Participate in the Go/No-Go decision meeting.

### Stage 5: Post-Production & Hypercare
- Review weekly SLA and incident telemetry with the Operations Lead.
- Feed operational feedback, bug reports, and client enhancement requests back into the backlog.
- Obtain final **Hypercare Exit & Warranty Sign-Off** at the end of the warranty period.

---

## 3. Essential Artifacts Owned

| Artifact Name | Template Reference | Frequency |
|---|---|---|
| **Project Charter & SOW** | [`templates/PROJECT_CHARTER_AND_SOW.md`](../templates/PROJECT_CHARTER_AND_SOW.md) | Once per major release |
| **Product Requirements Document (PRD)** | [`templates/PRD_TEMPLATE.md`](../templates/PRD_TEMPLATE.md) | Living document updated per sprint |
| **Sprint Backlog & Story Cards** | Managed in Jira / Linear | Updated continuously |
| **Client Release Notes** | Auto-generated via Conventional Commits | Per production release |
| **UAT Acceptance Certificate** | [`templates/TEST_PLAN_AND_UAT_SIGNOFF.md`](../templates/TEST_PLAN_AND_UAT_SIGNOFF.md) | Stage 3 Gate |

---

## 4. Key Performance Indicators (KPIs)
- **Scope Creep Rate:** < 10% un-contracted scope additions per release.
- **Client UAT Turnaround:** UAT completed within 5 business days.
- **Story Readiness:** Backlog groomed 2 sprints ahead with 100% acceptance criteria.
- **First-Time Acceptance Rate:** >= 90% of user stories accepted without re-work.

