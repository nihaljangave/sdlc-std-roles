#!/usr/bin/env bash
# ==============================================================================
# SDLC Stage-Gate Compliance Auditor
# Verifies whether a project repository meets the documentation and readiness
# criteria for a specified stage gate (Gate 0 through Gate 5).
# ==============================================================================

set -euo pipefail

GATE="${1:-all}"
PROJECT_ROOT="${2:-.}"

echo "================================================================================"
echo "🔍 SDLC Stage-Gate Compliance Check: Gate [${GATE}] in ${PROJECT_ROOT}"
echo "================================================================================"

TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

check_file() {
    local label="$1"
    local filepath="$2"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if [ -f "$PROJECT_ROOT/$filepath" ] && [ -s "$PROJECT_ROOT/$filepath" ]; then
        echo "  ✅ [PASS] $label ($filepath)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        echo "  ❌ [FAIL] $label - Missing or empty: $filepath"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

check_dir_has_files() {
    local label="$1"
    local dirpath="$2"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    if [ -d "$PROJECT_ROOT/$dirpath" ] && [ "$(ls -A "$PROJECT_ROOT/$dirpath" 2>/dev/null)" ]; then
        echo "  ✅ [PASS] $label ($dirpath/)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        echo "  ❌ [FAIL] $label - Missing or empty directory: $dirpath/"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

audit_gate_0() {
    echo ""
    echo "📋 Gate 0: Scoping & Project Charter Alignment"
    check_file "Product Requirements Document (PRD)" "docs/PRD.md"
    check_file "Project Charter / Statement of Work" "docs/PROJECT_CHARTER.md"
}

audit_gate_1() {
    echo ""
    echo "📋 Gate 1: Architecture, Security & Contract Review"
    check_file "System Architecture Document (SAD)" "docs/architecture/SAD.md"
    check_dir_has_files "Architecture Decision Records (ADRs)" "docs/adr"
    check_dir_has_files "API Contract / Specifications" "docs/api"
    check_file "Security & Data Privacy Checklist" "docs/security/SECURITY_REVIEW.md"
}

audit_gate_2() {
    echo ""
    echo "📋 Gate 2: Code Quality & Definition of Done"
    check_file "PR Description Template (DoD)" ".github/pull_request_template.md"
    check_file "CI/CD Pipeline Configuration" ".github/workflows/ci-compliance.yml"
    check_file "Git Ignore File" ".gitignore"
}

audit_gate_3() {
    echo ""
    echo "📋 Gate 3: QA Verification & Client UAT Sign-off"
    check_file "Master Test Plan & Client UAT Register" "docs/testing/TEST_PLAN_AND_UAT.md"
}

audit_gate_4() {
    echo ""
    echo "📋 Gate 4: Production Release & Operations Handover"
    check_file "Operations Runbook (Day-2 Playbook)" "docs/ops/OPERATIONS_RUNBOOK.md"
    check_file "Deployment & Rollback Guide" "docs/ops/DEPLOYMENT_GUIDE.md"
    check_file "Service Transition Checklist" "docs/ops/SERVICE_TRANSITION.md"
}

audit_gate_5() {
    echo ""
    echo "📋 Gate 5: Steady-State Transition & Warranty Exit"
    check_file "Incident Management & SLA Escalation Matrix" "docs/ops/SLA_MATRIX.md"
}

case "$GATE" in
    0|gate-0) audit_gate_0 ;;
    1|gate-1) audit_gate_1 ;;
    2|gate-2) audit_gate_2 ;;
    3|gate-3) audit_gate_3 ;;
    4|gate-4) audit_gate_4 ;;
    5|gate-5) audit_gate_5 ;;
    all)
        audit_gate_0
        audit_gate_1
        audit_gate_2
        audit_gate_3
        audit_gate_4
        audit_gate_5
        ;;
    *)
        echo "Unknown gate: $GATE"
        echo "Usage: $0 [0|1|2|3|4|5|all] [target-directory]"
        exit 1
        ;;
esac

echo ""
echo "================================================================================"
echo "📊 Audit Results: ${PASSED_CHECKS}/${TOTAL_CHECKS} checks passed."

if [ "$FAILED_CHECKS" -eq 0 ]; then
    echo "🎉 GATE CLEARANCE APPROVED! All required documentation and formalities are present."
    exit 0
else
    echo "⚠️  GATE CLEARANCE BLOCKED! Resolve the missing items above before proceeding."
    exit 1
fi
