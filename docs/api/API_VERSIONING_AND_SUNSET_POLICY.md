# API Versioning, Deprecation & Sunset Standard (SOP)
## Backward Compatibility, Version Lifecycle & Client Breaking Change Prevention

In fast-paced product development, breaking changes in APIs disrupt client mobile applications, third-party partner integrations, and operational webhooks. 

This standard establishes our **API Versioning Strategy and Deprecation Protocol**, ensuring clients have predictable notice before any endpoint is modified or retired.

---

## 1. URI Versioning Strategy (Standard)

- All RESTful APIs use explicit major version prefixes in the URL path:
  ```http
  https://api.clientdomain.com/v1/orders
  https://api.clientdomain.com/v2/orders
  ```
- **Rule:** A major version bump (`v1` -> `v2`) is triggered **only** when introducing breaking changes. Non-breaking additive changes (new optional query params, new fields in response JSON) are added directly to the current version.

---

## 2. Breaking vs. Non-Breaking Change Rules

| Change Type | Classification | Policy |
|---|---|---|
| **Adding a new endpoint** | Non-Breaking | Permitted directly in current version. |
| **Adding an optional request parameter** | Non-Breaking | Permitted directly in current version. |
| **Adding a new response field** | Non-Breaking | Permitted directly in current version (clients must use lenient parsers). |
| **Removing or renaming an existing field** | **Breaking** | Requires new API version (`v2`) + Deprecation notice. |
| **Changing a field's data type** | **Breaking** | Requires new API version (`v2`) + Deprecation notice. |
| **Adding a mandatory (required) request param** | **Breaking** | Requires new API version (`v2`) + Deprecation notice. |

---

## 3. Standard Deprecation & Sunset Protocol (RFC 8594)

When an endpoint is marked for deprecation:
1. **Response Headers Injected:**
   Every HTTP response from the deprecated endpoint returns standard RFC 8594 headers:
   ```http
   Deprecation: @1762775160
   Sunset: Wed, 11 Nov 2026 00:00:00 GMT
   Link: <https://api.clientdomain.com/docs/deprecations/v1-orders>; rel="deprecation"
   ```
2. **Minimum Notice Window:**
   - **Prototype / MVP Phase:** 14 calendar days notice.
   - **Enterprise Production Phase:** 90 calendar days minimum notice before shutdown.
3. **Telemetry Tracking:**
   Operations tracks remaining callers via Datadog/CloudWatch logs filtered by `http_path` and `tenant_id` to proactively reach out to lagging clients.
