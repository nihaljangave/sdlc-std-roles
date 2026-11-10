# Security & Data Privacy Review Checklist

| Metadata | Details |
|---|---|
| **System / Application** | [System Name] |
| **Security Reviewer** | [Security Lead / AppSec Engineer] |
| **Tech Lead** | [Name] |
| **Review Date** | YYYY-MM-DD |
| **Review Status** | `Passed` \| `Conditionally Approved (Action Items Required)` \| `Blocked` |
| **Compliance Scope** | `SOC 2` \| `ISO 27001` \| `GDPR` \| `HIPAA` \| `PCI-DSS` |

---

## 1. Authentication, Authorization & Identity Management
- [ ] **Strong Password / MFA Policy:** Multi-factor authentication enforced for administrative users.
- [ ] **Standard Auth Protocols:** Utilizing OAuth 2.0 / OIDC / SAML 2.0 (no custom homegrown crypto).
- [ ] **Token Security:** JWT tokens signed with secure asymmetric keys (RS256); short expiration (<= 15 mins) with secure refresh token rotation in HttpOnly, Secure, SameSite cookies.
- [ ] **Role-Based Access Control (RBAC):** Server-side authorization checks on all endpoints (never rely solely on UI button hiding).
- [ ] **Zero Hardcoded Credentials:** Codebase scanned via TruffleHog / GitGuardian; zero plain-text secrets in repository or git history.

---

## 2. Network & Transport Security
- [ ] **TLS Enforcement:** Strict HTTPS (TLS 1.2+ minimum, TLS 1.3 preferred) enforced with HTTP Strict Transport Security (HSTS) headers.
- [ ] **CORS Configuration:** Explicitly configured whitelist of allowed origins (no `Access-Control-Allow-Origin: *` with credentials).
- [ ] **API Security Headers:** Helmet / custom headers configured: `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, Content-Security-Policy (CSP).
- [ ] **Rate Limiting & DDoS Defense:** API rate limiting enabled (e.g., 100 req/min per IP/token) via API Gateway or Cloudflare to prevent brute-force and DoS.

---

## 3. Data Protection, Privacy & Encryption
- [ ] **Encryption At-Rest:** Database volumes, object storage buckets (S3), and backups encrypted using AES-256 (AWS KMS / customer-managed keys).
- [ ] **Encryption In-Transit:** All internal microservice-to-microservice and database connections use TLS/SSL.
- [ ] **PII Classification:** Sensitive data identified and masked in application logs and non-production environments.
- [ ] **Right to be Forgotten (GDPR):** Automated or documented procedure to purge or anonymize user records upon client request.
- [ ] **Data Retention & Shredding:** Automated expiration and lifecycle policies configured for staging/test databases and access logs.

---

## 4. Application Vulnerability Defense (OWASP Top 10)
- [ ] **Injection (SQL, NoSQL, OS command):** Parameterized queries / ORMs utilized; no raw dynamic string concatenation in DB queries.
- [ ] **Cross-Site Scripting (XSS):** Input sanitization and output encoding enforced; React/modern frameworks used with dangerouslySetInnerHTML prohibited.
- [ ] **Cross-Site Request Forgery (CSRF):** Anti-CSRF tokens or SameSite=Strict cookies enforced for state-changing operations.
- [ ] **Server-Side Request Forgery (SSRF):** Whitelisted destination URLs and validation on all outbound HTTP calls triggered by user inputs.
- [ ] **Mass Assignment / Broken Object Level Auth (BOLA):** Strict DTO validation schemas (Zod, Joi, Pydantic) to strip unauthorized fields before saving.

---

## 5. Software Supply Chain & Vulnerability Scanning
- [ ] **Automated SAST Scan:** Static code analysis run in CI (SonarQube, Semgrep, CodeQL) with zero unresolved high/critical vulnerabilities.
- [ ] **Dependency Audit (SCA):** Snyk / Dependabot / Trivy configured; all known CVEs patched or mitigated.
- [ ] **Container Image Scanning:** Base Docker images use minimal distroless or Alpine images and run as non-root user.

---

## 6. Threat Assessment & Risk Acceptance Table

| Vulnerability / Risk | Severity | Affected Component | Mitigation / Compensating Control | Target Fix Date | Owner |
|---|---|---|---|---|---|
| *Example: Legacy external webhook lacks HMAC signature* | Medium | Webhook Ingress | IP whitelist + timestamp replay check | YYYY-MM-DD | Dev Lead |

---

## 7. Security Sign-Off

| Role | Signatory Name | Status | Signature | Date |
|---|---|---|---|---|
| **AppSec Lead** | | Approved | ____________________ | YYYY-MM-DD |
| **Engineering Lead** | | Acknowledged | ____________________ | YYYY-MM-DD |
| **Client CISO / Delegate** | | Accepted | ____________________ | YYYY-MM-DD |

