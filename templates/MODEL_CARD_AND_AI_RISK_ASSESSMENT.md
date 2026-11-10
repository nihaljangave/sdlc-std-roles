# Model Card & AI Risk Assessment Template

> **Document Status:** Draft / Under Review / Approved  
> **Model / Agent Name:** [e.g. Customer Support Copilot / Smart Extraction Engine]  
> **Model Baseline:** [e.g. Claude 3.5 Sonnet / GPT-4o / Llama 3 70B fine-tuned]  
> **Author / Lead AI Engineer:** [Name] &bull; **Target Release:** [v1.0.0]  
> **Date:** YYYY-MM-DD

---

## 1. Model Overview & Purpose

### Intended Use Cases
- [Describe the specific primary business problem this AI model/agent is intended to solve]
- [Target user persona and workflow context]

### Out-of-Scope & Prohibited Use Cases
- 🚫 [Explicitly list unsupported use cases, e.g. medical diagnosis, autonomous legal advice, financial underwriting]
- 🚫 [Prohibited inputs, e.g. unredacted payment cards, government classified data]

---

## 2. Training & Fine-Tuning Data Lineage

*(If using foundation models with zero fine-tuning, state "Zero fine-tuning; zero-shot / few-shot prompt orchestration only".)*

| Data Source | Record Count / Token Size | PII Sanitization Method | Licensing / IP Verification |
| :--- | :--- | :--- | :--- |
| Internal Knowledge Base Docs | ~45,000 chunks | Automated Presidio regex & entity masking | Company Proprietary Data |
| Curated Q&A Ground Truth Pairings | 1,200 verified pairs | Manual SME review & anonymization | Approved by Product Owner |

---

## 3. Evaluation Benchmarks & Quality Metrics

Document the quantitative test results against the evaluation dataset:

| Benchmark Dimension | Target Threshold | Actual Score | Status |
| :--- | :--- | :--- | :--- |
| **Context Relevance** | ≥ 0.85 | 0.91 | ✅ PASS |
| **Faithfulness / Groundedness** | ≥ 0.95 | 0.97 | ✅ PASS |
| **Answer Relevance** | ≥ 0.88 | 0.92 | ✅ PASS |
| **Adversarial / Jailbreak Defense** | 100% blocked | 100% (54/54) | ✅ PASS |
| **P95 Latency (First Token)** | < 1,000 ms | 640 ms | ✅ PASS |
| **P95 Latency (Full Completion)** | < 3,500 ms | 2,150 ms | ✅ PASS |

---

## 4. Bias, Fairness & Ethical Safeguards

1. **Bias Mitigation:** [Describe procedures used to evaluate model across demographic groups or diverse user queries]
2. **Hallucination Countermeasures:** [Detail groundedness checks, temperature settings (e.g. `temperature=0.0`), and strict system instructions to output "I do not know" when context is insufficient]
3. **Safety Fallback:** [If model outputs toxic or unsafe content, explain fallback behavior, e.g., circuit breaker returns canned customer support greeting]

---

## 5. Cost & Latency Budget Projection

| Operational Metric | Prototype Phase | Production Target (Peak) |
| :--- | :--- | :--- |
| **Estimated Requests / Day** | 500 req/day | 25,000 req/day |
| **Avg Prompt Tokens / Req** | 1,200 tokens | 650 tokens (post-rerank) |
| **Avg Completion Tokens / Req**| 250 tokens | 180 tokens |
| **Semantic Cache Hit Ratio** | 0% (cold cache) | 35% estimated |
| **Estimated Monthly Model Cost** | ~$45 / month | ~$920 / month |

---

## 6. Approvals & AI Risk Sign-off

| Role | Signatory Name | Decision (Approved / Rejected) | Date |
| :--- | :--- | :--- | :--- |
| **Lead AI / ML Engineer** | [Name] | [Approved] | YYYY-MM-DD |
| **System Architect** | [Name] | [Approved] | YYYY-MM-DD |
| **Data Protection Officer / CISO** | [Name] | [Approved] | YYYY-MM-DD |
| **Client Product Sponsor** | [Name] | [Approved] | YYYY-MM-DD |
