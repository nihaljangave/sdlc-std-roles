#!/usr/bin/env bash
# ==============================================================================
# Lean-Enterprise SDLC Interactive Demo & Simulation
# Demonstrates scaffolding, stage-gate auditing, release note generation,
# milestone sign-off certificates, and handover packaging in 30 seconds.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DEMO_DIR="/tmp/sdlc-demo-$(date +%s)"
trap 'rm -rf "$DEMO_DIR"' EXIT

echo "================================================================================"
echo "🚀 Lean-Enterprise SDLC Interactive Simulation"
echo "================================================================================"
echo "Demonstrating fast-track project delivery with embedded compliance..."
echo ""

# 1. Scaffolding Simulation
echo "Step 1/5: 🏗️  Scaffolding a new enterprise MVP project in seconds..."
"$FRAMEWORK_ROOT/scripts/scaffold-new-project.sh" "$DEMO_DIR" --enterprise
echo "   --> Pre-populated 14 documentation templates under $DEMO_DIR/docs/"
echo "   --> Pre-populated GitHub CI compliance gates under $DEMO_DIR/.github/"
echo ""

# 2. Stage-Gate Compliance Audit Simulation
echo "Step 2/5: 🔍 Running automated Stage-Gate compliance audit..."
"$FRAMEWORK_ROOT/scripts/verify-stage-gate.sh" all "$DEMO_DIR"
echo ""

# 3. Weekly Client Flash Report Simulation
echo "Step 3/5: 📊 Generating 1-page weekly client delivery flash report..."
"$FRAMEWORK_ROOT/scripts/generate-weekly-report.sh" "Acme-FinTech-Portal" 7
echo ""

# 4. Milestone Acceptance Certificate Simulation
echo "Step 4/5: 📜 Generating cryptographically stamped client milestone sign-off certificate..."
"$FRAMEWORK_ROOT/scripts/generate-signoff-cert.sh" "M3-Client-UAT" "Acme Global Bank" "FinTech-Payment-Core"
echo ""

# 5. Handover Archive Simulation
echo "Step 5/5: 📦 Packaging formal client & operations handover bundle..."
"$FRAMEWORK_ROOT/scripts/package-client-handover.sh" "$DEMO_DIR" "$DEMO_DIR/dist" "v1.0.0-rc1"
echo ""

echo "================================================================================"
echo "🎉 SIMULATION COMPLETE: All SDLC governance gates and artifacts executed live!"
echo "   Temporary demo environment cleanly purged."
echo "================================================================================"

