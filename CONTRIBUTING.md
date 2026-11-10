# Contributing to the Lean-Enterprise SDLC Operating System

Thank you for contributing to the Lean-Enterprise SDLC Operating System! This document outlines the process for proposing enhancements, authoring new governance playbooks, modifying stage gates, and submitting Pull Requests.

---

## 1. Principles of Contribution

1. **Doc-as-Code & Automation First:** Every new process or governance rule must be accompanied by an automated CLI check, template, or CI status check. Never propose process overhead that cannot be checked programmatically.
2. **Lean & Pragmatic:** Optimize for high development velocity in prototypes and MVPs without creating bureaucratic drag.
3. **Client & Operations Alignment:** Every deliverable must serve a dual purpose: enabling fast engineering iteration while providing legal/commercial assurance for client sign-offs and Day-2 operational handover.

---

## 2. Proposing Architectural or Process Changes (ADR First)

If proposing a substantial architectural shift, new compliance standard, or change to the Stage-Gate matrix:
1. Copy [`templates/ARCHITECTURE_DECISION_RECORD_ADR.md`](./templates/ARCHITECTURE_DECISION_RECORD_ADR.md) to `docs/adr/ADR-XXX-title.md`.
2. Fill out Context, Decision, Consequences, and Alternatives considered.
3. Update the [ADR Living Registry](./docs/adr/README.md).
4. Submit a Pull Request with the label `adr`.

---

## 3. Git Workflow & Conventional Commits

We follow a strict **Conventional Commits** specification:

```text
<type>(<scope>): <short description in present imperative tense>

[optional body explaining motivation and context]

[optional footer referencing issues or breaking changes]
```

### Allowed Types
- `feat`: A new process guide, template, script capability, or compliance standard.
- `fix`: A correction to a playbook, link, script bug, or typo.
- `docs`: Documentation updates, README changes, or slide adjustments.
- `refactor`: Restructuring directory layouts or script consolidation without functional change.
- `ci`: Changes to GitHub Actions workflows, pre-commit hooks, or test runners.
- `chore`: Routine housekeeping, license updates, or dependency version bumps.

---

## 4. Local Testing & Verification

Before submitting a Pull Request, verify your changes locally:

```bash
# 1. Install local git hooks (enforces secrets scan and commit messages)
./scripts/sdlc-cli.sh hooks

# 2. Run the master stage-gate auditor against the framework repository
./scripts/sdlc-cli.sh audit all .

# 3. Preview documentation portal (if mkdocs is installed)
./scripts/sdlc-cli.sh portal
```

---

## 5. Pull Request Checklist

When opening a Pull Request:
- [ ] PR title follows Conventional Commits format (e.g. `feat(compliance): add ISO 27001 mapping`).
- [ ] PR description uses the standard [Pull Request Template](./.github/pull_request_template.md).
- [ ] All shell scripts have executable permissions (`chmod +x scripts/*.sh`).
- [ ] Any newly introduced templates are indexed in [`README.md`](./README.md), [`mkdocs.yml`](./mkdocs.yml), and [`index.html`](./index.html).
- [ ] GitHub Actions CI compliance status checks pass with green status.

