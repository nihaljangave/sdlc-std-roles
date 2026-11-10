# Standard Role Playbook: Software Engineer (Fullstack / Backend / Frontend)

| Role Profile | Details |
|---|---|
| **Role Title** | Software Engineer (Frontend / Backend / Fullstack) |
| **Primary Accountability** | Feature Delivery, Automated Test Coverage, Clean Code, Inline Documentation |
| **Key Collaborators** | Tech Lead, Peer Engineers, QA Engineer, DevOps Lead |
| **Primary Gate Ownership**| Delivery of Pull Requests satisfying Definition of Done (Stage 2) |

---

## 1. Core Mission & Objectives
The Software Engineer writes clean, self-documenting, well-tested code that satisfies acceptance criteria on the first attempt. By leveraging "Documentation-as-Code" (JSDoc/Docstrings, OpenAPI annotations, automated changelogs), they ensure product documentation stays 100% in sync with code without slowing down feature delivery.

---

## 2. Responsibilities by SDLC Stage

### Stage 1: Architecture & Design
- Review API contracts and database schema designs.
- Set up local development environment using containerized stacks (`docker compose up`).
- Validate mock contracts before writing production logic.

### Stage 2: Development & Build
- Create feature branches adhering to git conventions: `feature/TICKET-short-desc` or `fix/TICKET-short-desc`.
- Write unit tests alongside business logic (aim for >= 80% coverage on core logic).
- Document public functions, data models, and API endpoints using standard docstrings.
- Ensure all commits follow **Conventional Commits** (`feat:`, `fix:`, `docs:`, `perf:`).
- Run pre-commit checks locally (lint, format, test, secret scan) before pushing.
- Submit Pull Requests with a fully checked **Definition of Done (DoD)** checklist.
- Review peer PRs within 4 business hours using constructive review conventions.

### Stage 3: Verification & Client UAT
- Investigate and resolve defects assigned during QA and client UAT.
- Prioritize P1 (Blocker) defects with same-day fixes and regression tests.
- Support QA engineers with test fixtures, seed data, and debugging logs.

### Stage 4: Release & Ops Handover
- Ensure database migrations follow the expand/contract pattern (backward-compatible).
- Verify environment variables and configuration parameters are documented in `README.md`.
- Be available on standby during production deployment windows for PVT verification.

### Stage 5: Post-Production & Hypercare
- Review error logs and telemetry during the hypercare period.
- Implement root-cause fixes identified in blameless post-mortems.

---

## 3. Daily Developer Hygiene Checklist
Every engineer runs through this checklist before submitting code:
- [ ] Code passes linter and type-checker locally with zero errors/warnings.
- [ ] New unit tests added and passing; existing test suite runs green.
- [ ] No secrets, keys, or passwords committed (verified by pre-commit hook).
- [ ] API endpoints annotated so Swagger/OpenAPI docs update automatically.
- [ ] PR description filled out using the standard `.github/pull_request_template.md`.

---

## 4. Key Performance Indicators (KPIs)
- **First-Time PR Pass Rate:** >= 85% of PRs approved with <= 1 revision cycle.
- **Code Coverage:** >= 80% statement and branch coverage on core domain logic.
- **Defect Leakage:** <= 1 defect escaping to QA per 5 user stories.
- **PR Review SLA:** Peer PRs reviewed within 4 business hours.

