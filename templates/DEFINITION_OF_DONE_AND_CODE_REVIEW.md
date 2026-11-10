# Definition of Done (DoD) & Code Review Checklist

This checklist defines the non-negotiable quality and documentation bar for any code merged into release branches. It doubles as the standard Pull Request (PR) description template.

---

## 1. Developer Pull Request (PR) Checklist

Every Pull Request description must include the following completed checklist:

```markdown
### PR Details
- **Ticket / Issue Ref:** #[TICKET_ID]
- **Type of Change:** [ ] Feature | [ ] Bugfix | [ ] Refactor | [ ] Performance | [ ] Docs
- **Summary of Changes:** [Brief 2-3 sentence explanation]

### 1. Functional & Design Compliance
- [ ] Code strictly implements the acceptance criteria defined in the ticket.
- [ ] No extraneous, unrelated refactoring bundled into this PR.
- [ ] Edge cases, boundary conditions, and error states handled gracefully.

### 2. Testing & Quality Assurance
- [ ] Unit tests added or updated with meaningful assertions.
- [ ] Unit test code coverage meets or exceeds the project standard (>= 80% on business logic).
- [ ] Integration tests verify database interactions, API endpoints, or third-party adapters.
- [ ] All automated tests pass locally and in the CI pipeline without flaky failures.

### 3. Living Documentation Embedded
- [ ] Inline code comments added for non-obvious algorithms, trade-offs, or workarounds.
- [ ] Public API methods, classes, and exported types documented with JSDoc / Docstrings / GoDoc.
- [ ] API schema (OpenAPI / Swagger) updated if endpoints, params, or responses changed.
- [ ] `README.md` or local environment setup updated if new environment variables were introduced.
- [ ] Architecture Decision Record (ADR) submitted if introducing a new library, pattern, or dependency.

### 4. Security & Safety
- [ ] No hardcoded passwords, tokens, API keys, or private certificates.
- [ ] Input parameters validated and sanitized against injection (SQL, XSS, SSRF).
- [ ] User permissions / RBAC verified on the backend route.
- [ ] Dependency audit passed with zero new high/critical CVEs.

### 5. Operational Readiness & Observability
- [ ] Structured JSON logging added for key state changes and failure scenarios.
- [ ] All logs include standard correlation ID (`trace_id` or `request_id`).
- [ ] Database migration scripts are backward-compatible and have been tested against a replica.
- [ ] Database query performance checked (indexes added for newly filtered/joined columns).
```

---

## 2. Peer Code Reviewer Guide

### Reviewer Expectations:
1. **Response Time:** Review PRs within 4 business hours to keep engineering velocity rapid.
2. **Review Scope:**
   - **Architecture:** Does this follow established domain patterns and separation of concerns?
   - **Simplicity:** Is there unnecessary complexity, over-engineering, or premature optimization?
   - **Maintainability:** Can another engineer read and understand this code without asking the author?
   - **Resilience:** What happens if the database connection drops? If the third-party API times out?
3. **Constructive Tone:** Use conventional comments:
   - `praise:` Appreciate clean implementations.
   - `suggestion:` Optional improvements or idiomatic style.
   - `question:` Clarify intent or potential blind spots.
   - `blocker:` Critical issues that must be addressed prior to approval.

---

## 3. Automated Gate Enforcements (CI/CD Rules)
The Git host (GitHub, GitLab, Bitbucket) enforces:
- Branch protection on `main` and `release/*`.
- At least 1 mandatory senior peer review approval.
- Status checks must pass (Lint, Format, Test Suites, Snyk Security Scan, SonarQube Quality Gate).
- No linear history violations; PRs must be cleanly squash-merged or rebased.

