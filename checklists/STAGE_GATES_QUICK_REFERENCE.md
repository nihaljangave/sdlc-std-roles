# SDLC Stage-Gate Quick Reference Checklist

Use this checklist during sprint gate reviews to ensure all required formalities and artifacts are ready before passing to the next stage. Each review is designed to take under 15 minutes.

---

## Gate 0: Scoping & Project Charter Review
**Primary Approver:** Product Owner & Client Sponsor

- [ ] Problem statement and target business outcomes clearly stated.
- [ ] MoSCoW prioritization defined (Must-Have vs Out-of-Scope).
- [ ] Technical feasibility spike completed with no critical roadblocks.
- [ ] Project Charter / SOW approved by Client Sponsor.
- [ ] Baseline PRD committed to git repository (`docs/PRD.md`).

---

## Gate 1: Architecture, Security & Contract Review
**Primary Approver:** Lead Architect, Security Lead & Ops Lead

- [ ] System Architecture Document (SAD) with C4 diagrams committed to repo.
- [ ] API Contract (OpenAPI 3.0 / Protobuf) published with mock server live.
- [ ] Architecture Decision Records (ADRs) recorded for major tech stack choices.
- [ ] Security & Data Privacy checklist reviewed (zero unmitigated high-risk items).
- [ ] Target cloud infrastructure topology and operational SLOs agreed with Ops.

---

## Gate 2: Feature Complete & Code Freeze (Build Gate)
**Primary Approver:** Technical Lead & QA Lead

- [ ] All in-scope user stories implemented and merged via Pull Requests.
- [ ] Every PR satisfied Definition of Done (DoD) checklist.
- [ ] Unit & integration test coverage >= 80% on business logic; all CI tests green.
- [ ] Automated security scan (SAST / SCA) passes with zero Critical/High CVEs.
- [ ] Staging environment deployed with latest release candidate tag.
- [ ] Living documentation, schemas, and changelogs automatically updated.

---

## Gate 3: Production Readiness & Client Acceptance (Go/No-Go Gate)
**Primary Approver:** QA Lead, Client Authorized Sponsor & Ops Lead

- [ ] Master test execution completed (Functional, E2E, Load, DAST).
- [ ] Zero open Severity 1 (Blocker) or Severity 2 (Major) defects.
- [ ] Client UAT completed; all client-executed test cases passed.
- [ ] **Formal Client UAT Sign-off Certificate signed by Client Sponsor.**
- [ ] Formal Go/No-Go vote unanimous across PM, Tech Lead, QA, and Ops.

---

## Gate 4: Production Release & Operations Handover
**Primary Approver:** DevOps / SRE Lead & Delivering Tech Lead

- [ ] Pre-deployment review verified (secrets in Vault/AWS Secrets Manager, DB migrations dry-run).
- [ ] Production deployment executed via Blue/Green or Canary with zero downtime.
- [ ] Synthetic Production Verification Tests (PVT) passed.
- [ ] Production monitoring, alerts, and APM dashboards active and verified.
- [ ] Operations Runbook verified by receiving Ops/SRE engineers.
- [ ] **Service Transition Checklist formally executed and signed.**

---

## Gate 5: Steady-State Transition & Warranty Exit
**Primary Approver:** Client Account Sponsor & Operations Director

- [ ] System operated within agreed SLA targets (>= 99.9% uptime) during Hypercare.
- [ ] Blameless post-mortems completed for any incidents with preventative tickets logged.
- [ ] Post-launch teething bugs resolved and triaged.
- [ ] Handover to 24/7 steady-state operations complete; dev team stands down from daily on-call.
- [ ] Final Warranty Acceptance signed.

