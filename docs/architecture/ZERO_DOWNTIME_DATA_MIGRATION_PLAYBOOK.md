# Zero-Downtime Database Migration & Schema Evolution Playbook
## The Expand / Contract (Parallel Run) Pattern for High-Velocity Releases

In fast-paced product development and production deployments, database migrations are the #1 cause of deployment failure and service downtime. If a release adds a required column, renames a column, or drops a table while older application containers are still serving traffic, queries fail instantly.

This playbook establishes the **Expand/Contract (Parallel Run) Migration Pattern**, ensuring that every database change is backward-compatible with active running pods.

---

## 1. The 3-Phase Expand / Contract Lifecycle

```mermaid
flowchart TD
    subgraph Release N (Expand Phase)
        A1["1. Add New Column / Table (Nullable)"] --> A2["2. Dual-Write to Both Old and New Columns"]
        A2 --> A3["3. Backfill Historical Data in Background"]
    end

    subgraph Release N+1 (Switch Phase)
        B1["4. Switch Reads to New Column"] --> B2["5. Verify Integrity & Remove Old Column Writes"]
    end

    subgraph Release N+2 (Contract Phase)
        C1["6. Drop Old Column / Deprecated Table Safely"]
    end

    A3 --> B1
    B2 --> C1
```

---

## 2. Standard Schema Modification Scenarios

### Scenario A: Renaming a Column (e.g., `phone` -> `mobile_number`)
*Never execute `ALTER TABLE users RENAME COLUMN phone TO mobile_number;` in production!*

1. **Step 1 (Expand - Release N):**
   Add the new column as nullable:
   ```sql
   ALTER TABLE users ADD COLUMN mobile_number VARCHAR(20) DEFAULT NULL;
   ```
2. **Step 2 (Dual Write - Release N):**
   Application code writes to both `phone` and `mobile_number`, but reads from `phone`.
3. **Step 3 (Backfill):**
   Run background script in small batches to avoid lock contention:
   ```sql
   UPDATE users 
   SET mobile_number = phone 
   WHERE mobile_number IS NULL AND phone IS NOT NULL 
   LIMIT 1000;
   ```
4. **Step 4 (Switch - Release N+1):**
   Update application code to read from `mobile_number`.
5. **Step 5 (Contract - Release N+2):**
   Drop the deprecated column:
   ```sql
   ALTER TABLE users DROP COLUMN phone;
   ```

---

### Scenario B: Adding a NOT NULL Column to a Large Table
*Never execute `ALTER TABLE orders ADD COLUMN status VARCHAR(20) NOT NULL;` without a default, or on massive tables without `CHECK` constraints!*

In PostgreSQL:
```sql
-- 1. Add column with default value (instant in PostgreSQL 11+)
ALTER TABLE orders ADD COLUMN status VARCHAR(20) DEFAULT 'PENDING';

-- 2. Validate constraint without locking the entire table
ALTER TABLE orders ADD CONSTRAINT check_status_not_null CHECK (status IS NOT NULL) NOT VALID;
ALTER TABLE orders VALIDATE CONSTRAINT check_status_not_null;
```

---

### Scenario C: Adding an Index on a Production Table
*Never run `CREATE INDEX` on production without `CONCURRENTLY`!*

```sql
-- Correct (Does NOT lock writes to the table):
CREATE INDEX CONCURRENTLY idx_orders_customer_id ON orders(customer_id);
```

---

## 3. Developer Pre-Commit Migration Checklist
Before any Pull Request containing a database migration is approved:
- [ ] Migration script is reversible (both `up` and `down` scripts tested).
- [ ] No table-locking operations without `CONCURRENTLY` or short statement timeouts.
- [ ] Statement timeout set to prevent indefinite lock acquisition:
  ```sql
  SET statement_timeout = '5s';
  ```
- [ ] Migration runtime dry-run tested against staging replica (< 60 seconds).
- [ ] Backward compatibility verified: previous container version still functions against the expanded schema.

