import http from 'k6/http';
import { check, sleep } from 'k6';

/**
 * k6 Performance & Load Benchmark Script
 * Validates p95 latency < 300ms and error rate < 1% under 100 concurrent virtual users.
 */
export const options = {
  stages: [
    { duration: '30s', target: 20 },  // Ramp-up to 20 users
    { duration: '1m', target: 100 },  // Stay at 100 users (peak prototype load)
    { duration: '30s', target: 0 },   // Ramp-down to 0
  ],
  thresholds: {
    // SLO 1: 95% of requests must complete below 300ms
    http_req_duration: ['p(95)<300', 'p(99)<600'],
    // SLO 2: Error rate must be less than 1%
    http_req_failed: ['rate<0.01'],
  },
};

const BASE_URL = __ENV.TARGET_URL || 'https://staging-api.domain.com';

export default function () {
  // 1. Benchmark Health Liveness
  const liveRes = http.get(`${BASE_URL}/health/live`);
  check(liveRes, {
    'liveness status is 200': (r) => r.status === 200,
  });

  // 2. Benchmark Catalog Read Query
  const catalogRes = http.get(`${BASE_URL}/api/v1/products?limit=20`);
  check(catalogRes, {
    'catalog query is 200': (r) => r.status === 200,
    'response under 250ms': (r) => r.timings.duration < 250,
  });

  sleep(1);
}

