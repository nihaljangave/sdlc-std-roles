import { test, expect } from '@playwright/test';

/**
 * Synthetic Production Verification Test (PVT) / Smoke Suite.
 * Executed immediately post-deployment to verify live environment health.
 */
test.describe('Synthetic Production Verification Suite', () => {

  test('PVT-01: Health check endpoints return healthy status', async ({ request }) => {
    // 1. Verify liveness
    const liveRes = await request.get('/health/live');
    expect(liveRes.status()).toBe(200);
    const liveBody = await liveRes.json();
    expect(liveBody.status).toBe('ok');

    // 2. Verify readiness (DB & cache pools connected)
    const readyRes = await request.get('/health/ready');
    expect(readyRes.status()).toBe(200);
    const readyBody = await readyRes.json();
    expect(readyBody.database).toBe('connected');
  });

  test('PVT-02: API returns valid OpenAPI documentation schema', async ({ request }) => {
    const docRes = await request.get('/docs/openapi.json');
    expect(docRes.status()).toBe(200);
    const schema = await docRes.json();
    expect(schema.openapi).toMatch(/^3\./);
  });

  test('PVT-03: Synthetic order placement with Idempotency Key', async ({ request }) => {
    const idempotencyKey = `pvt-smoke-${Date.now()}`;
    const orderRes = await request.post('/api/v1/orders', {
      headers: {
        'Idempotency-Key': idempotencyKey,
        'Authorization': `Bearer ${process.env.SMOKE_TEST_TOKEN || 'synthetic-test-token'}`,
        'Content-Type': 'application/json',
      },
      data: {
        customer_id: 'cust_smoke_test',
        items: [{ sku: 'PROD-TEST-ITEM', quantity: 1, unit_price: 10.00 }],
        is_synthetic_test: true,
      },
    });

    // Should return 201 Created or 200 OK
    expect([200, 201]).toContain(orderRes.status());
    const body = await orderRes.json();
    expect(body.data.order_id).toBeDefined();
  });
});

