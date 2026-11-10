# Software Bill of Materials (SBOM) & Open-Source License Policy

| Policy Details | Value |
|---|---|
| **Document ID** | POL-SEC-004 |
| **Owner** | Legal & Security Compliance Team |
| **Applicability** | All software components, client deliverables, and open-source libraries |
| **Automated Scanning** | Enforced on every Pull Request via CI |

---

## 1. Permitted vs. Prohibited Open-Source Licenses

To prevent intellectual property contamination and ensure commercial viability for clients:

| Category | Allowed Licenses | Policy & Constraints |
|---|---|---|
| **Category A: Permissive (Approved)** | MIT, Apache 2.0, BSD 2-Clause, BSD 3-Clause, ISC | **Unrestricted Use.** Permitted in all client products and proprietary commercial prototypes. |
| **Category B: Weak Copyleft (Review Required)** | LGPL, MPL 2.0, EPL | **Conditional Use.** Allowed ONLY as dynamically linked libraries; must NOT modify library internals. |
| **Category C: Strong Copyleft (STRICTLY PROHIBITED)** | GPL v2, GPL v3, AGPL v3, SSPL | **FORBIDDEN.** Strictly blocked in CI pipeline. Contaminates proprietary client intellectual property. |

---

## 2. Automated SBOM Generation in CI/CD (CycloneDX)

An updated Software Bill of Materials (SBOM) is automatically generated during every production release build and committed to `docs/security/sbom.json`.

### Tooling: Syft / CycloneDX CLI:
```bash
# Generate CycloneDX JSON SBOM for Node.js / Python / Go dependencies
syft dir:. -o cyclonedx-json > docs/security/sbom.json

# Validate license compliance (fails build if AGPL/GPL detected)
npx license-checker --summary --failOn 'GPL;AGPL'
```

---

## 3. Client Audit Deliverable
During Stage 4 (Operations & Client Handover), the delivery team provides:
1. Complete `sbom.json` listing all direct and transitive third-party dependencies.
2. License compliance attestation letter certifying zero viral copyleft contaminations.
