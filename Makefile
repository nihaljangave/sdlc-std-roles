# ==============================================================================
# Lean-Enterprise SDLC Master Makefile
# Convenient automation wrapper for project teams, tech leads, and CI runners.
# ==============================================================================

.DEFAULT_GOAL := help
SHELL := /usr/bin/env bash

.PHONY: help
help: ## Show this help menu
	@echo "================================================================================"
	@echo "🚀 Lean-Enterprise SDLC Operating System"
	@echo "================================================================================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo "================================================================================"

.PHONY: audit
audit: ## Run Stage-Gate compliance audit on current repo (usage: make audit [GATE=all])
	@./scripts/sdlc-cli.sh audit $(or $(GATE),all) .

.PHONY: scaffold
scaffold: ## Scaffold a new project (usage: make scaffold TARGET=../my-app PROFILE=--standard)
	@if [ -z "$(TARGET)" ]; then echo "❌ Error: TARGET required. Usage: make scaffold TARGET=../my-app [PROFILE=--enterprise]"; exit 1; fi
	@./scripts/sdlc-cli.sh scaffold $(TARGET) $(or $(PROFILE),--standard)

.PHONY: release
release: ## Generate release notes from Conventional Commits (usage: make release FROM=v0.9.0 TO=HEAD VERSION=v1.0.0)
	@./scripts/sdlc-cli.sh release $(or $(FROM),) $(or $(TO),HEAD) $(or $(VERSION),Release)

.PHONY: report
report: ## Generate 1-page weekly client flash status report (usage: make report DAYS=7)
	@./scripts/sdlc-cli.sh report "$$(basename $$(pwd))" $(or $(DAYS),7)

.PHONY: package
package: ## Package client handover deliverables into .tar.gz (usage: make package VER=v1.0.0)
	@./scripts/sdlc-cli.sh package . ./dist $(or $(VER),v1.0.0)

.PHONY: signoff
signoff: ## Generate signed client milestone acceptance certificate (usage: make signoff MILESTONE=M3 CLIENT="Acme")
	@./scripts/sdlc-cli.sh signoff $(or $(MILESTONE),M3-Client-UAT) "$(or $(CLIENT),Enterprise Client)" "$$(basename $$(pwd))"

.PHONY: smoke
smoke: ## Run synthetic post-verification smoke tests (usage: make smoke URL=http://localhost:8000)
	@./scripts/sdlc-cli.sh smoke $(or $(URL),http://localhost:8000) 10

.PHONY: hooks
hooks: ## Install local Git hooks for secrets scanning and Conventional Commits
	@./scripts/sdlc-cli.sh hooks

.PHONY: portal
portal: ## Launch documentation portal preview locally
	@./scripts/sdlc-cli.sh portal

.PHONY: test-links
test-links: ## Verify relative markdown link integrity across all files
	@python3 -c "\
import re, os, glob; \
broken = []; \
[broken.append((md, link, os.path.normpath(os.path.join(os.path.dirname(md), link.split('#')[0])))) \
 for md in glob.glob('**/*.md', recursive=True) \
 for _, link in re.findall(r'\[([^\]]+)\]\(([^)]+)\)', open(md, encoding='utf-8', errors='ignore').read()) \
 if not link.startswith(('http', '#', 'mailto:', 'file:')) and link.split('#')[0] and not os.path.exists(os.path.normpath(os.path.join(os.path.dirname(md), link.split('#')[0])))]; \
print('✅ Zero broken markdown links!') if not broken else (print(f'❌ Found {len(broken)} broken link(s):', broken), exit(1))"
