#!/usr/bin/env bash
# ==============================================================================
# SDLC Stage-Gate Compliance Auditor
# Verifies whether a project repository meets the documentation and readiness
# criteria for a specified stage gate (Gate 0 through Gate 5).
# ==============================================================================

set -euo pipefail

GATE="${1:-all}"
PROJECT_ROOT="${2:-.}"
FORMAT="${3:-console}"

log_msg() {
    if [ "$FORMAT" != "json" ]; then
        echo "$@"
    fi
}

log_msg "================================================================================"
log_msg "🔍 SDLC Stage-Gate Compliance Check: Gate [${GATE}] in ${PROJECT_ROOT}"
log_msg "================================================================================"

TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

check_file() {
    local label="$1"
    local filepath="$2"
    local fallback_template="${3:-}"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if [ -f "$PROJECT_ROOT/$filepath" ] && [ -s "$PROJECT_ROOT/$filepath" ]; then
        log_msg "  ✅ [PASS] $label ($filepath)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    elif [ -n "$fallback_template" ] && [ -f "$PROJECT_ROOT/$fallback_template" ] && [ -s "$PROJECT_ROOT/$fallback_template" ]; then
        log_msg "  ✅ [PASS] $label (Framework Source: $fallback_template)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        log_msg "  ❌ [FAIL] $label - Missing or empty: $filepath"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

check_dir_has_files() {
    local label="$1"
    local dirpath="$2"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    if [ -d "$PROJECT_ROOT/$dirpath" ] && [ "$(ls -A "$PROJECT_ROOT/$dirpath" 2>/dev/null)" ]; then
        log_msg "  ✅ [PASS] $label ($dirpath/)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        log_msg "  ❌ [FAIL] $label - Missing or empty directory: $dirpath/"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

audit_gate_0() {
    log_msg ""
    log_msg "📋 Gate 0: Scoping & Project Charter Alignment"
    check_file "Product Requirements Document (PRD)" "docs/PRD.md" "templates/PRD_TEMPLATE.md"
    check_file "Project Charter / Statement of Work" "docs/PROJECT_CHARTER.md" "templates/PROJECT_CHARTER_AND_SOW.md"
}

audit_gate_1() {
    log_msg ""
    log_msg "📋 Gate 1: Architecture, Security & Contract Review"
    check_file "System Architecture Document (SAD)" "docs/architecture/SAD.md" "templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md"
    if [ -f "$PROJECT_ROOT/docs/architecture/IDD.md" ]; then
        check_file "Infrastructure Design Document (IDD)" "docs/architecture/IDD.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/ai/MODEL_CARD.md" ]; then
        check_file "AI Model Card & Risk Assessment" "docs/ai/MODEL_CARD.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/security/THREAT_MODEL.md" ]; then
        check_file "STRIDE Threat Model" "docs/security/THREAT_MODEL.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/security/KEY_MANAGEMENT_PLAN.md" ]; then
        check_file "Cryptographic Key Management Plan" "docs/security/KEY_MANAGEMENT_PLAN.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/security/VENDOR_ASSESSMENT.md" ]; then
        check_file "Third-Party Vendor Security Assessment" "docs/security/VENDOR_ASSESSMENT.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/security/SECURITY_ASSURANCE_PACK.md" ]; then
        check_file "Client Security Assurance Pack" "docs/security/SECURITY_ASSURANCE_PACK.md"
    fi
    check_dir_has_files "Architecture Decision Records (ADRs)" "docs/adr"
    check_dir_has_files "API Contract / Specifications" "docs/api"
    check_file "Security & Data Privacy Checklist" "docs/security/SECURITY_REVIEW.md" "templates/SECURITY_AND_DATA_PRIVACY_CHECKLIST.md"
}

audit_gate_2() {
    log_msg ""
    log_msg "📋 Gate 2: Code Quality & Definition of Done"
    check_file "PR Description Template (DoD)" ".github/pull_request_template.md" "templates/DEFINITION_OF_DONE_AND_CODE_REVIEW.md"
    check_file "CI/CD Pipeline Configuration" ".github/workflows/ci-compliance.yml"
    check_file "Git Ignore File" ".gitignore"
}

audit_gate_3() {
    log_msg ""
    log_msg "📋 Gate 3: QA Verification & Client UAT Sign-off"
    check_file "Master Test Plan & Client UAT Register" "docs/testing/TEST_PLAN_AND_UAT.md" "templates/TEST_PLAN_AND_UAT_SIGNOFF.md"
    if [ -f "$PROJECT_ROOT/docs/testing/VPAT.md" ]; then
        check_file "VPAT Accessibility Report" "docs/testing/VPAT.md"
    fi
}

audit_gate_4() {
    log_msg ""
    log_msg "📋 Gate 4: Production Release & Operations Handover"
    check_file "Operations Runbook (Day-2 Playbook)" "docs/ops/OPERATIONS_RUNBOOK.md" "templates/OPERATIONS_RUNBOOK.md"
    check_file "Deployment & Rollback Guide" "docs/ops/DEPLOYMENT_GUIDE.md" "templates/DEPLOYMENT_AND_ROLLBACK_GUIDE.md"
    check_file "Service Transition Checklist" "docs/ops/SERVICE_TRANSITION.md" "templates/SERVICE_TRANSITION_CHECKLIST.md"
    if [ -f "$PROJECT_ROOT/docs/ops/GLRR.md" ]; then
        check_file "Go-Live Readiness Review (GLRR)" "docs/ops/GLRR.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/DELIVERABLES_MATRIX.md" ]; then
        check_file "Master Deliverables Sign-off Matrix" "docs/DELIVERABLES_MATRIX.md"
    fi
    if [ -f "$PROJECT_ROOT/docs/ops/BIA.md" ]; then
        check_file "Business Impact Analysis (BIA)" "docs/ops/BIA.md"
    fi
}

audit_gate_5() {
    log_msg ""
    log_msg "📋 Gate 5: Steady-State Transition & Warranty Exit"
    check_file "Incident Management & SLA Escalation Matrix" "docs/ops/SLA_MATRIX.md" "templates/INCIDENT_MANAGEMENT_AND_SLA_MATRIX.md"
    if [ -f "$PROJECT_ROOT/docs/ops/SLA_SPECIFICATION.md" ]; then
        check_file "SLA & Service Credit Specification" "docs/ops/SLA_SPECIFICATION.md"
    fi
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

if [ "$FORMAT" = "json" ]; then
    cat << EOF
{
  "gate": "${GATE}",
  "target": "${PROJECT_ROOT}",
  "total_checks": ${TOTAL_CHECKS},
  "passed_checks": ${PASSED_CHECKS},
  "failed_checks": ${FAILED_CHECKS},
  "clearance_approved": $([ "$FAILED_CHECKS" -eq 0 ] && echo "true" || echo "false"),
  "timestamp": "$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
}
EOF
    [ "$FAILED_CHECKS" -eq 0 ] && exit 0 || exit 1
fi

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

