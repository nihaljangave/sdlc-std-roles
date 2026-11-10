# Fast-Track Documentation & Automation Playbook
## How to Automate Artifacts so Developers Move Fast Without Manual Documentation Drudgery

The key to fast-paced product development without compromising formal client and operational documentation is **Continuous Automated Documentation (Doc-as-Code)**.

---

## 1. Automated API Documentation (Contract-First / Code-First)

### Why:
Never write API docs manually in Word or Confluence. It goes out of date on day one.

### How:
- **Node.js (NestJS / Fastify):** Use `@nestjs/swagger` or `@fastify/swagger` to annotate controllers. Swagger UI is generated at `/docs` on every build.
- **Python (FastAPI):** Built-in OpenAPI 3.0 generation at `/docs` and `/redoc`.
- **Go (Gin/Echo):** Use `swag` (`swag init`) to generate Swagger 2.0/3.0 directly from comment annotations.

```bash
# Example: Generate OpenAPI YAML specification in CI
npm run docs:generate-openapi > docs/api/openapi.yaml
```

---

## 2. Automated Architecture & Database Diagrams

### Why:
Manually drawing architecture diagrams in Visio or PowerPoint slows down sprints.

### How:
- **Mermaid.js in Markdown:** Render all architecture and sequence diagrams directly in GitHub/GitLab markdown. Diagrams are version-controlled alongside code.
- **Database Schema Visualization:** Use tools like `prisma generate`, `tbls`, or `SchemaSpy` in your CI pipeline to auto-generate ERDs from migrations.

```bash
# Example: Auto-generate ERD diagram using tbls
tbls doc postgres://user:pass@localhost:5432/dbname docs/schema
```

---

## 3. Automated Changelogs via Conventional Commits

### Why:
Client release notes and ops changelogs shouldn't require manual drafting.

### How:
Adopt the **Conventional Commits** specification:
- `feat(auth): add OAuth2 Google login flow`
- `fix(orders): handle timeout on payment gateway retry`
- `perf(db): add composite index on tenant_id and created_at`
- `docs(api): update order status enum in swagger`

Use `standard-version` or `release-please` (Google GitHub Action):
```bash
# Automatically increments semver, generates CHANGELOG.md, and creates git tag
npx standard-version
git push --follow-tags origin main
```

---

## 4. Automated Git Pre-Commit Hooks (Husky + lint-staged)

Prevent non-compliant code and secrets from ever entering the repository:

```bash
# Install Husky
npm install husky lint-staged --save-dev
npx husky init
```

`.husky/pre-commit`:
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# 1. Run secret scanner (ensure no API keys or credentials leaked)
trufflehog git file://. --since-commit HEAD --fail

# 2. Run linter and type-checker on staged files
npx lint-staged

# 3. Verify commit message format
npx commitlint --edit $1
```

---

## 5. GitHub Actions Continuous Compliance Pipeline (`.github/workflows/compliance.yml`)

Sample CI workflow ensuring every pull request meets the required formalities:

```yaml
name: Continuous Compliance & Verification

on:
  pull_request:
    branches: [main, release/*]

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'

      - name: Install Dependencies
        run: npm ci

      - name: Static Security Scan (SAST)
        uses: securego/gosec@master # or SonarCloud / Semgrep
        with:
          args: ./...

      - name: Software Composition Analysis (SCA)
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      - name: Run Test Suites with Coverage
        run: npm test -- --coverage --ci

      - name: Verify Coverage Thresholds (>= 80%)
        run: npx nyc check-coverage --lines 80 --functions 80 --branches 75

      - name: Validate OpenAPI Schema Sync
        run: |
          npm run docs:generate-openapi
          git diff --exit-code docs/api/openapi.yaml || (echo "OpenAPI spec is out of sync with code! Run npm run docs:generate-openapi" && exit 1)
```

