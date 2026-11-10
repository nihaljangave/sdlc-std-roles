# Scope Change Request Form (CR)

| Metadata | Details |
|---|---|
| **Change Request ID** | CR-[000] |
| **Project Title** | [Project Name] |
| **Requester Name** | [Client / Product Owner Name] |
| **Date Submitted** | YYYY-MM-DD |
| **Target Decision Date** | YYYY-MM-DD (SLA: 48 Hours) |
| **Current Project Stage** | `Stage 1 (Architecture)` \| `Stage 2 (Build)` \| `Stage 3 (UAT)` |

---

## 1. Description of Proposed Change
*Describe clearly what is being changed, added, or removed compared to the agreed Project Charter & Scope Baseline:*
- **Feature / Component Affected:** [e.g., Checkout module, User permissions, Reporting engine]
- **Proposed Modification:** [Detailed description of the change]
- **Business Justification:** [Why is this change needed now rather than in post-launch v1.1?]

---

## 2. Technical & Architectural Impact Assessment
*To be completed by Technical Lead within 24 hours:*

- **Architectural Complexity:** `Low` \| `Medium` \| `High`
- **Impacted Systems / APIs:** [List microservices, third-party integrations, database schema modifications]
- **Security / Compliance Impact:** [Does this introduce new PII, new third-party risks, or regulatory compliance implications?]
- **Technical Risk Evaluation:** [Risk of regression, impact on existing test automation]

---

## 3. Timeline & Resource Impact

| Parameter | Current Baseline | Revised Projection with CR | Variance (+/-) |
|---|---|---|---|
| **Engineering Effort** | [X] Story Points / [Y] Days | [X + Δ] Story Points | +[Δ] Story Points |
| **Target UAT Date** | YYYY-MM-DD | YYYY-MM-DD | +[N] Days |
| **Production Release Date**| YYYY-MM-DD | YYYY-MM-DD | +[N] Days |
| **Budget / Commercial Impact**| Fixed / In-Scope | Commercial adjustment | [+$ / Neutral] |

### Trade-Off Recommendation:
- [ ] **Option A (Add & Extend):** Accept the change and extend release target date by `[N]` days.
- [ ] **Option B (Scope Swap):** Accept the change, keep release date fixed, and deprioritize `[Specific Should-Have Story]` to v1.1.
- [ ] **Option C (Defer to v1.1):** Defer change to post-production backlog to protect current release date.

---

## 4. Formal Review & Authorization

### Decision Status:
`[ ] APPROVED` &nbsp;&nbsp;&nbsp;&nbsp; `[ ] APPROVED WITH CONDITIONS` &nbsp;&nbsp;&nbsp;&nbsp; `[ ] REJECTED / DEFERRED`

### Authorizing Signatures:

**Client Authorized Sponsor:**
Signature: _____________________________________________  
Name: [Client Signatory Name]  
Date: ________________________  

**Delivery Project Director / Tech Lead:**
Signature: _____________________________________________  
Name: [Delivery Signatory Name]  
Date: ________________________  

