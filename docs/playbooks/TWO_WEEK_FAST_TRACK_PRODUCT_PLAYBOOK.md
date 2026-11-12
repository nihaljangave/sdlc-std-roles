# 2-Week Fast-Track Product Delivery Playbook

> **Fast-Paced Startup & Enterprise MVP Execution Guide**  
> **Target Delivery Window:** 10 Working Days (2 Calendar Weeks)  
> **Cost Baseline:** **$0 Upfront Infrastructure Cost** (Free Tiers for Initial $N$ Users)  
> **Audience:** Technical Leads, Solo Founders, Full-Stack Engineers, Product Managers  
> **Compliance Target:** 100% Embedded Stage-Gate Documentation (SOC 2 & ISO 27001 Ready)  

---

## 1. Executive Summary & Philosophy

When building a new software product under aggressive deadlines, teams typically make one of two fatal mistakes:
1. **Over-Engineering (The Bureaucracy Trap):** Spending 6 weeks discussing Kubernetes clusters, VPC peering, and writing 100-page specs before writing a single line of code.
2. **Under-Engineering (The Prototype Trap):** Hacking together un-typed code with hardcoded credentials and no documentation, resulting in security vulnerabilities, zero test coverage, and catastrophic failure during enterprise client reviews or investor due diligence.

This playbook provides a **pre-formalized, zero-decision blueprint**. By standardizing on an opinionated, modern cloud stack where every service offers a generous free tier, engineering teams can build, test, document, and deploy a secure, compliant SaaS product to production in **exactly 10 working days**.

---

## 2. The Pre-Formalized "Zero-Dollar" Architecture Stack

The entire stack is pre-decided. No architectural debates are required during the 2-week window.

```mermaid
flowchart TD
    User["🌐 End User / Client Browser"] --> Cloudflare["Cloudflare Edge (DNS + SSL + DDoS + WAF)<br/><i>Free Forever</i>"]
    Cloudflare --> Vercel["Vercel Edge & Serverless<br/>Next.js 15 (App Router) + TypeScript + Tailwind + shadcn/ui<br/><i>Free Hobby Tier</i>"]

    subgraph DataPlane["Data & Storage Plane"]
        Vercel --> SupabaseDB["Supabase Managed PostgreSQL<br/>500MB DB + Row-Level Security (RLS) + Realtime<br/><i>Free Tier (50k MAU)</i>"]
        Vercel --> CloudflareR2["Cloudflare R2 Object Storage<br/>S3-Compatible Document/Image Storage<br/><i>10GB Free + $0 Egress Fees</i>"]
    end

    subgraph ServicePlane["Third-Party Managed Services"]
        Vercel --> Auth["Supabase Auth / Clerk<br/>OAuth + Magic Links + WebAuthn MFA<br/><i>10k–50k MAU Free</i>"]
        Vercel --> Resend["Resend Transactional Email<br/>React Email Templates<br/><i>3,000 emails/mo Free</i>"]
        Vercel --> Stripe["Stripe Payments<br/>Hosted Checkout + Customer Portal<br/><i>$0/mo (Pay-as-you-go)</i>"]
    end

    subgraph ObservabilityPlane["Telemetry & Security Plane"]
        Vercel --> PostHog["PostHog Product Analytics<br/>User Funnels + Session Replays<br/><i>1,000,000 events/mo Free</i>"]
        Vercel --> Sentry["Sentry Error Tracing<br/>Real-Time Exception Alerts<br/><i>5,000 errors/mo Free</i>"]
        Vercel --> GitHubCI["GitHub Actions CI/CD<br/>Lint + Trivy + SBOM + Gate Audit<br/><i>2,000 min/mo Free</i>"]
    end
```

### Stack Component Details & Free Tier Allocations

| System Domain | Recommended Technology | Free Tier Allocation ($N$ Users) | Why This Over Alternatives? |
| :--- | :--- | :--- | :--- |
| **Frontend & API** | **Next.js 15** on **Vercel** | Unlimited deploys, 100GB bandwidth, serverless execution | Single repository micro-monolith; automated Git preview URLs for every pull request. |
| **Database** | **Supabase (PostgreSQL)** | 500 MB database, 500k Edge API requests | Native Postgres with Row-Level Security (RLS) for multi-tenant data segregation. |
| **Authentication** | **Supabase Auth** or **Clerk** | **10,000 to 50,000 MAU** | Pre-built login dialogs, Google/GitHub OAuth, session JWTs, and multi-factor auth (MFA). |
| **Object Storage** | **Cloudflare R2** | **10 GB storage / month**, **$0 egress fees** | S3-compatible API. Unlike AWS S3, Cloudflare charges zero bandwidth download fees. |
| **Transactional Email** | **Resend** | **3,000 emails / month** (100/day) | Type-safe React components for transactional email templates. |
| **Payments & Billing** | **Stripe** | **$0 / month** (standard 2.9% + 30¢ per charge) | Pre-built hosted Stripe Checkout & Customer Self-Service Portal; sandbox testing is free. |
| **DNS & Edge Defense** | **Cloudflare** | **Free forever** | Free SSL certificates, automatic HTTP/3, global CDN caching, and automated DDoS mitigation. |
| **Product Analytics** | **PostHog Cloud** | **1,000,000 events / month** + 5,000 replays | Product analytics, user funnel drop-offs, and session replay without high cost. |
| **Error Monitoring** | **Sentry** | **5,000 errors / month** | Instant stack-trace alerting on unhandled backend and client exceptions. |
| **CI/CD & Security** | **GitHub Actions** | **2,000 build minutes / month** | Runs automated tests, Gitleaks secrets detection, and stage-gate compliance. |

---

## 3. The 10-Day Sprint Schedule (Gate-by-Gate)

```mermaid
gantt
    title 2-Week Fast-Track Execution Timeline & Critical Path
    dateFormat  X
    axisFormat Day %s

    section 1. Governance & Gates
    Gate 0 Lock (Scope & PRD)         :milestone, g0, 1, 1
    Gate 1 Review (Arch & Security)   :milestone, g1, 2, 2
    Gate 2 Freeze (DoD & Unit Tests)  :milestone, g2, 7, 7
    Gate 3 Sign-Off (Client UAT)      :milestone, g3, 8, 8
    Gate 4 Handover (DR & Package)    :milestone, g4, 9, 9
    Gate 5 Cutover (Production Live)  :milestone, g5, 10, 10

    section 2. Architecture & Design
    PRD & User Journey Mapping        :active, prd, 1, 1
    SAD & C4 Diagramming              :arch, 1, 2
    OpenAPI Specification             :api, 2, 2
    STRIDE Threat Model & Data Flow   :crit, sec, 2, 2

    section 3. Core SaaS Engineering
    Repo Scaffolding & Free Tiers     :scaff, 3, 3
    Supabase DB Schema & RLS Policies :crit, db, 3, 4
    Auth Integration (OAuth + JWT)    :auth, 4, 4
    Core Revenue/Value Feature        :crit, feat, 4, 5
    Stripe Checkout & Webhooks        :pay, 5, 5
    Resend Email & shadcn/ui Polish   :ui, 6, 6

    section 4. Security & QA
    CI Compliance Workflow (.github)  :ci, 3, 3
    Playwright E2E Test Suite         :crit, e2e, 6, 7
    Client Staging Walkthrough & UAT  :crit, uat, 7, 8
    Milestone Acceptance Certificate  :cert, 8, 8

    section 5. Operations & Handover
    Automated DR Restoration Drill    :dr, 8, 9
    CycloneDX SBOM Manifest (make sbom):sbom, 9, 9
    Handover Bundle (make package)    :pkg, 9, 9
    Production DNS Cutover & Smoke    :crit, live, 10, 10
```

### 3.1 Velocity Tracker: "Where Are We & How Fast Must We Go?"

Use this milestone burn-up table at your daily 09:30 standup to track progress against the 10-day invariant launch date:

| Day | Timeline Elapsed | Target Gate Milestone | Required Daily Deliverable | 17:00 Daily Gatekeeper Rule & Velocity Action |
|:---:|:---:|:---:|:---|:---|
| **Day 1** | **10%** | **Gate 0 Lock** | `docs/PRD.md` & `PROJECT_CHARTER.md` | ⚠️ **Red Alert if scope exceeds 1 core workflow.** Cut all secondary features to Phase 2 immediately. |
| **Day 2** | **20%** | **Gate 1 Clearance** | `SAD.md`, `IDD.md`, `THREAT_MODEL.md` | ⚠️ **Red Alert if database schema is undefined.** Freeze schema design by 17:00 so coding begins unblocked on Day 3. |
| **Day 3** | **30%** | **Infra Connected** | Scaffolding complete, Vercel/Supabase linked | 🟡 **Yellow Alert if free tiers aren't provisioned.** Verify `make doctor` passes with zero failures. |
| **Day 4** | **40%** | **Data & Auth Ready** | Tables live, RLS active, Auth functional | ⚠️ **Red Alert if Auth isn't working.** Fall back to basic Supabase Email/Password; defer secondary OAuth providers. |
| **Day 5** | **50%** | **Value Loop Complete** | Core workflow functional + Stripe Checkout | 🟢 **Halfway Milestone:** Generate `make report DAYS=5` for executive/client review before the weekend. |
| **Day 6** | **60%** | **Polish & Emails** | Resend templates live, UI responsive | 🟡 **Yellow Alert if UI has custom CSS bugs.** Revert to standard `@shadcn/ui` pre-styled primitives. |
| **Day 7** | **70%** | **Gate 2 Feature Freeze** | 100% code frozen, E2E tests passing | 🛑 **STRICT FEATURE FREEZE:** No new feature code permitted after 17:00. Only defect remediation allowed. |
| **Day 8** | **80%** | **Gate 3 UAT Sign-Off** | `TEST_PLAN_AND_UAT.md` signed by client | ⚠️ **Red Alert if client reports P1 bugs.** Mobilize war room; execute `make signoff` the moment acceptance is granted. |
| **Day 9** | **90%** | **Gate 4 Ops Handover** | DR drill certificate, SBOM, handover tarball | 🟡 **Verify Handover Package:** Ensure `make package` bundles all 30 formal documents without errors. |
| **Day 10** | **100%** | **Gate 5 Live Launch** | Custom domain live on Cloudflare, `make smoke` | 🎉 **100% COMPLETE:** Run `make audit GATE=all`. Hand over runbook to Day-2 support team. |

---

### Day 1 (Monday): Gate 0 — Scope & Charter Lock
- **Objective:** Freeze the product scope. Identify the **Single Core Value Loop** (1 primary user journey). Strictly relegate all other feature requests to "Post-MVP / Phase 2".
- **Deliverables Completed:**
  - [`docs/PRD.md`](../../templates/PRD_TEMPLATE.md): Product Requirements Document with user stories and acceptance criteria.
  - [`docs/PROJECT_CHARTER.md`](../../templates/PROJECT_CHARTER_AND_SOW.md): Signed Statement of Work, milestone milestones, and commercial constraints.
- **Verification Command:**
  ```bash
  ./scripts/sdlc-cli.sh audit 0 .
  ```

### Day 2 (Tuesday): Gate 1 — Architecture, Security & Schemas
- **Objective:** Pre-define data models, API endpoints, and threat boundaries before writing business logic.
- **Deliverables Completed:**
  - [`docs/architecture/SAD.md`](../../templates/SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md): System Architecture Document with C4 context diagram.
  - [`docs/architecture/IDD.md`](../../templates/INFRASTRUCTURE_DESIGN_DOCUMENT_IDD.md): Cloud topology specification (Vercel + Supabase + Cloudflare).
  - [`docs/api/API_SPECIFICATION.md`](../../templates/API_CONTRACT_AND_INTEGRATION_SPEC.md): OpenAPI contract specification.
  - [`docs/security/SECURITY_REVIEW.md`](../../templates/SECURITY_AND_DATA_PRIVACY_CHECKLIST.md) & [`docs/security/THREAT_MODEL.md`](../../templates/STRIDE_THREAT_MODEL_TEMPLATE.md): STRIDE threat assessment.
- **Verification Command:**
  ```bash
  ./scripts/sdlc-cli.sh audit 1 .
  ```

### Day 3 (Wednesday): Repo Scaffolding & Cloud Plumbing
- **Objective:** Bootstrap the project directory and connect the cloud free tiers.
- **Execution:**
  ```bash
  # 1. Scaffold target repo with enterprise compliance templates:
  ./scripts/sdlc-cli.sh scaffold ../my-new-product --enterprise

  # 2. Navigate to project, verify workstation, and install security hooks:
  cd ../my-new-product
  make doctor
  make hooks
  ```
- **Cloud Setup:**
  - Create Supabase project (`app-prod`).
  - Link GitHub repository to Vercel.
  - Add domain to Cloudflare DNS.

### Day 4 (Thursday): Auth & Database Schemas
- **Objective:** Provision database tables, enable **Row-Level Security (RLS)**, and wire up authentication.
- **Tasks:**
  - Run SQL migrations in Supabase: Create `tenants`, `users`, and core domain tables.
  - Enable RLS policies: Ensure users can only read/write their own records (`auth.uid() = user_id`).
  - Wire up Next.js Middleware to protect private routes (`/dashboard/*`).
- **Deliverables Completed:**
  - Record the stack decision in `docs/adr/ADR-001-database-and-auth-stack.md`.

### Day 5 (Friday): Core Business Logic & Stripe Payments
- **Objective:** Complete the primary revenue-generating or customer workflow and connect billing.
- **Tasks:**
  - Implement the core application feature (e.g. data processing, generation, or workflow).
  - Wire up Stripe Checkout session creator and Stripe webhook endpoint (`/api/webhooks/stripe`) to handle `checkout.session.completed`.
- **End-of-Week 1 Status Report:**
  ```bash
  # Generate executive flash report from Git history for stakeholders:
  make report DAYS=5
  ```

### Day 6 (Monday): Transactional Email & UX Polish
- **Objective:** Complete user lifecycle communications and polish frontend aesthetics.
- **Tasks:**
  - Configure Resend with a custom domain SPF/DKIM record in Cloudflare.
  - Build React Email templates: `WelcomeEmail.tsx` and `InvoiceReceipt.tsx`.
  - Refine UI with `@shadcn/ui` components (accessible dialogs, forms, toasts).

### Day 7 (Tuesday): Gate 2 — Feature Freeze & Automated Testing
- **Objective:** Lock all feature code. Write automated unit and integration tests.
- **Tasks:**
  - Write Playwright E2E test verifying: Signup → Core Action → Checkout → Confirmation.
  - Ensure all PRs pass GitHub Actions CI checks (`.github/workflows/ci-compliance.yml`).
  - Verify PRs against [`templates/DEFINITION_OF_DONE_AND_CODE_REVIEW.md`](../../templates/DEFINITION_OF_DONE_AND_CODE_REVIEW.md).
- **Verification Command:**
  ```bash
  ./scripts/sdlc-cli.sh audit 2 .
  ```

### Day 8 (Wednesday): Gate 3 — Client / Stakeholder UAT Sign-Off
- **Objective:** Walk client or executive stakeholders through the working staging preview.
- **Tasks:**
  - Execute test scripts documented in [`templates/TEST_PLAN_AND_UAT_SIGNOFF.md`](../../templates/TEST_PLAN_AND_UAT_SIGNOFF.md).
  - Remediate any minor punch-list items.
  - Obtain formal client sign-off and generate the cryptographically stamped certificate:
    ```bash
    make signoff MILESTONE="M3-Client-UAT" CLIENT="Acme Corporation"
    ```
- **Verification Command:**
  ```bash
  ./scripts/sdlc-cli.sh audit 3 .
  ```

### Day 9 (Thursday): Gate 4 — Operational Readiness & DR Drill
- **Objective:** Verify operational resilience and prepare handover deliverables.
- **Tasks:**
  - Execute Disaster Recovery Point-in-Time Recovery drill:
    ```bash
    make dr-drill SYSTEM="Supabase-Postgres"
    ```
  - Generate CycloneDX v1.5 Software Bill of Materials:
    ```bash
    make sbom
    ```
  - Generate release notes from Conventional Commits:
    ```bash
    make release FROM=v0.1.0 TO=HEAD VERSION=v1.0.0
    ```
  - Consolidate all formal handover artifacts into a compressed archive:
    ```bash
    make package VER=v1.0.0
    ```
  - Complete [`templates/OPERATIONS_RUNBOOK.md`](../../templates/OPERATIONS_RUNBOOK.md) and [`templates/GO_LIVE_READINESS_REVIEW_GLRR.md`](../../templates/GO_LIVE_READINESS_REVIEW_GLRR.md).
- **Verification Command:**
  ```bash
  ./scripts/sdlc-cli.sh audit 4 .
  ```

### Day 10 (Friday): Gate 5 — Production DNS Cutover & Warranty Handover
- **Objective:** Traffic cutover to custom domain and formal service transition.
- **Tasks:**
  - Route apex domain DNS to Vercel via Cloudflare CNAME.
  - Run synthetic production verification test (PVT):
    ```bash
    make smoke URL=https://your-domain.com
    ```
  - Hand over [`templates/SERVICE_LEVEL_AGREEMENT_SPECIFICATION.md`](../../templates/SERVICE_LEVEL_AGREEMENT_SPECIFICATION.md) and [`templates/SERVICE_TRANSITION_CHECKLIST.md`](../../templates/SERVICE_TRANSITION_CHECKLIST.md).
- **Final Master Audit:**
  ```bash
  make audit GATE=all
  ```
- **Result:** **Product is live, generating value, 100% auditable, with zero technical debt.**

---

## 4. Production Environment Template (`.env.example`)

Copy this pre-configured template to `.env.local` during project initialization:

```bash
# ==============================================================================
# 2-Week Fast-Track Production Environment Variables
# ==============================================================================

# 1. Application & Domain
NEXT_PUBLIC_APP_URL="https://your-domain.com"
NEXT_PUBLIC_APP_NAME="Acme-Product"

# 2. Database & Auth (Supabase - Free Tier: 500MB DB, 50k MAU)
NEXT_PUBLIC_SUPABASE_URL="https://xxxxxxxxxxxx.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJhbGciOi..."
SUPABASE_SERVICE_ROLE_KEY="eyJhbGciOi..."
DATABASE_URL="postgresql://postgres:[PASSWORD]@db.xxxxxxxx.supabase.co:5432/postgres"

# 3. Object Storage (Cloudflare R2 - Free Tier: 10GB, $0 Egress)
R2_ACCOUNT_ID="your-cloudflare-account-id"
R2_ACCESS_KEY_ID="your-r2-access-key-id"
R2_SECRET_ACCESS_KEY="your-r2-secret-access-key"
R2_BUCKET_NAME="production-assets"
NEXT_PUBLIC_R2_PUBLIC_URL="https://assets.your-domain.com"

# 4. Transactional Email (Resend - Free Tier: 3k emails/mo)
RESEND_API_KEY="re_xxxxxxxxxxxx"
EMAIL_FROM="Acme <notifications@your-domain.com>"

# 5. Payments (Stripe - $0/mo Pay-as-you-go)
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="pk_live_..."
STRIPE_SECRET_KEY="sk_live_..."
STRIPE_WEBHOOK_SECRET="whsec_..."
STRIPE_PRICE_PRO_MONTHLY="price_..."

# 6. Observability (Sentry & PostHog - Free Tiers)
NEXT_PUBLIC_POSTHOG_KEY="phc_xxxxxxxxxxxx"
NEXT_PUBLIC_POSTHOG_HOST="https://us.i.posthog.com"
SENTRY_DSN="https://xxxx@o0.ingest.sentry.io/xxxx"
```

---

## 5. Pre-Mapping Matrix of the Framework's 30 Deliverables

Because this stack is pre-decided, you do not write documents from a blank page. The 30 deliverables in `templates/` map directly to this architecture:

| Framework Deliverable | Pre-Answered Architectural Decisions |
| :--- | :--- |
| **`SYSTEM_ARCHITECTURE_DOCUMENT_SAD.md`** | Micro-monolith architecture: Next.js 15 App Router on Vercel Serverless + Supabase PostgreSQL. |
| **`INFRASTRUCTURE_DESIGN_DOCUMENT_IDD.md`** | Cloud topology: Cloudflare global edge network, Vercel Serverless US-East, Supabase AWS us-east-1. |
| **`SECURITY_AND_DATA_PRIVACY_CHECKLIST.md`** | Data encrypted at rest via AWS KMS (Supabase) + in transit via TLS 1.3 (Cloudflare) + RLS tenant isolation. |
| **`OPERATIONS_RUNBOOK.md`** | Service dashboards: Vercel Deployments, Supabase Studio, Stripe Dashboard, Cloudflare Analytics. |
| **`DISASTER_RECOVERY_AND_BACKUP_DRILL_SOP.md`** | RTO < 30m, RPO < 5m backed by Supabase automated WAL archiving and Cloudflare R2 replication. |
| **`THIRD_PARTY_VENDOR_SECURITY_ASSESSMENT.md`** | Pre-populated sub-processors: Vercel (SOC 2), Supabase (SOC 2), Cloudflare (ISO 27001), Stripe (PCI Level 1). |
| **`SERVICE_LEVEL_AGREEMENT_SPECIFICATION.md`** | 99.9% uptime commitment backed by Vercel and Cloudflare infrastructure SLAs. |

---

## 6. Emergency Scope-Control Rules (The 1-In, 1-Out Rule)

When executing inside a strict 2-week window, stakeholders will inevitably ask: *"Can we also add feature X?"*

To protect the launch deadline, enforce the **1-In, 1-Out Rule** per [`docs/governance/SCOPE_CREEP_AND_BUDGET_MANAGEMENT_PLAYBOOK.md`](../governance/SCOPE_CREEP_AND_BUDGET_MANAGEMENT_PLAYBOOK.md):
1. **The Timebox is Invariant:** The 10-day launch date cannot move.
2. **Trade-Off Requirement:** If a new feature is added, an equivalent feature of identical estimation **must be cut** and moved to Phase 2.
3. **Written Change Request:** Any scope alteration requires an executed [`templates/CHANGE_REQUEST_FORM.md`](../../templates/CHANGE_REQUEST_FORM.md).

---

## 7. Related Framework Assets

- [Practitioner's Guide: How to Use This Framework](../../HOW_TO_USE_THIS_FRAMEWORK.md)
- [Fast-Track Automation Playbook](../../automation-and-tooling/FAST_TRACK_AUTOMATION_PLAYBOOK.md)
- [Scope Creep & Budget Management Playbook](../governance/SCOPE_CREEP_AND_BUDGET_MANAGEMENT_PLAYBOOK.md)
- [Disaster Recovery & Backup Drill SOP](../ops/DISASTER_RECOVERY_AND_BACKUP_DRILL_SOP.md)
- [Enterprise Security Questionnaire Playbook](../compliance/ENTERPRISE_SECURITY_QUESTIONNAIRE_PLAYBOOK.md)

