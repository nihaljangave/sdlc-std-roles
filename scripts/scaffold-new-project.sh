#!/usr/bin/env bash
# ==============================================================================
# SDLC Fast-Track Project Scaffolder
# Sets up a new repository with all required SDLC governance templates,
# checklists, and GitHub Actions compliance workflows in seconds.
# ==============================================================================

set -euo pipefail

TARGET_DIR="${1:-}"

if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 <target-project-directory>"
    echo "Example: $0 ../my-new-product"
    exit 1
fi

FRAMEWORK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🚀 Initializing Fast-Track SDLC in: $TARGET_DIR"

mkdir -p "$TARGET_DIR/docs/architecture"
mkdir -p "$TARGET_DIR/docs/adr"
mkdir -p "$TARGET_DIR/docs/api"
mkdir -p "$TARGET_DIR/docs/security"
mkdir -p "$TARGET_DIR/docs/testing"
mkdir -p "$TARGET_DIR/docs/ops"
mkdir -p "$TARGET_DIR/.github/workflows"
mkdir -p "$TARGET_DIR/.github/ISSUE_TEMPLATE"

# Copy baseline templates into project docs
cp "$FRAMEWORK_ROOT/templates/PRD_TEMPLATE.md" "$TARGET_DIR/docs/PRD.md"
cp "$FRAMEWORK_ROOT/templates/PROJECT_CHARTER_AND_SOW.md" "$TARGET_DIR/docs/PROJECT_CHARTER.md"
cp "$FRAMEWORK_ROOT/templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md" "$TARGET_DIR/docs/architecture/SAD.md"
cp "$FRAMEWORK_ROOT/templates/ARCHITECTURE_DECISION_RECORD_ADR.md" "$TARGET_DIR/docs/adr/ADR-001-initial-architecture.md"
cp "$FRAMEWORK_ROOT/templates/API_CONTRACT_AND_INTEGRATION_SPEC.md" "$TARGET_DIR/docs/api/API_SPECIFICATION.md"
cp "$FRAMEWORK_ROOT/templates/SECURITY_AND_DATA_PRIVACY_CHECKLIST.md" "$TARGET_DIR/docs/security/SECURITY_REVIEW.md"
cp "$FRAMEWORK_ROOT/templates/TEST_PLAN_AND_UAT_SIGNOFF.md" "$TARGET_DIR/docs/testing/TEST_PLAN_AND_UAT.md"
cp "$FRAMEWORK_ROOT/templates/OPERATIONS_RUNBOOK.md" "$TARGET_DIR/docs/ops/OPERATIONS_RUNBOOK.md"
cp "$FRAMEWORK_ROOT/templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md" "$TARGET_DIR/docs/ops/DEPLOYMENT_GUIDE.md"
cp "$FRAMEWORK_ROOT/templates/SERVICE_TRANSITION_CHECKLIST.md" "$TARGET_DIR/docs/ops/SERVICE_TRANSITION.md"
cp "$FRAMEWORK_ROOT/templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md" "$TARGET_DIR/docs/ops/SLA_MATRIX.md"

# Copy GitHub PR and Issue templates
cp "$FRAMEWORK_ROOT/.github/pull_request_template.md" "$TARGET_DIR/.github/pull_request_template.md"
cp -r "$FRAMEWORK_ROOT/.github/ISSUE_TEMPLATE/"* "$TARGET_DIR/.github/ISSUE_TEMPLATE/"
cp "$FRAMEWORK_ROOT/.github/workflows/ci-compliance.yml" "$TARGET_DIR/.github/workflows/ci-compliance.yml"
cp "$FRAMEWORK_ROOT/.gitignore" "$TARGET_DIR/.gitignore"

echo "✅ Project scaffolded successfully!"
echo "📁 All documentation templates are pre-populated under: $TARGET_DIR/docs/"
echo "⚙️  GitHub Actions and PR compliance gates configured under: $TARGET_DIR/.github/"
