#!/usr/bin/env bash
# ==============================================================================
# Master SDLC Framework CLI
# Unified CLI to scaffold projects, audit stage gates, generate release notes,
# install git compliance hooks, and manage documentation.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

show_help() {
    cat << 'EOF'
================================================================================
🚀 Lean-Enterprise SDLC Master CLI
================================================================================
Usage: ./scripts/sdlc-cli.sh <command> [arguments]

Commands:
  scaffold <target-dir> [p] Scaffold a new project repository with SDLC templates.
                            Optional profile [p]: --standard (default),
                            --enterprise (VPAT, GLRR, Sign-off Matrix, STRIDE),
                            --ai (Model Card & Risk Assessment), or --all.
                            
  audit <gate> [path]       Run compliance audit on a project.
                            <gate>: 0 | 1 | 2 | 3 | 4 | 5 | all
                            [path]: Path to project (defaults to current dir).
                            
  release [from] [to] [tag] Generate structured, client-facing and ops-ready
                            release notes from Conventional Commits.
                            
  report [name] [days]      Generate 1-page weekly client delivery flash report
                            from the past N days of Git commits.
                            
  package [path] [out] [v]  Bundle all formal project artifacts into a
                            compressed, client-ready handover archive.
                            
  smoke [url] [timeout]     Execute synthetic PVT smoke test against target
                            endpoint (verifies health probes and doc ingress).
                            
  hooks                     Install local git hooks (commit-msg and pre-commit)
                            for secret leak prevention and Conventional Commits.
                            
  portal                    Preview the interactive documentation portal locally
                            (requires mkdocs or python http server).
                            
  help                      Show this help message.

Examples:
  ./scripts/sdlc-cli.sh scaffold ../my-new-client-mvp --enterprise
  ./scripts/sdlc-cli.sh audit 1 .
  ./scripts/sdlc-cli.sh audit all .
  ./scripts/sdlc-cli.sh release v0.9.0 HEAD v1.0.0
  ./scripts/sdlc-cli.sh package . ./dist v1.0.0
  ./scripts/sdlc-cli.sh hooks
================================================================================
EOF
}

CMD="${1:-help}"

case "$CMD" in
    scaffold)
        TARGET="${2:-}"
        PROFILE="${3:---standard}"
        if [ -z "$TARGET" ]; then
            echo "❌ Error: Target directory required. Example: $0 scaffold ../my-app --enterprise"
            exit 1
        fi
        "$FRAMEWORK_ROOT/scripts/scaffold-new-project.sh" "$TARGET" "$PROFILE"
        ;;
    audit|verify)
        GATE="${2:-all}"
        TARGET="${3:-.}"
        "$FRAMEWORK_ROOT/scripts/verify-stage-gate.sh" "$GATE" "$TARGET"
        ;;
    release)
        FROM="${2:-}"
        TO="${3:-HEAD}"
        VERSION="${4:-Release}"
        "$FRAMEWORK_ROOT/scripts/generate-release-notes.sh" "$FROM" "$TO" "$VERSION"
        ;;
    report)
        NAME="${2:-$(basename "$(pwd)")}"
        DAYS="${3:-7}"
        "$FRAMEWORK_ROOT/scripts/generate-weekly-report.sh" "$NAME" "$DAYS"
        ;;
    package)
        PROJ="${2:-.}"
        OUT="${3:-./dist}"
        VER="${4:-v1.0.0}"
        "$FRAMEWORK_ROOT/scripts/package-client-handover.sh" "$PROJ" "$OUT" "$VER"
        ;;
    smoke)
        TARGET_URL="${2:-http://localhost:8000}"
        TIMEOUT="${3:-10}"
        "$FRAMEWORK_ROOT/scripts/run-smoke-tests.sh" "$TARGET_URL" "$TIMEOUT"
        ;;
    hooks)
        "$FRAMEWORK_ROOT/scripts/setup-git-hooks.sh"
        ;;
    portal)
        if command -v mkdocs &> /dev/null; then
            echo "🌐 Starting MkDocs server on http://127.0.0.1:8000..."
            mkdocs serve
        else
            echo "🌐 MkDocs not found. Starting Python HTTP preview on http://127.0.0.1:8080..."
            python3 -m http.server 8080
        fi
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ Unknown command: $CMD"
        echo ""
        show_help
        exit 1
        ;;
esac

