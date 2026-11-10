---
marp: true
theme: default
paginate: true
header: "Project Steering Committee &bull; Weekly Executive Sync"
footer: "Confidential &bull; Delivery Governance Standard"
style: |
  section {
    font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
    color: #1e293b;
    background-color: #f8fafc;
    padding: 2.5rem 3rem;
  }
  h1 { color: #1e1b4b; font-size: 2.2rem; margin-bottom: 0.5rem; }
  h2 { color: #4338ca; font-size: 1.6rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.4rem; }
  table { width: 100%; border-collapse: collapse; font-size: 0.85rem; margin-top: 1rem; }
  th { background-color: #e0e7ff; color: #3730a3; padding: 0.6rem; text-align: left; }
  td { padding: 0.55rem; border-bottom: 1px solid #cbd5e1; }
  .badge-green { background: #dcfce7; color: #166534; padding: 0.2rem 0.6rem; border-radius: 9999px; font-weight: bold; }
  .badge-yellow { background: #fef9c3; color: #854d0e; padding: 0.2rem 0.6rem; border-radius: 9999px; font-weight: bold; }
  .badge-red { background: #fee2e2; color: #991b1b; padding: 0.2rem 0.6rem; border-radius: 9999px; font-weight: bold; }
---

# Weekly Steering Committee
## Project: [Project / Client Name]

**Reporting Period:** [Week Number, e.g. Week 42 (Oct 14 - Oct 20, 2026)]  
**Delivery Lead:** [Lead Name] &bull; **Client Sponsor:** [Client Executive Name]  
**Overall Project Health:** <span class="badge-green">ON TRACK (GREEN)</span>

---

## Slide 1: Executive Status & Milestone Burn-Up

| Core Milestone | Target Gate | SOW Baseline Date | Forecast Date | Status |
| :--- | :--- | :--- | :--- | :--- |
| **M1: Discovery & Architecture Sign-off** | Gate 0 & 1 | YYYY-MM-DD | YYYY-MM-DD | <span class="badge-green">COMPLETED</span> |
| **M2: Core API & Data Ingestion Engine** | Gate 2 | YYYY-MM-DD | YYYY-MM-DD | <span class="badge-green">COMPLETED</span> |
| **M3: Admin Portal & Client UAT Kickoff** | Gate 3 | YYYY-MM-DD | YYYY-MM-DD | <span class="badge-green">IN PROGRESS</span> |
| **M4: Production Cutover & Handover** | Gate 4 | YYYY-MM-DD | YYYY-MM-DD | <span class="badge-yellow">PLANNED</span> |

**Key Highlights This Week:**
- Completed 100% of Sprint [N] commitments (48 story points delivered).
- Automated CI pipeline passing with 88.4% unit & integration test coverage.
- Staging environment provisioned and seeded with synthetic test data.

---

## Slide 2: Scope, Budget & Velocity Metrics

```
Sprint Velocity (Story Points):
Sprint 1: [36 pts] ██████████
Sprint 2: [42 pts] ████████████
Sprint 3: [48 pts] ██████████████ (Peak)
Sprint 4: [45 pts] █████████████ (Forecast)
```

**Financial Budget & Effort Consumption:**
- **Approved SOW Hours:** 800 Hours ($120,000 USD)
- **Burned to Date:** 410 Hours ($61,500 USD &bull; 51.2% burned)
- **Milestone Progress:** 55% completed (Tracking ahead of budget curve)
- **Open Change Requests:** 1 pending review ($4,800 / 32 hours)

---

## Slide 3: Key Decisions Required from Client Sponsor

The following decisions require executive approval to protect the project critical path:

1. **Third-Party Payment Gateway Credentials (Decision #DEC-04):**
   - *Issue:* Staging webhook verification requires client Stripe sandbox secret keys.
   - *Impact:* Blocks end-to-end checkout automation test suite.
   - *Required Action:* Client IT Security to issue credentials by **Wednesday 17:00 UTC**.

2. **Phase 2 Scope Prioritization (Decision #DEC-05):**
   - *Issue:* Client requested CSV Bulk Order Import capability.
   - *Recommendation:* Adopt 1-in, 1-out trade-off: swap out PDF Report Generator to protect Nov 1 launch date.

---

## Slide 4: Risk & Blocker Escalation Matrix

| Risk ID | Description | Impact | Probability | Mitigation Strategy | Owner |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **RSK-01** | Client single sign-on (SSO) SAML endpoint metadata delayed. | High | Medium | Engineering configured mock Okta IdP in staging to continue frontend integration without delay. | Client IT Lead |
| **RSK-02** | External ERP API rate limit throttling during batch load test. | Medium | High | Implemented Redis caching layer and exponential backoff retry queue. | Tech Lead |

---

## Slide 5: Lookahead — Next 2 Weeks Roadmap

```mermaid
gantt
    title Next 2-Week Delivery Sprint Roadmap
    dateFormat  YYYY-MM-DD
    section Sprint N+1
    Finish UAT Test Suite        :done, 2026-10-21, 3d
    Security Pentest Remediation :active, 2026-10-24, 4d
    section Gate 3 Sign-Off
    Client UAT Execution Window  :crit, 2026-10-28, 5d
    Production Dry-Run Rehearsal :2026-11-02, 2d
    Service Transition Review    :2026-11-04, 1d
```

**Next Steering Committee:** [Date & Time] &bull; *Questions & Open Discussion*

