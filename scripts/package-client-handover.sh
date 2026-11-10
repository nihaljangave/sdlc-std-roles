#!/usr/bin/env bash
# ==============================================================================
# Client & Operations Handover Package Bundler
# Consolidates all required formal artifacts into an exportable, audit-ready
# archive for client delivery and corporate operational compliance.
# ==============================================================================

set -euo pipefail

PROJECT_DIR="${1:-.}"
OUTPUT_DIR="${2:-./dist}"
VERSION="${3:-v1.0.0}"

DATE_STR=$(date +%Y%m%d)
PACKAGE_NAME="client-operations-handover-${VERSION}-${DATE_STR}"
BUNDLE_DIR="/tmp/${PACKAGE_NAME}"

echo "📦 Bundling client and operations handover package from: $PROJECT_DIR"

rm -rf "$BUNDLE_DIR"
mkdir -p "$BUNDLE_DIR"
mkdir -p "$OUTPUT_DIR"

copy_if_exists() {
    local src="$1"
    local dest_dir="$2"
    if [ -f "$PROJECT_DIR/$src" ]; then
        mkdir -p "$BUNDLE_DIR/$dest_dir"
        cp "$PROJECT_DIR/$src" "$BUNDLE_DIR/$dest_dir/"
        echo "  📄 Included: $src"
    fi
}

# 1. Project Charter & PRD
copy_if_exists "docs/PRD.md" "01-requirements"
copy_if_exists "docs/PROJECT_CHARTER.md" "01-requirements"

# 2. Architecture & API Contracts
copy_if_exists "docs/architecture/SAD.md" "02-architecture"
copy_if_exists "docs/api/API_SPECIFICATION.md" "02-architecture"
copy_if_exists "docs/api/openapi.yaml" "02-architecture"

# 3. Security & Compliance
copy_if_exists "docs/security/SECURITY_REVIEW.md" "03-security"
copy_if_exists "docs/security/sbom.json" "03-security"

# 4. QA, Test Plan & UAT Sign-off
copy_if_exists "docs/testing/TEST_PLAN_AND_UAT.md" "04-testing-and-uat"

# 5. Operations Runbook & Service Transition
copy_if_exists "docs/ops/OPERATIONS_RUNBOOK.md" "05-operations"
copy_if_exists "docs/ops/DEPLOYMENT_GUIDE.md" "05-operations"
copy_if_exists "docs/ops/SERVICE_TRANSITION.md" "05-operations"
copy_if_exists "docs/ops/SLA_MATRIX.md" "05-operations"

# Generate Table of Contents Index
cat << EOF > "$BUNDLE_DIR/README.md"
# Formal Software Delivery & Operations Handover Package
**Version:** ${VERSION}  
**Date:** $(date +%Y-%m-%d)  
**Package:** ${PACKAGE_NAME}.tar.gz  

### Included Formal Artifacts:
1. **01-requirements/**: Product Requirements Document (PRD) & Signed Statement of Work.
2. **02-architecture/**: System Architecture Document (C4 Model) & OpenAPI 3.0 Contract.
3. **03-security/**: Security Threat Review, Encryption Standards & SBOM License Audit.
4. **04-testing-and-uat/**: Master QA Plan & Executed Client UAT Sign-off Certificate.
5. **05-operations/**: Production Operations Runbook, Deployment Guide & Signed Service Transition.
EOF

# Compress into tarball
ARCHIVE_PATH="${OUTPUT_DIR}/${PACKAGE_NAME}.tar.gz"
tar -czf "$ARCHIVE_PATH" -C "/tmp" "$PACKAGE_NAME"

rm -rf "$BUNDLE_DIR"

echo ""
echo "✅ Handover package successfully created!"
echo "📁 Archive Location: $ARCHIVE_PATH"
echo "📊 Archive Size: $(du -h "$ARCHIVE_PATH" | cut -f1)"

