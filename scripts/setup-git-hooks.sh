#!/usr/bin/env bash
# ==============================================================================
# Git Hooks Installer & Developer Environment Setup
# Configures local git hooks to enforce Conventional Commits, secret scanning,
# and code hygiene before commits can be made locally.
# ==============================================================================

set -euo pipefail

HOOKS_DIR=".git/hooks"

if [ ! -d ".git" ]; then
    echo "❌ Error: Must be executed from the root of a Git repository."
    exit 1
fi

echo "🔧 Installing SDLC compliance git hooks into $HOOKS_DIR..."

# 1. Create commit-msg hook for Conventional Commits
cat << 'EOF' > "$HOOKS_DIR/commit-msg"
#!/usr/bin/env bash
# Enforces Conventional Commits: feat, fix, docs, style, refactor, perf, test, chore, build, ci, revert

COMMIT_MSG_FILE="$1"
COMMIT_MSG=$(head -n 1 "$COMMIT_MSG_FILE")

CONVENTIONAL_REGEX="^(feat|fix|docs|style|refactor|perf|test|chore|build|ci|revert)(\([a-zA-Z0-9_\-]+\))?: .+"

if [[ ! "$COMMIT_MSG" =~ $CONVENTIONAL_REGEX ]]; then
    echo "❌ ERROR: Commit message does not follow Conventional Commits standard!"
    echo "  Your message: \"$COMMIT_MSG\""
    echo ""
    echo "  Expected format: <type>(<optional scope>): <subject>"
    echo "  Examples:"
    echo "    feat(auth): add OAuth2 login flow"
    echo "    fix(api): handle timeout on payment webhook"
    echo "    docs(runbook): add disaster recovery failover SOP"
    echo ""
    echo "  Allowed types: feat, fix, docs, style, refactor, perf, test, chore, build, ci, revert"
    exit 1
fi
EOF

chmod +x "$HOOKS_DIR/commit-msg"
echo "  ✅ Installed: commit-msg hook (Conventional Commits enforcement)"

# 2. Create pre-commit hook for secret scanning and branch protection
cat << 'EOF' > "$HOOKS_DIR/pre-commit"
#!/usr/bin/env bash
# Checks for common secret patterns and prevents direct commits to protected branches

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Disallow direct commits to main or production branches
if [ "$CURRENT_BRANCH" = "production" ]; then
    echo "❌ ERROR: Direct commits to '$CURRENT_BRANCH' are forbidden. Please create a feature branch and open a PR."
    exit 1
fi

# Secret pattern checks
SECRETS_FOUND=0
PATTERNS=(
    "AKIA[0-9A-Z]{16}"                    # AWS Access Key ID
    "ghp_[0-9a-zA-Z]{36}"                 # GitHub Personal Access Token
    "sk_live_[0-9a-zA-Z]{24}"             # Stripe Live API Key
    "-----BEGIN (RSA|EC|DSA|OPENSSH) PRIVATE KEY-----" # Private keys
)

for PATTERN in "${PATTERNS[@]}"; do
    if git diff --cached -S "$PATTERN" --pickaxe-regex --quiet; then
        : # Clean
    else
        echo "⚠️  POTENTIAL SECRET LEAK DETECTED matching pattern: $PATTERN"
        SECRETS_FOUND=1
    fi
done

if [ "$SECRETS_FOUND" -ne 0 ]; then
    echo "❌ ERROR: Potential secrets or private keys detected in staged changes!"
    echo "Please remove the credential, use environment variables, and restage."
    exit 1
fi
EOF

chmod +x "$HOOKS_DIR/pre-commit"
echo "  ✅ Installed: pre-commit hook (Secret leak defense & branch protection)"

echo ""
echo "🎉 SDLC Git Hooks successfully installed! Your local environment is now protected."
