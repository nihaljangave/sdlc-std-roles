# Production Telemetry & Observability Standard
## Structured Logging, RED/USE Metrics, Distributed Tracing & Health Probes

To ensure that the Operations / SRE team can support the product effectively post-handover, all services built under this framework must comply with the following observability baseline.

---

## 1. Structured JSON Logging Standard

All log entries emitted to `stdout` must be single-line JSON objects conforming to the following schema. Never log multi-line text or un-parsed stack traces directly in production.

### Required Fields Schema:
```json
{
  "timestamp": "2026-11-10T12:00:00.123Z",
  "level": "INFO",
  "service": "order-service",
  "environment": "production",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "span_id": "00f067aa0ba902b7",
  "request_id": "c56a4180-65aa-42ec-a945-5fd21dec0538",
  "user_id": "usr_99812",
  "tenant_id": "tenant_corp_42",
  "http_method": "POST",
  "http_path": "/api/v1/orders",
  "http_status": 201,
  "duration_ms": 142.5,
  "message": "Order successfully created and queued for fulfillment",
  "error": null
}
```

### Log Level Guidelines:
- `DEBUG`: Verbose diagnostics (disabled in production unless active investigation).
- `INFO`: Business milestones (user logged in, order placed, batch job completed).
- `WARN`: Recoverable degradation (cache miss fallback, rate-limit threshold near, 4xx client errors).
- `ERROR`: System failure requiring operational attention (unhandled 5xx exceptions, DB timeout, third-party API outage).
- `FATAL`: Process exiting abnormally (unhandled panic, OOM crash).

### PII Sanitization Rule:
**Strict Prohibition:** Never log credit card numbers, passwords, session tokens, JWTs, national IDs, or unmasked email addresses.

---

## 2. Standard Service Metrics (RED & USE Methodologies)

### 2.1 The RED Method (Request-Driven Services)
Every HTTP / gRPC service exposes Prometheus metrics under `/metrics`:

| Metric Name | Type | Description & Labels |
|---|---|---|
| `http_requests_total` | Counter | Total request volume labeled by `method`, `path`, `status_code` |
| `http_request_duration_seconds` | Histogram | Request latency with standard buckets: `[0.01, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5, 5.0]` |
| `http_requests_in_flight` | Gauge | Active concurrent connections currently being processed |

### 2.2 The USE Method (Infrastructure & Resources)
Monitored via CloudWatch / Datadog Agent:
- **Utilization:** CPU %, Memory %, Disk I/O %, DB Connection Pool %.
- **Saturation:** Queue depth (SQS / RabbitMQ), Thread pool queue size, Network socket backlog.
- **Errors:** Dropped packets, OOM events, disk write errors.

---

## 3. Distributed Tracing & Context Propagation

- All inbound requests must accept or generate W3C Trace Context headers:
  ```http
  traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
  ```
- When making outbound HTTP calls to third-party or downstream services, forward the `traceparent` and `X-Correlation-ID` headers to preserve the end-to-end trace.

---

## 4. Health Probe Contract (Kubernetes / ECS / Load Balancer)

Every service must expose two distinct HTTP endpoints:

### 4.1 Liveness Probe (`GET /health/live`)
- **Purpose:** Verifies whether the process is alive and responsive.
- **Rules:** Must NOT check downstream databases or external services (prevents cascading restarts during DB hiccups).
- **Success:** Returns HTTP `200 OK` `{"status": "alive"}` within 50ms.

### 4.2 Readiness Probe (`GET /health/ready`)
- **Purpose:** Verifies whether the service can actively serve traffic.
- **Rules:** Checks connectivity to primary PostgreSQL database and Redis cluster.
- **Behavior:** If DB pool is down, return HTTP `503 Service Unavailable`. Traffic is automatically routed away from this container until recovered.

