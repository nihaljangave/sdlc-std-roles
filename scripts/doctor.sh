#!/usr/bin/env bash
# ==============================================================================
# SDLC Workstation Healthcheck & Pre-Flight Diagnostics ("Doctor")
# Inspects developer machine environment, CLI toolchains, Git configuration,
# compliance hooks, and container runtimes before writing code.
# ==============================================================================

set -euo pipefail

TOTAL_CHECKS=0
PASSED_CHECKS=0
WARNED_CHECKS=0
FAILED_CHECKS=0

echo "================================================================================"
echo "🩺 SDLC Developer Workstation Healthcheck & Pre-Flight Diagnostics"
echo "   Target OS: $(uname -s) ($(uname -m)) &bull; Hostname: $(hostname -s)"
echo "================================================================================"

pass_check() {
    local item="$1"
    local detail="$2"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
    echo "  ✅ [PASS] $item: $detail"
}

warn_check() {
    local item="$1"
    local detail="$2"
    local fix="$3"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    WARNED_CHECKS=$((WARNED_CHECKS + 1))
    echo "  ⚠️  [WARN] $item: $detail"
    echo "             --> Fix: $fix"
}

fail_check() {
    local item="$1"
    local detail="$2"
    local fix="$3"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    echo "  ❌ [FAIL] $item: $detail"
    echo "             --> Fix: $fix"
}

echo ""
echo "📋 1. Core Operating Utilities & Shell"
if command -v bash &> /dev/null; then
    pass_check "Bash Shell" "$($BASH --version | head -n 1)"
else
    fail_check "Bash Shell" "Not found" "Install bash via package manager"
fi

if command -v make &> /dev/null; then
    pass_check "GNU Make" "$(make --version | head -n 1)"
else
    fail_check "GNU Make" "Not found" "Run 'brew install make' or install Xcode Command Line Tools"
fi

if command -v curl &> /dev/null; then
    pass_check "cURL" "$(curl --version | head -n 1 | cut -d' ' -f1-2)"
else
    fail_check "cURL" "Not found" "Install curl via package manager"
fi

if command -v tar &> /dev/null; then
    pass_check "Tar Archiver" "Available in system PATH"
else
    fail_check "Tar Archiver" "Not found" "Install tar via package manager"
fi

echo ""
echo "📋 2. Git Environment & Security Hygiene"
if command -v git &> /dev/null; then
    pass_check "Git CLI" "$(git --version)"
    
    GIT_NAME=$(git config user.name || true)
    GIT_EMAIL=$(git config user.email || true)
    
    if [ -n "$GIT_NAME" ]; then
        pass_check "Git Author Name" "$GIT_NAME"
    else
        warn_check "Git Author Name" "Not configured" "Run 'git config --global user.name \"Your Name\"'"
    fi
    
    if [ -n "$GIT_EMAIL" ]; then
        pass_check "Git Author Email" "$GIT_EMAIL"
    else
        warn_check "Git Author Email" "Not configured" "Run 'git config --global user.email \"your.email@domain.com\"'"
    fi
    
    if [ -f ".git/hooks/pre-commit" ] && [ -f ".git/hooks/commit-msg" ]; then
        pass_check "SDLC Git Hooks" "Conventional Commits & Secret Scanning hooks installed"
    else
        warn_check "SDLC Git Hooks" "Pre-commit or commit-msg hook missing" "Run 'make hooks' or './scripts/sdlc-cli.sh hooks'"
    fi
else
    fail_check "Git CLI" "Not found" "Install git via package manager"
fi

echo ""
echo "📋 3. Developer Language Runtimes"
if command -v python3 &> /dev/null; then
    pass_check "Python 3 Runtime" "$(python3 --version)"
else
    fail_check "Python 3 Runtime" "Not found" "Run 'brew install python@3.11'"
fi

if command -v node &> /dev/null; then
    pass_check "Node.js Runtime" "$(node --version)"
else
    warn_check "Node.js Runtime" "Optional for documentation or frontend tooling" "Run 'brew install node@20'"
fi

if command -v npm &> /dev/null; then
    pass_check "npm Package Manager" "v$(npm --version)"
fi

echo ""
echo "📋 4. Container & Virtualization Toolchains"
if command -v docker &> /dev/null; then
    if docker info &> /dev/null; then
        pass_check "Docker Engine" "Running & connected ($(docker version --format '{{.Server.Version}}' 2>/dev/null || echo 'Active'))"
    else
        warn_check "Docker Engine" "Installed but daemon is not running" "Start Docker Desktop, OrbStack, or Colima"
    fi
else
    warn_check "Docker Engine" "Container runtime not detected" "Install Docker Desktop or OrbStack if building containers"
fi

echo ""
echo "📋 5. Enterprise Security & Quality Tooling (Recommended)"
if command -v gitleaks &> /dev/null; then
    pass_check "Gitleaks (Secret Scanner)" "$(gitleaks version 2>/dev/null || echo 'Installed')"
else
    warn_check "Gitleaks (Secret Scanner)" "Not installed" "Run 'brew install gitleaks' for automated pre-commit secret leak defense"
fi

if command -v syft &> /dev/null; then
    pass_check "Syft (SBOM Generator)" "$(syft version 2>/dev/null | head -n 1 || echo 'Installed')"
else
    pass_check "Syft (SBOM Generator)" "Built-in zero-dependency Python scanner available as fallback"
fi

if command -v trivy &> /dev/null; then
    pass_check "Trivy (Vulnerability Scanner)" "$(trivy --version 2>/dev/null | head -n 1 || echo 'Installed')"
else
    warn_check "Trivy (Vulnerability Scanner)" "Not installed" "Run 'brew install trivy' to scan container images locally"
fi

if command -v mkdocs &> /dev/null; then
    pass_check "Material for MkDocs" "Installed"
else
    pass_check "Documentation Portal" "Python built-in HTTP server available as fallback (run 'make portal')"
fi

echo ""
echo "================================================================================"
echo "📊 Diagnostics Summary: ${PASSED_CHECKS}/${TOTAL_CHECKS} checks passed ($WARNED_CHECKS warnings, $FAILED_CHECKS failures)."

if [ "$FAILED_CHECKS" -eq 0 ]; then
    echo "🎉 WORKSTATION READY! Your developer environment satisfies SDLC requirements."
    exit 0
else
    echo "⚠️  WORKSTATION INCOMPLETE! Resolve the failed dependencies above before proceeding."
    exit 1
fi
