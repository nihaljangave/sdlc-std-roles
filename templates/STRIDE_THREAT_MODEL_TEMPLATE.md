# STRIDE Security Threat Model & Risk Assessment
## Architecture-Level Threat Analysis for Enterprise Security Audits

| Threat Model Metadata | Details |
|---|---|
| **System / Application** | [System Name] |
| **Lead Security Architect** | [Name / Email] |
| **Lead Developer** | [Name / Email] |
| **Review Date** | YYYY-MM-DD |
| **Stage Gate Alignment** | Gate 1 (Architecture & Security Review) |
| **Status** | `Draft` \| `Under Review` \| `Approved` |

---

## 1. STRIDE Threat Classification Reference

- **S - Spoofing:** Pretending to be someone or something other than oneself (e.g., forged JWT, stolen API key).
- **T - Tampering:** Modifying data in-transit or at-rest (e.g., parameter tampering, MITM payload modification).
- **R - Repudiation:** Claiming you didn't do something without proof (e.g., lack of audit logs for financial transactions).
- **I - Information Disclosure:** Exposing confidential data to unauthorized parties (e.g., verbose 500 error traces, PII in logs).
- **D - Denial of Service:** Making a system unavailable to legitimate users (e.g., resource exhaustion, un-indexed query spikes).
- **E - Elevation of Privilege:** Gaining higher access levels without authorization (e.g., BOLA/IDOR, vertical privilege escalation).

---

## 2. Threat Analysis Matrix (STRIDE Evaluation)

| Threat ID | Category | Component / Boundary | Threat Scenario & Impact | Severity (High/Med/Low) | Mitigation / Countermeasure | Status | Owner |
|---|---|---|---|---|---|---|---|
| **TM-001** | Spoofing | Client Ingress -> API GW | Attacker forges an expired or unsigned JWT token to access private customer endpoints. | **High** | Enforce RS256 asymmetric signature verification with public JWKS caching; token expiry <= 15m. | Implemented | Dev Lead |
| **TM-002** | Tampering | Frontend -> Payment API | Malicious user alters `unit_price` in the JSON payload during checkout. | **High** | Price calculation performed strictly server-side; client submits SKU and quantity only. | Implemented | Backend Lead |
| **TM-003** | Repudiation | Admin Console | Store administrator issues a refund, then denies initiating it. | **Medium** | Append-only immutable audit log table recording `admin_id`, `ip_address`, `timestamp`, and `action`. | Implemented | DBA / Dev |
| **TM-004** | Information Disclosure | Production Logs | User email and credit card last 4 digits printed in plaintext in Datadog/CloudWatch. | **High** | Application-level logging interceptor with automated regex masking for PII/PCI fields. | Implemented | SRE Lead |
| **TM-005** | Denial of Service | Public Search API | Scraper floods `/api/v1/search` with expensive un-indexed substring queries, exhausting DB pool. | **High** | Rate limiting (100 req/min per IP via Cloudflare) + Elasticsearch / Postgres GIN index + 3s statement timeout. | Implemented | Tech Lead |
| **TM-006** | Elevation of Privilege | Tenant B2B Ingress | Tenant A user queries `/orders/ord_123` belonging to Tenant B (BOLA/IDOR vulnerability). | **Critical** | Database Row-Level Security (RLS) + server-side session tenant verification middleware. | Implemented | Architect |

---

## 3. Data Flow Trust Boundaries Diagram

```mermaid
flowchart TD
    subgraph Untrusted Network (Public Internet)
        Attacker["Potential Adversary"]
        ValidUser["Legitimate Client"]
    end

    subgraph Trust Boundary 1: Perimeter DMZ
        WAF["AWS WAF / Cloudflare (Rate Limiting, DDoS Filter)"]
        ALB["Application Load Balancer (TLS 1.3 Termination)"]
    end

    subgraph Trust Boundary 2: Private Application Subnet
        API["Backend Microservice (No Public IP)"]
        AuthMiddleware["RBAC & Tenant Isolation Guard"]
    end

    subgraph Trust Boundary 3: Secure Data Tier
        DB[("Encrypted PostgreSQL Aurora (AES-256)")]
        Secrets[("AWS Secrets Manager / Vault")]
    end

    ValidUser --> WAF
    Attacker -.->|Blocked by WAF| WAF
    WAF --> ALB
    ALB --> AuthMiddleware
    AuthMiddleware --> API
    API --> DB
    API -.-> Secrets
```

---

## 4. Formal Security Review Sign-Off

| Reviewer Role | Name | Decision | Date |
|---|---|---|---|
| **Cloud Security Officer / AppSec** | | Approved | YYYY-MM-DD |
| **Lead Solution Architect** | | Approved | YYYY-MM-DD |
| **Client Security Delegate** | | Accepted | YYYY-MM-DD |
