# Cryptographic Inventory & Key Management Plan

> **Document Status:** Active Security Register  
> **System Name:** [System Name] &bull; **CISO / Cryptographic Custodian:** [Custodian Name]  
> **Compliance Target:** PCI DSS v4.0 Req 3.5–3.7, NIST SP 800-57, SOC 2 CC6.7  
> **Last Key Audit Date:** YYYY-MM-DD &bull; **Next Rotation Review:** YYYY-MM-DD

---

## 1. Cryptographic Key Inventory & Usage Register

| Key ID | Purpose & Associated Workload | Cryptographic Algorithm & Key Length | Storage Location (HSM / Cloud KMS) | Creation Date | Expiry / Rotation Date | Primary Key Custodian |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **KEY-01** | Production Aurora DB Storage | AES-256-GCM | AWS KMS (`alias/prod-rds-cmk`) | YYYY-MM-DD | YYYY-MM-DD (Annual) | Cloud Security Lead |
| **KEY-02** | S3 Customer Document Bucket | AES-256-GCM | AWS KMS (`alias/prod-s3-docs`) | YYYY-MM-DD | YYYY-MM-DD (Annual) | Cloud Security Lead |
| **KEY-03** | Public API TLS Certificate | RSA-2048 / SHA-256 | AWS Certificate Manager (ACM) | YYYY-MM-DD | YYYY-MM-DD (90 Days) | DevOps / SRE Lead |
| **KEY-04** | User Auth JWT Signing Key | RS256 / Ed25519 | AWS Secrets Manager (JWKS) | YYYY-MM-DD | YYYY-MM-DD (90 Days) | Lead Backend Architect |
| **KEY-05** | Production SSH Bastion Host | Ed25519 | Hardware Security Key (YubiKey) | YYYY-MM-DD | YYYY-MM-DD (180 Days) | Infrastructure Director |

---

## 2. Key Generation & Dual Control Procedures

Under PCI DSS Req 3.6 and SOC 2 CC6.1, production master key generation requires **split knowledge and dual control**:
- **Dual Control Enforcement:** No single engineer has authorization or ability to generate, export, or revoke root KMS keys independently.
- **Quorum Requirement:** Modifying KMS Key Policies requires multi-party approval via AWS IAM Identity Center and PagerDuty change authorization.

---

## 3. Compromised Key Revocation & Emergency Protocol

If any cryptographic key or private certificate is suspected of being compromised:
1. **Emergency Deactivation:** Custodian disables the key immediately in AWS KMS console:
   ```bash
   aws kms disable-key --key-id <key-id>
   ```
2. **Re-encryption & Rollover:** Decrypt active datasets using the secondary standby key, re-encrypt using a newly provisioned CMK, and revoke the compromised key.
3. **Audit Trail Verification:** Export all AWS CloudTrail KMS API calls (`kms:Decrypt`, `kms:GenerateDataKey`) for the past 30 days to quantify unauthorized access exposure.

---

## 4. Cryptographic Custodian Sign-Off

| Role | Custodian Name | Digital Signature | Date |
| :--- | :--- | :--- | :--- |
| **Chief Information Security Officer (CISO)** | [Name] | [Signed] | YYYY-MM-DD |
| **Principal Security Architect** | [Name] | [Signed] | YYYY-MM-DD |
| **Client Security Delegate** | [Name] | [Signed] | YYYY-MM-DD |

