---
name: Feature Request / User Story
about: Propose a new user story with Definition of Ready (DoR) criteria
title: "feat([module]): [short description]"
labels: ["enhancement", "needs-triage"]
assignees: ""
---

### User Story Statement
**As a** `[target persona / user type]`,  
**I want to** `[perform specific action / capability]`,  
**So that** `[achieve clear business value or efficiency]`.

---

### Context & Business Value
*Explain why this feature is needed and its priority (Must-Have, Should-Have, Could-Have).*

---

### Acceptance Criteria (Gherkin Format)

```gherkin
Scenario: [Successful happy path]
  Given [precondition or user state]
  When [user triggers an action]
  Then [expected system outcome]
  And [additional outcome]

Scenario: [Error or edge case path]
  Given [precondition]
  When [user performs invalid action]
  Then [system gracefully displays error]
```

---

### Non-Functional Requirements (NFRs)
- **Performance:** Response latency < `[X]ms`
- **Security / RBAC:** Accessible only by roles `[e.g., ADMIN, MANAGER]`
- **Telemetry:** Log event `[e.g., user_order_completed]` with customer ID

---

### Definition of Ready (DoR) Gate Checklist
- [ ] Story estimated in story points.
- [ ] UI designs / Figma mockups linked (if applicable).
- [ ] API endpoints and data model changes identified.
- [ ] Third-party dependencies or client credentials available.
