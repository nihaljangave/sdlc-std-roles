---
name: Bug / Defect Report
about: Report a defect with standard SDLC severity classification
title: "fix([module]): [short description of defect]"
labels: ["bug", "needs-triage"]
assignees: ""
---

### Defect Severity Classification
*Select one:*
- [ ] **P1 - Blocker / Critical:** System down, data loss, security flaw, core transaction impossible (blocks release).
- [ ] **P2 - Major:** Core feature broken, but a known manual workaround exists.
- [ ] **P3 - Minor:** Minor functional defect, cosmetic issue with functioning workaround.
- [ ] **P4 - Trivial:** Typos, minor styling alignments, wording suggestions.

---

### Environment Details
- **Environment:** `[Local / Staging / UAT / Production]`
- **Browser & OS:** `[e.g., Chrome 124 on macOS 14.4 / iOS Safari]`
- **App Version / Commit SHA:** `[e.g., v1.0.0-rc2 / sha: 1babc0e]`
- **User Role:** `[e.g., Store Manager / Guest / Admin]`

---

### Steps to Reproduce
1. Navigate to `'...'`
2. Click on `'....'`
3. Input `'....'`
4. See error

---

### Expected vs Actual Behavior
- **Expected:** [What should have happened]
- **Actual:** [What actually happened]

---

### Logs, Correlation IDs & Screenshots
- **Correlation ID (`X-Correlation-ID`):** `[uuid]`
- **Console / Server Error Logs:**
  ```text
  [Paste error trace here]
  ```
- **Screenshots / Video:** [Attach file or link]

---

### Impact Assessment
- Is this blocking Client UAT? `[Yes / No]`
- Are customers actively impacted in Production? `[Yes / No]`
