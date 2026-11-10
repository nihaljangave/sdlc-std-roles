## Pull Request Details
- **Issue / Ticket Reference:** #[TICKET_NUMBER]
- **Type of Change:**
  - [ ] `feat`: New feature / user story implementation
  - [ ] `fix`: Bug fix / defect resolution
  - [ ] `perf`: Performance optimization
  - [ ] `refactor`: Code refactoring without behavior change
  - [ ] `docs`: Documentation update
  - [ ] `infra`: CI/CD, Docker, or build configuration
- **Short Summary:** [Brief 2-3 sentence overview of what changed and why]

---

## 1. Functional & Acceptance Verification
- [ ] Code strictly satisfies the acceptance criteria defined in the ticket.
- [ ] Edge cases, null checks, boundary conditions, and invalid inputs are handled.
- [ ] UI changes (if any) match Figma designs and are responsive across viewports.

---

## 2. Automated Testing & Quality
- [ ] Unit tests added / updated for new business logic.
- [ ] Integration tests verify database interactions or third-party API adapters.
- [ ] All automated tests pass locally (`npm test` / `pytest` / `go test`).
- [ ] Code coverage meets or exceeds the **80% threshold** on core business logic.

---

## 3. Living Documentation-as-Code Embedded
- [ ] Public API methods, classes, and exported types are documented with docstrings / JSDoc.
- [ ] OpenAPI / Swagger annotations updated (or `openapi.yaml` synced).
- [ ] `README.md` updated if new environment variables or local setup steps were introduced.
- [ ] [ADR Submitted](templates/ARCHITECTURE_DECISION_RECORD_ADR.md) if introducing a new architectural pattern or external dependency.

---

## 4. Security & Compliance Guardrails
- [ ] Zero plain-text secrets, API keys, or private tokens committed (verified via TruffleHog / GitGuardian).
- [ ] Inputs validated and sanitized against injection (SQL, XSS, SSRF).
- [ ] Authorization / RBAC checks verified on backend endpoints (not UI-only).
- [ ] Dependency audit clean (zero new Critical/High CVEs).

---

## 5. Operations & Telemetry Readiness
- [ ] Structured JSON logging added for key state changes and failure modes.
- [ ] Standard correlation ID (`trace_id` / `request_id`) propagated in all logs.
- [ ] Database migrations are backward-compatible (expand/contract tested).
- [ ] Database queries verified to use existing indexes (no un-indexed table scans).

---

## Screenshots / Preview Verification (If Applicable)
*Paste screenshots, screen recording (Loom/GIF), or ephemeral preview environment URL below:*
- Preview URL: `https://pr-[PR_NUMBER].preview.internal.net`

