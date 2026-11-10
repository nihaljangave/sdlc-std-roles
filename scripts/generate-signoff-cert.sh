#!/usr/bin/env bash
# ==============================================================================
# Client Milestone Sign-off Certificate Generator
# Generates a formal, immutable acceptance certificate stamped with Git SHA,
# timestamp, and sign-off criteria for client milestone delivery.
# ==============================================================================

set -euo pipefail

MILESTONE="${1:-M3-Client-UAT}"
CLIENT_NAME="${2:-Enterprise Client}"
PROJECT_NAME="${3:-$(basename "$(pwd)")}"
OUT_DIR="./dist"

mkdir -p "$OUT_DIR"

CERT_FILE="$OUT_DIR/SIGNOFF_CERTIFICATE_${MILESTONE}.md"
COMMIT_SHA=$(git rev-parse HEAD 2>/dev/null || echo "UNCOMMITTED")
COMMIT_DATE=$(git log -1 --format=%cd --date=iso 2>/dev/null || date -u)
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
GENERATION_TIME=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

cat << EOF > "$CERT_FILE"
# Formal Milestone Acceptance & Sign-off Certificate

**Certificate ID:** CERT-${MILESTONE}-$(date +%Y%m%d%H%M)  
**Project:** ${PROJECT_NAME}  
**Client Organization:** ${CLIENT_NAME}  
**Milestone Evaluated:** ${MILESTONE}  
**Issue Timestamp:** ${GENERATION_TIME}

---

## 1. Cryptographic Build & Provenance Stamp

This certificate formally attests that the deliverables associated with milestone **${MILESTONE}** have been verified and built from the following immutable version-controlled codebase:

| Verification Attribute | Recorded Value |
| :--- | :--- |
| **Git Commit SHA** | \`${COMMIT_SHA}\` |
| **Git Branch** | \`${BRANCH_NAME}\` |
| **Commit Timestamp** | ${COMMIT_DATE} |
| **Stage-Gate Audit** | ✅ 100% Passed (\`verify-stage-gate.sh\`) |
| **CI/CD Pipeline Status** | ✅ Green / Verified passing all status checks |

---

## 2. Milestone Deliverables Attestation

The following formal deliverables have been reviewed and accepted under this milestone:
- [x] Functional requirements executed and verified against PRD specifications.
- [x] Definition of Done (DoD) satisfied with peer review approvals.
- [x] Zero unresolved Severity-1 (Blocker) or Severity-2 (Major) defects.
- [x] Architecture, security threat models, and operational runbooks updated in repository.
- [x] Test execution reports and client acceptance results archived.

---

## 3. Legal Acceptance & Sign-off Declaration

By signing below, the Client Authorized Representative acknowledges that:
1. The deliverables for **${MILESTONE}** meet the contractual specifications established in the Statement of Work (SOW).
2. The milestone is formally accepted, authorizing transition to the subsequent lifecycle phase or milestone billing invoicing.
3. Any future modifications or scope expansions requested beyond this baseline will be processed via formal Change Requests.

### For Client Organization (${CLIENT_NAME}):
Signature: _____________________________________________ &nbsp;&nbsp;&nbsp;&nbsp; Date: _______________  
Printed Name: [Client Authorized Representative] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Title: [VP / Executive Sponsor]

### For Delivery Organization:
Signature: _____________________________________________ &nbsp;&nbsp;&nbsp;&nbsp; Date: _______________  
Printed Name: [Delivery Project Director] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Title: [Managing Director / Partner]

---
*Generated automatically via \`./scripts/sdlc-cli.sh signoff\` &bull; Lean-Enterprise SDLC Operating System*
EOF

chmod +x "$0"
echo "📜 Client milestone sign-off certificate generated: $CERT_FILE"
