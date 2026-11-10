# Third-Party Vendor Security Assessment & Sub-Processor Review

> **Document Status:** Formal Vendor Due Diligence Record  
> **Vendor / Sub-Processor Name:** [Vendor Corporate Legal Name]  
> **Assessment Date:** YYYY-MM-DD &bull; **Re-Assessment Due Date:** YYYY-MM-DD  
> **Lead Security Assessor:** [Assessor Name & Title] &bull; **Procurement Lead:** [Lead Name]  
> **Assigned Risk Tier:** [ ] Tier 1 (Mission-Critical / PII) &nbsp; [ ] Tier 2 (Operational SaaS) &nbsp; [ ] Tier 3 (Commodity)  
> **Target Compliance Standard:** SOC 2 Type II (CC9.2), ISO 27001:2022 (A.15), GDPR Art. 28, HIPAA Security Rule  

---

## 1. Vendor Profile & Integration Scope

| Attribute | Assessment Details |
| :--- | :--- |
| **Vendor Corporate Name** | [e.g. Acme Cloud Solutions, Inc.] |
| **Headquarters Location** | [City, Country] |
| **Service Description** | [Brief summary of SaaS product, API integration, or hosted service] |
| **Data Classification Handled** | [ ] Tier 1 (Public) &nbsp; [ ] Tier 2 (Internal) &nbsp; [ ] Tier 3 (Confidential / PII) &nbsp; [ ] Tier 4 (Restricted / ePHI / CHD) |
| **Integration Architecture** | [e.g. Server-to-server REST API via HTTPS / webhook receiver / embedded frontend SDK] |
| **Authentication Standard** | [ ] SAML 2.0 / OIDC SSO &nbsp; [ ] API Key / Secret in Vault &nbsp; [ ] Mutual TLS (mTLS) |
| **Hosting Cloud Provider & Region** | [e.g. AWS us-east-1 and us-west-2] |

---

## 2. Active Sub-Processor Register

List all third-party vendors and cloud providers utilized in this project that process or store customer confidential or personal data:

| Vendor Name | Service Provided | Customer Data Accessed / Processed | Primary Hosting Location | Certifications on File | DPA / BAA Executed? | Risk Tier |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Amazon Web Services (AWS)** | Cloud Infrastructure, Aurora DB, S3 Storage | Customer Application DB, Stored Attachments, System Logs | US-East (N. Virginia), EU (Frankfurt) | SOC 1/2/3, ISO 27001, FedRAMP High, PCI-DSS Level 1 | Yes (Signed DPA + BAA) | Tier 1 |
| **Datadog** | Cloud Monitoring & APM Telemetry | System Metrics, Error Traces, Sanitized Access Logs (No PII) | US (Oregon) | SOC 2 Type II, ISO 27001 | Yes (Signed DPA) | Tier 2 |
| **OpenAI / Anthropic** | Generative AI & Natural Language Inference | User query prompts, document text snippets (Zero Data Retention) | US-East (Ohio) | SOC 2 Type II, HIPAA Compliant API | Yes (Signed DPA with Zero-Retention) | Tier 1 |
| **Auth0 / Okta** | Identity Provider & Authentication | User Emails, Names, Hashed Passwords, MFA Tokens | US-Multi-Region | SOC 2 Type II, ISO 27001, HIPAA Compliant | Yes (Signed DPA) | Tier 1 |
| **[New Vendor Name]** | [Service Description] | [Data Types Handled] | [Hosting Region] | [SOC 2 / ISO] | [Yes / Pending] | [Tier 1/2/3] |

---

## 3. Technical Security Controls Audit Checklist

| Security Domain | Control Requirement | Vendor Compliance Status | Evidence / Verification Notes |
| :--- | :--- | :--- | :--- |
| **SOC 2 Type II Certification** | Clean unqualified opinion covering Security, Availability, and Confidentiality within past 12 months. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | Reviewed report dated YYYY-MM-DD issued by [Auditing Firm]. |
| **Data Encryption at Rest** | AES-256 encryption across all databases, storage volumes, and backups. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | FIPS 140-2 validated encryption confirmed in report. |
| **Data Encryption in Transit** | TLS 1.3 or TLS 1.2 with forward secrecy enforced across all endpoints. Plaintext HTTP disabled. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | SSL Labs Grade A+ verified on public endpoints. |
| **Identity & Access Management** | Mandatory Multi-Factor Authentication (MFA) and SAML SSO integration for all employee accounts. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | MFA enforced across 100% of vendor staff. |
| **Penetration Testing** | Annual third-party penetration test conducted within the last 12 months with zero open Critical/High issues. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | Pentest summary letter reviewed; all findings resolved. |
| **Breach Notification SLA** | Written contractual guarantee to notify client within **24 hours** (Tier 1) of confirmed security incident. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | DPA Section X.X specifies 24-hour notification window. |
| **Business Continuity & DR** | Documented Disaster Recovery Plan with tested RTO < 4 hours and RPO < 1 hour. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | Annual DR drill report verified on YYYY-MM-DD. |
| **Data Return & Destruction** | Contractual obligation to return or cryptographically erase all client data upon contract termination. | [ ] Satisfied &nbsp; [ ] Remediated &nbsp; [ ] N/A | NIST SP 800-88 compliant sanitization certified. |

---

## 4. AI & Machine Learning Vendor Safeguards *(Applicable if Vendor Provides AI/LLM Services)*

- [ ] **Zero Data Retention (ZDR):** Contract explicitly prohibits vendor from storing prompt text or output responses for longer than transient API execution (maximum 30 days for abuse monitoring).
- [ ] **Model Training Prohibition:** Vendor legally affirms customer prompts and enterprise data will **never** be used to train, retrain, fine-tune, or improve foundation models.
- [ ] **Intellectual Property Indemnification:** Commercial agreement includes copyright and IP infringement indemnification covering AI-generated model outputs.
- [ ] **Data Residency Enforcement:** AI inference clusters are guaranteed to execute strictly within designated geographical boundaries (e.g. US or EU).

---

## 5. Risk Assessment Findings & Compensating Controls

### 5.1 Identified Residual Risks
1. *[Risk 1: e.g. Vendor does not currently support custom encryption keys (BYOK); data is encrypted using vendor-managed KMS keys.]*
2. *[Risk 2: e.g. Vendor status page does not provide automated webhook alerting; monitoring relies on RSS feed.]*

### 5.2 Compensating Controls Implemented
1. *[Compensating Control 1: e.g. Client application encrypts sensitive customer PII column values at application layer prior to sending payload to vendor API.]*
2. *[Compensating Control 2: e.g. Synthetic heartbeat monitor established in Datadog to verify vendor API availability independently every 60 seconds.]*

---

## 6. Formal Governance Sign-Off

The undersigned parties have reviewed the third-party security posture, compliance certifications, contractual data protection terms, and architecture integration. Based on this evaluation, the vendor is **[APPROVED / CONDITIONALLY APPROVED / REJECTED]** for production deployment.

| Governance Role | Representative Name | Digital Signature | Approval Date |
| :--- | :--- | :--- | :--- |
| **Chief Information Security Officer (CISO)** | [Name] | [Signed] | YYYY-MM-DD |
| **Lead Systems Architect** | [Name] | [Signed] | YYYY-MM-DD |
| **Legal & Privacy Counsel** | [Name] | [Signed] | YYYY-MM-DD |

---

## 7. Related Framework Standards

- [Third-Party Vendor Risk Management Policy](../docs/compliance/VENDOR_RISK_MANAGEMENT_AND_SUBPROCESSOR_POLICY.md)
- [Data Classification & Inventory Matrix](DATA_CLASSIFICATION_AND_INVENTORY_MATRIX.md)
- [Security & Data Privacy Checklist](SECURITY_AND_DATA_PRIVACY_CHECKLIST.md)
- [SOC 2 Type II Readiness Guide](../docs/compliance/SOC2_TYPE_II_READINESS_GUIDE.md)
- [Cryptographic Inventory & Key Management Plan](CRYPTOGRAPHIC_INVENTORY_AND_KEY_MANAGEMENT_PLAN.md)
