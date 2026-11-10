# API Contract & Integration Specification

| Specification Details | Value |
|---|---|
| **API Name** | [Service API Name] |
| **Version** | v1.0.0 |
| **Protocol** | RESTful JSON / GraphQL / gRPC |
| **Base URL (Staging)** | `https://staging-api.clientdomain.com/v1` |
| **Base URL (Production)**| `https://api.clientdomain.com/v1` |
| **Interactive Docs** | `https://api.clientdomain.com/docs` (Swagger / ReDoc) |

---

## 1. General API Standards & Conventions

### 1.1 HTTP Methods
- `GET`: Retrieve resources (Idempotent, Safe, Cacheable).
- `POST`: Create a new resource or trigger an action.
- `PUT`: Replace an entire resource.
- `PATCH`: Partially update a resource.
- `DELETE`: Remove a resource (Idempotent).

### 1.2 Common Request Headers
```http
Authorization: Bearer <JWT_ACCESS_TOKEN>
Content-Type: application/json
Accept: application/json
X-Correlation-ID: c56a4180-65aa-42ec-a945-5fd21dec0538
Idempotency-Key: 7b2d5e71-92b1-4f1a-b610-ff99c4c772e1  (Required for POST payment/orders)
```

### 1.3 Standard JSON Response Wrapper
All successful responses return a predictable JSON payload:
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "page": 1,
    "limit": 20,
    "total_records": 154,
    "total_pages": 8
  },
  "timestamp": "2026-11-10T11:45:00Z"
}
```

### 1.4 Standard RFC 7807 Error Response
```json
{
  "success": false,
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "The requested order ID could not be found.",
    "correlation_id": "c56a4180-65aa-42ec-a945-5fd21dec0538",
    "details": [
      {
        "field": "order_id",
        "issue": "Order 10928 does not exist in tenant db"
      }
    ]
  },
  "timestamp": "2026-11-10T11:45:00Z"
}
```

---

## 2. Core API Endpoints

### 2.1 Endpoint: `POST /v1/orders`
*Create a new customer order with idempotency protection.*

#### Request Payload:
```json
{
  "customer_id": "cust_98127391",
  "items": [
    {
      "sku": "PROD-A100",
      "quantity": 2,
      "unit_price": 49.99
    }
  ],
  "shipping_address": {
    "street": "123 Tech Boulevard",
    "city": "Bengaluru",
    "postal_code": "560100",
    "country": "IN"
  }
}
```

#### Response (201 Created):
```json
{
  "success": true,
  "data": {
    "order_id": "ord_8829103",
    "status": "PENDING_PAYMENT",
    "total_amount": 99.98,
    "currency": "INR",
    "created_at": "2026-11-10T11:45:02Z"
  }
}
```

---

## 3. Webhook Specifications (Outbound to Client)
When asynchronous state changes occur (e.g., payment processed, shipment dispatched), webhooks are dispatched to client-registered endpoints.

- **Header Signature:** `X-Signature-SHA256: hmac_sha256(payload, client_secret)`
- **Retry Policy:** 5 retry attempts with exponential backoff (1m, 5m, 15m, 1h, 6h).
- **Dead Letter Handling:** Events failing all retries are sent to the Operations Dead Letter Queue (DLQ) for manual inspection.

---

## 4. Rate Limiting & Throttling
- **Standard Tier:** 100 requests per minute per API Key.
- **Enterprise / Burst Tier:** 1,000 requests per minute.
- **HTTP 429 Headers Returned:**
  ```http
  Retry-After: 60
  X-RateLimit-Limit: 100
  X-RateLimit-Remaining: 0
  X-RateLimit-Reset: 1762775160
  ```

---

## 5. Mock Sandbox Details for Fast-Paced Prototype Development
To decouple frontend and client integration teams from backend build timelines:
- Mock server available at: `https://mock-api.clientdomain.com/v1`
- Mock server responds with realistic fixture data defined in `/fixtures/api_mocks.json`.
- Postman Collection / OpenAPI 3.0 export link: `docs/api/collection.json`

