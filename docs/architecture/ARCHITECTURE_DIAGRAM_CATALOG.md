# Architecture Diagram Catalog & Patterns (Mermaid.js)
## Copy-Paste Visual System Models for System Architecture Documents (SAD)

Use these pre-tested, responsive Mermaid diagrams directly in your PRDs, Architecture Specs, and Client Presentations.

---

## 1. Pattern: Backend-for-Frontend (BFF) & Microservices

```mermaid
flowchart TD
    ClientWeb["Web Application (React / Next.js)"] -->|HTTPS / WSS| CDN["Cloudflare Edge"]
    ClientMobile["Mobile App (iOS / Android)"] -->|HTTPS| CDN

    CDN -->|In-Transit TLS 1.3| APIGW["API Gateway (Kong / AWS API GW)"]

    subgraph Core Services (Private Subnet)
        APIGW --> AuthSvc["Auth Service (OAuth2 / OIDC)"]
        APIGW --> OrderSvc["Order Service (Node / Go)"]
        APIGW --> CatalogSvc["Catalog Service (Python / FastAPI)"]
    end

    subgraph Data Tier
        OrderSvc --> OrderDB[("PostgreSQL Aurora (Multi-AZ)")]
        CatalogSvc --> CatalogDB[("PostgreSQL (Read Replica)")]
        CatalogSvc --> RedisCache[("Redis Cluster (Query Cache)")]
    end
```

---

## 2. Pattern: Asynchronous Event-Driven Decoupling

```mermaid
sequenceDiagram
    actor User as Customer
    participant API as Order API
    participant DB as Relational DB
    participant Queue as Event Broker (SQS / Kafka)
    participant Worker as Background Worker
    participant Payment as Third-Party Payment Gateway
    participant Email as SendGrid / SES

    User->>API: POST /v1/orders (Place Order)
    API->>DB: Insert Order (Status: PENDING)
    API->>Queue: Publish 'OrderCreatedEvent'
    API-->>User: 201 Created (Instant Response < 150ms)

    Queue->>Worker: Consume 'OrderCreatedEvent'
    Worker->>Payment: Charge Customer Card (Stripe)
    Payment-->>Worker: Payment Succeeded
    Worker->>DB: Update Order Status -> 'PAID'
    Worker->>Email: Dispatch Receipt Notification
```

---

## 3. Pattern: Multi-Tenant SaaS Isolation (Row-Level Security)

```mermaid
graph TD
    Request["Incoming API Request"] --> JWT["Extract JWT Token"]
    JWT --> Middleware["Tenant Identification Middleware"]
    Middleware --> SetConfig["SET LOCAL app.current_tenant_id = 'tenant_xyz'"]
    
    subgraph PostgreSQL Database
        SetConfig --> Table["Shared 'orders' Table"]
        Policy["RLS Policy: tenant_id = current_setting('app.current_tenant_id')"]
        Table -.-> Policy
        Policy --> IsolatedData["Tenant XYZ Data Only (Strictly Enforced by Engine)"]
    end
```

---

## 4. Pattern: OAuth2 / OpenID Connect Authentication Flow

```mermaid
sequenceDiagram
    actor User as User Browser
    participant App as Single-Page App (SPA)
    participant IdP as Identity Provider (Auth0 / Okta / Cognito)
    participant API as Resource API

    User->>App: Click 'Login'
    App->>IdP: Redirect to /authorize (PKCE Challenge)
    IdP-->>User: Present Login / MFA Screen
    User->>IdP: Submit Credentials & MFA
    IdP-->>App: Redirect with Auth Code
    App->>IdP: POST /token (Auth Code + PKCE Verifier)
    IdP-->>App: Return JWT Access Token + ID Token
    App->>API: GET /api/v1/profile (Authorization: Bearer <JWT>)
    API-->>App: 200 OK Profile Data
```

