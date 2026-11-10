# Architecture Decision Record (ADR)
## ADR-[000]: [Short Title of the Decision]

| Attribute | Details |
|---|---|
| **Status** | `Draft` \| `Proposed` \| `Accepted` \| `Rejected` \| `Superseded by ADR-XXX` |
| **Date** | YYYY-MM-DD |
| **Author(s)** | [Name / Handle] |
| **Deciders / Reviewers** | [Names of Technical Leads / Architects involved] |
| **Impacted Services** | [Service A, Database, Deployment Pipeline] |

---

## 1. Context and Problem Statement
*Describe the context, technical problem, and business forces influencing this decision.*
- What challenge are we trying to solve?
- What are the constraints (budget, timeline, security, client preferences)?
- Example: "Our prototype needs a real-time event distribution mechanism to broadcast status updates to 10,000 active browser clients."

---

## 2. Decision Drivers (Key Requirements)
*List the essential criteria used to evaluate options:*
1. **Speed of Delivery:** Must be ready to integrate within 3 days.
2. **Operational Simplicity:** Low maintenance overhead for the existing operations team.
3. **Cost Efficiency:** Must stay within free/low-tier limits during prototype phase.
4. **Security & Protocol Support:** Must support WSS (secure WebSockets) and JWT authentication.

---

## 3. Considered Options
*Briefly describe the candidate solutions evaluated:*
- **Option 1:** [e.g., Self-hosted RabbitMQ on EC2]
- **Option 2:** [e.g., Managed AWS SQS + DynamoDB Streams]
- **Option 3:** [e.g., Redis Pub/Sub with Socket.io on ECS]

---

## 4. Decision Outcome
*Chosen Option:* **[Option 3: Redis Pub/Sub with Socket.io on ECS]**

### Rationale:
- The team already utilizes Redis for session storage and caching; no new infrastructure components need to be managed by Ops.
- Built-in horizontal scaling adapter (`@socket.io/redis-adapter`) allows seamless multi-container clustering.
- Sub-5ms broadcast latency validated during feasibility spike.

---

## 5. Pros and Cons of the Options

### Option 1: [Self-hosted RabbitMQ]
* **Pros:** Robust AMQP features, reliable dead-letter exchange handling.
* **Cons:** High operational burden on Ops team; requires dedicated monitoring and cluster maintenance.

### Option 2: [AWS SQS + DynamoDB Streams]
* **Pros:** Fully managed serverless setup.
* **Cons:** Higher end-to-end latency for bidirectional user chat; higher variable cost.

### Option 3: [Redis Pub/Sub with Socket.io] (Chosen)
* **Pros:** Zero additional infrastructure cost; team already has expertise; simple API integration.
* **Cons:** Redis pub/sub does not guarantee persistent delivery if a worker crashes (mitigated by storing message history in PostgreSQL).

---

## 6. Consequences & Downstream Impact
- **Positive:** Team delivers real-time notifications ahead of schedule; zero new cloud line-items.
- **Negative / Risks:** If Redis fails, real-time updates stop temporarily.
- **Mitigation:** Ops team configures Redis automated multi-AZ failover and CloudWatch memory alerts.

