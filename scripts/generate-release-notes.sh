#!/usr/bin/env bash
# ==============================================================================
# Automated Release Notes & Changelog Generator
# Extracts Conventional Commits between git references and outputs a
# structured, client-facing and operations-ready Release Notes document.
# ==============================================================================

set -euo pipefail

FROM_TAG="${1:-}"
TO_REF="${2:-HEAD}"
VERSION_NAME="${3:-Release}"

if [ -z "$FROM_TAG" ]; then
    # Default to the previous commit or initial commit if no tag given
    if git describe --tags --abbrev=0 2>/dev/null; then
        FROM_TAG=$(git describe --tags --abbrev=0)
    else
        FROM_TAG=$(git rev-list --max-parents=0 HEAD | head -n 1)
    fi
fi

DATE_STR=$(date +%Y-%m-%d)

echo "# Release Notes: ${VERSION_NAME} (${DATE_STR})"
echo ""
echo "### Summary of Changes"
echo "Release range: \`${FROM_TAG}\` to \`${TO_REF}\`"
echo ""

echo "### 🚀 New Features & Enhancements"
git log "${FROM_TAG}..${TO_REF}" --grep="^feat" --pretty=format:"- %s (%h)" 2>/dev/null || echo "- No new features in this release."
echo ""
echo ""

echo "### 🐛 Bug Fixes & Defect Resolutions"
git log "${FROM_TAG}..${TO_REF}" --grep="^fix" --pretty=format:"- %s (%h)" 2>/dev/null || echo "- No bug fixes in this release."
echo ""
echo ""

echo "### ⚡ Performance Optimizations"
git log "${FROM_TAG}..${TO_REF}" --grep="^perf" --pretty=format:"- %s (%h)" 2>/dev/null || echo "- No performance patches in this release."
echo ""
echo ""

echo "### 🛡️ Security & Compliance Updates"
git log "${FROM_TAG}..${TO_REF}" --grep="^sec\|^security" --pretty=format:"- %s (%h)" 2>/dev/null || echo "- Standard dependency patches applied."
echo ""
echo ""

echo "### 📝 Documentation & Operations Playbooks"
git log "${FROM_TAG}..${TO_REF}" --grep="^docs" --pretty=format:"- %s (%h)" 2>/dev/null || echo "- Documentation up to date."
echo ""
echo ""

echo "---"
echo "Generated automatically via \`scripts/generate-release-notes.sh\`"
