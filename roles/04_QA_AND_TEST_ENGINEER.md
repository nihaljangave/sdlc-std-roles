# Standard Role Playbook: QA & Test Automation Engineer

| Role Profile | Details |
|---|---|
| **Role Title** | QA & Test Automation Engineer |
| **Primary Accountability** | Quality Assurance, Test Automation, Defect Management & UAT Facilitation |
| **Key Collaborators** | Product Owner, Software Engineers, Tech Lead, Client Testers |
| **Primary Gate Ownership**| Gate 3 (Quality Assurance & Client UAT Sign-Off) |

---

## 1. Core Mission & Objectives
The QA & Test Automation Engineer ensures that zero critical or high-severity defects reach production. Rather than relying solely on manual testing at the end of a release cycle, they build automated test suites (API, E2E, Regression) that run continuously in CI/CD, and they prepare clear, step-by-step UAT scripts so client acceptance happens swiftly without dispute.

---

## 2. Responsibilities by SDLC Stage

### Stage 1: Architecture & Design
- Review the PRD and API contracts to extract testable scenarios early.
- Define test data requirements and sanitization needs for staging environments.
- Draft the **Master Test Plan** outlining testing scope, environments, and tooling.

### Stage 2: Development & Build
- Build automated API tests (Postman / Newman / REST-assured) validating against OpenAPI schemas.
- Build automated End-to-End (E2E) UI test suites using Playwright or Cypress for critical user paths.
- Test user stories on ephemeral preview environments as soon as PRs are merged.
- Validate test coverage and ensure automated regression suite passes on every staging build.

### Stage 3: Verification & Client UAT
- Execute full regression testing across supported browsers and devices.
- Conduct non-functional tests (Load/Stress via k6, basic security validation via OWASP ZAP).
- Host the **Client UAT Kickoff** session and guide client testers through pre-written test scenarios.
- Log, categorize (P1–P4), and triage all defects in real-time.
- Verify defect fixes and maintain the **Test Summary Report**.
- Secure the signed **Client UAT Sign-Off Certificate** to clear **Gate 3**.

### Stage 4: Release & Ops Handover
- Execute the synthetic **Production Verification Tests (PVT)** immediately following deployment.
- Confirm core business transactions function in the live production environment.
- Authorize deployment completion or trigger immediate rollback if PVT fails.

### Stage 5: Post-Production & Hypercare
- Monitor production error trends and user-reported anomalies during hypercare.
- Convert post-production bugs into automated regression tests to prevent regression recurrence.

---

## 3. Essential Artifacts Owned

| Artifact Name | Template Reference | Frequency |
|---|---|---|
| **Master Test Plan** | [`templates/TEST_PLAN_AND_UAT_SIGNOFF.md`](../templates/TEST_PLAN_AND_UAT_SIGNOFF.md) | Stage 1 through Stage 3 |
| **Automated E2E Test Suite** | Version-controlled in repository (`/tests/e2e`) | Maintained continuously |
| **Defect Register & Triage Log** | Managed in Jira / Bugzilla | Daily during Stage 3 |
| **Client UAT Sign-Off Certificate** | Section 5 of Test Plan Template | Prior to Gate 3 clearance |
| **PVT Smoke Test Suite** | Synthetic automated script (`npm run test:pvt`) | Executed per production release |

---

## 4. Key Performance Indicators (KPIs)
- **Defect Escape Rate to Production:** Zero P1 or P2 defects escaping to production.
- **Automated Regression Coverage:** >= 85% of critical user journeys covered by automated E2E tests.
- **Client UAT Pass Rate:** >= 95% of client-executed test scripts passing on first run.
- **PVT Execution Time:** Production verification completed within 15 minutes post-deployment.

