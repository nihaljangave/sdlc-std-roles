# Contract-First Mock API Server (Stoplight Prism)
## Decouple Frontend & Client Development with Instant OpenAPI Mocks

To enable frontend engineers, mobile developers, and client integration teams to build in parallel with backend development, run this containerized mock server. It consumes your `openapi.yaml` specification and provides dynamic, spec-compliant HTTP endpoints with realistic mock data.

---

## 1. Quick Start (Spin Up in 5 Seconds)

```bash
# Run the mock server from the project root:
docker compose -f automation-and-tooling/mock-server/docker-compose.mock.yml up -d
```

The mock API server will be live and listening at:
- **Base URL:** `http://localhost:4010`
- **Dynamic Response Validation:** Validates incoming payloads against your OpenAPI request schemas.

---

## 2. Testing the Mock Server

```bash
# Test a mocked endpoint:
curl -i http://localhost:4010/health/live

# Submit a mocked order:
curl -X POST http://localhost:4010/v1/orders \
  -H "Content-Type: application/json" \
  -H "Idempotency-Key: c56a4180-65aa-42ec-a945-5fd21dec0538" \
  -d '{"distributor_id": "dist_100", "line_items": [{"sku": "SKU-A", "quantity": 10}]}'
```

Prism will automatically respond with HTTP 201 Created and realistic mock payloads defined in your OpenAPI examples!

