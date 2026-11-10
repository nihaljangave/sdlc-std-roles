#!/usr/bin/env bash
# ==============================================================================
# Synthetic Production Verification Smoke Test Runner
# Verifies liveness probes, readiness connectivity, and core HTTP status
# against a live staging or production endpoint in seconds.
# ==============================================================================

set -euo pipefail

TARGET_URL="${1:-http://localhost:8000}"
TIMEOUT_SEC="${2:-10}"

echo "================================================================================"
echo "🚀 Running Synthetic Production Verification Tests (PVT) against: $TARGET_URL"
echo "================================================================================"

FAILED_TESTS=0
TOTAL_TESTS=0

run_probe_check() {
    local endpoint="$1"
    local expected_code="${2:-200}"
    local desc="$3"
    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    echo -n "  🔍 Probing [$desc] at ${TARGET_URL}${endpoint}... "

    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time "$TIMEOUT_SEC" "${TARGET_URL}${endpoint}" 2>/dev/null || echo "000")

    if [ "$HTTP_STATUS" -eq "$expected_code" ]; then
        echo "✅ [PASS] (HTTP $HTTP_STATUS)"
    else
        echo "❌ [FAIL] Expected HTTP $expected_code, received $HTTP_STATUS"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

# 1. Check Liveness Probe
run_probe_check "/health/live" 200 "Liveness Probe (Process Alive)"

# 2. Check Readiness Probe
run_probe_check "/health/ready" 200 "Readiness Probe (DB & Cache Connected)"

# 3. Check OpenAPI / Swagger Docs availability
run_probe_check "/docs" 200 "API Documentation Ingress"

echo ""
echo "================================================================================"
echo "📊 Smoke Test Results: $((TOTAL_TESTS - FAILED_TESTS))/$TOTAL_TESTS passed."

if [ "$FAILED_TESTS" -eq 0 ]; then
    echo "🎉 PVT VERIFICATION SUCCESSFUL! Production endpoint is healthy."
    exit 0
else
    echo "⚠️  PVT VERIFICATION FAILED! Do not proceed with traffic cutover."
    exit 1
fi

