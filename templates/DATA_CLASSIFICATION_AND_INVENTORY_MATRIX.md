# Data Classification & Inventory Matrix Template

> **Document Status:** Active Compliance Register  
> **System Name:** [System Name] &bull; **Data Protection Officer (DPO):** [DPO Name]  
> **Target Standard:** ISO 27001 Annex A.8, GDPR Article 30 (Record of Processing Activities), SOC 2 CC6.7  
> **Last Audit Date:** YYYY-MM-DD

---

## 1. Data Classification Tiers & Handling Standards

| Classification Tier | Definition & Examples | Encryption at Rest | Encryption in Transit | Access Controls | Retention Limit |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Tier 1: Public** | Marketing content, public docs, API schemas. | Optional | TLS 1.3 | Public Read | Indefinite |
| **Tier 2: Internal** | System telemetry, aggregated analytics, internal Jira tasks. | AES-256 (Default Cloud) | TLS 1.3 | Authenticated Employees (SSO) | 1 Year |
| **Tier 3: Confidential** | Customer contracts, commercial pricing, source code. | AES-256 (KMS Managed) | TLS 1.3 + mTLS | Need-to-know RBAC | 7 Years (Statutory) |
| **Tier 4: Restricted (PII / ePHI / PCI)** | Passwords, SSN, health records, card tokens, personal emails. | AES-256 (Customer Managed Key CMK) + Field Encryption | TLS 1.3 + HSTS | Strict Zero-Trust + Hardware MFA + Audit Logged | Per Privacy Policy / GDPR erasure |

---

## 2. System Data Inventory & Processing Register (GDPR Art. 30)

| Data Asset Ref | Data Elements Contained | Classification Tier | Storage Engine & Region | Encryption Key Ref | Legal Basis for Processing | Retention Policy | Cross-Border Transfer? |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **DA-01: User Accounts** | Full Name, Email, Password Hash (Argon2id), Tenant ID | Tier 4: Restricted | Aurora PostgreSQL (`us-east-1`) | `alias/user-data-key` (AWS KMS) | Contract Performance (Art. 6.1b) | Active + 30 days post-deletion | No (Local region) |
| **DA-02: Payment Tokens** | Stripe Customer ID (`cus_...`), Payment Method Token (`pm_...`), Last 4 Digits | Tier 4: Restricted | Aurora PostgreSQL (`us-east-1`) | `alias/billing-data-key` (AWS KMS) | Contract Performance (Art. 6.1b) | 7 Years (Financial Audit) | Yes (Stripe USA / EU Standard Contractual Clauses) |
| **DA-03: Application Telemetry** | Request IP (Anonymized), User-Agent, Latency, Endpoint | Tier 2: Internal | Datadog Logs (`us-east-1`) | Provider Managed | Legitimate Interest (Art. 6.1f) | 30 Days Rolling Purge | No |
| **DA-04: User File Uploads** | Profile Avatars, Document Attachments, Invoices | Tier 3: Confidential | AWS S3 Bucket with Object Lock | `alias/s3-storage-key` (AWS KMS) | User Consent & Contract | Active Subscription | No |

---

## 3. Data Protection Impact Assessment (DPIA) Triggers

A formal Data Protection Impact Assessment (DPIA) is mandatory before deploying any feature that involves:
- [ ] Systematic and extensive automated profiling or decision-making (e.g. AI-driven credit scoring or hiring).
- [ ] Large-scale processing of special categories of data (health data, biometrics, religious/political beliefs).
- [ ] Systematic monitoring of publicly accessible areas on a large scale.
- [ ] Implementation of novel AI/LLM models that ingest unstructured user inputs.

---

## 4. DPO & Legal Sign-off

| Role | Signatory Name | Signature | Date |
| :--- | :--- | :--- | :--- |
| **Data Protection Officer (DPO)** | [Name] | [Signed] | YYYY-MM-DD |
| **Lead System Architect** | [Name] | [Signed] | YYYY-MM-DD |
| **Client Compliance Sponsor** | [Name] | [Signed] | YYYY-MM-DD |
