# Lean-Enterprise SDLC: 1-Page Master Cheat Sheet

## The 6 Lifecycle Stages & Essential Artifacts

```
Stage 0: Discovery & Scoping      ➔ docs/PRD.md & docs/PROJECT_CHARTER.md
Stage 1: Architecture & Security  ➔ docs/architecture/SAD.md & docs/api/openapi.yaml
Stage 2: Build & Verification     ➔ .github/pull_request_template.md (DoD >= 80% coverage)
Stage 3: QA & Client Acceptance   ➔ docs/testing/TEST_PLAN_AND_UAT.md (Signed UAT)
Stage 4: Release & Ops Handover   ➔ docs/ops/OPERATIONS_RUNBOOK.md & SERVICE_TRANSITION.md
Stage 5: Post-Prod & Support      ➔ docs/ops/SLA_MATRIX.md & Blameless 5-Whys RCAs
```

---

## 15-Minute Stage Gate Clearance Checklist

| Gate | Approvers | Non-Negotiable Clearance Criteria |
|:---:|---|---|
| **Gate 0** | Product Owner & Client Sponsor | MoSCoW scope locked; feasibility spike passed; SOW signed. |
| **Gate 1** | Tech Lead & Security Officer | C4 architecture approved; contract-first API published; STRIDE review clean. |
| **Gate 2** | Tech Lead & QA Lead | 100% PRs pass Definition of Done; unit/int coverage >= 80%; 0 High/Crit CVEs. |
| **Gate 3** | QA Lead & Client Sponsor | 0 open P1/P2 defects; **Client UAT Sign-off Certificate signed in writing.** |
| **Gate 4** | DevOps Lead & Delivering Lead | Operations Runbook validated; DR drill verified; **Service Transition signed.** |
| **Gate 5** | Operations Lead & Account Director | 14-day Hypercare complete; uptime >= 99.9%; steady-state support active. |

---

## Essential CLI Commands

```bash
# Scaffold new project in 10s:
./scripts/sdlc-cli.sh scaffold ../my-new-mvp

# Audit compliance for Gate 1 or all gates:
./scripts/sdlc-cli.sh audit 1 .
./scripts/sdlc-cli.sh audit all .

# Run synthetic PVT smoke test:
./scripts/sdlc-cli.sh smoke http://localhost:8000

# Generate release notes from git commits:
./scripts/sdlc-cli.sh release v0.9.0 HEAD v1.0.0

# Generate 1-page weekly client flash report:
./scripts/sdlc-cli.sh report "MyProject" 7

# Bundle formal client handover package:
./scripts/sdlc-cli.sh package . ./dist v1.0.0

# Install local git compliance hooks:
./scripts/sdlc-cli.sh hooks
```

---

## Defect Severity Matrix (SLA)
- **P1 (Critical):** Core flow blocked; 0 workaround. **Response: < 15m** &bull; **Fix: < 2h** &bull; War room.
- **P2 (Major):** Core flow degraded; workaround exists. **Response: < 30m** &bull; **Fix: < 4h**.
- **P3 (Minor):** Non-critical bug, cosmetic issue. **Response: < 4h** &bull; Resolved in upcoming sprint.
- **P4 (Trivial):** Typos, minor cosmetic enhancements. **Response: < 24h** &bull; Backlog triage.
