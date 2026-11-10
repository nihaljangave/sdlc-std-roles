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
  scaffold <target-dir>     Scaffold a new project repository with all SDLC
                            governance templates and GitHub CI compliance gates.
                            
  audit <gate> [path]       Run compliance audit on a project.
                            <gate>: 0 | 1 | 2 | 3 | 4 | 5 | all
                            [path]: Path to project (defaults to current dir).
                            
  release [from] [to] [tag] Generate structured, client-facing and ops-ready
                            release notes from Conventional Commits.
                            
  hooks                     Install local git hooks (commit-msg and pre-commit)
                            for secret leak prevention and Conventional Commits.
                            
  portal                    Preview the interactive documentation portal locally
                            (requires mkdocs or python http server).
                            
  help                      Show this help message.

Examples:
  ./scripts/sdlc-cli.sh scaffold ../my-new-client-mvp
  ./scripts/sdlc-cli.sh audit 1 .
  ./scripts/sdlc-cli.sh audit all examples/b2b-ordering-mvp
  ./scripts/sdlc-cli.sh release v0.9.0 HEAD v1.0.0
  ./scripts/sdlc-cli.sh hooks
================================================================================
EOF
}

CMD="${1:-help}"

case "$CMD" in
    scaffold)
        TARGET="${2:-}"
        if [ -z "$TARGET" ]; then
            echo "❌ Error: Target directory required. Example: $0 scaffold ../my-app"
            exit 1
        fi
        "$FRAMEWORK_ROOT/scripts/scaffold-new-project.sh" "$TARGET"
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

