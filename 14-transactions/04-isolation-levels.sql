-- ============================================
-- ISOLATION LEVELS: reason about concurrent transactions
-- ============================================

-- 1. CONCEPT
-- Isolation controls which concurrent committed changes a transaction can observe
-- and which anomalies concurrent transactions can create.

-- 2. WHY IT IS USED
-- A correct single query does not guarantee a correct multi-step operation under
-- concurrent writes. Isolation defines the database's concurrency contract.

-- 3. POSTGRESQL BEHAVIOR
-- READ UNCOMMITTED behaves as READ COMMITTED in PostgreSQL.
-- READ COMMITTED is the default: each command gets a fresh snapshot, so two SELECTs
-- in one transaction can see different commits.
-- REPEATABLE READ uses a stable transaction snapshot; PostgreSQL prevents phantom
-- reads in the SQL-standard sense, but serialization anomalies can still occur.
-- SERIALIZABLE uses Serializable Snapshot Isolation and aborts transactions when it
-- detects a dangerous dependency pattern. Applications must retry SQLSTATE 40001.

-- 4. SYNTAX EXAMPLES (commented: choose isolation before the first query)
-- BEGIN ISOLATION LEVEL REPEATABLE READ;
-- SELECT ...;
-- COMMIT;
--
-- BEGIN ISOLATION LEVEL SERIALIZABLE;
-- UPDATE ...;
-- COMMIT;

-- 5. IMPORTANT RULES
-- PostgreSQL MVCC lets readers and writers generally proceed without blocking each
-- other, but row/table locks and conflicting writes still matter.
-- SERIALIZABLE does not mean “no errors”: serialization failures are expected control
-- flow and the complete transaction must be retried from the beginning.
-- A retry must not repeat non-transactional side effects such as sending an email.
-- Use SELECT ... FOR UPDATE when a row must be locked before a dependent decision;
-- use constraints for invariants such as uniqueness.

-- 6. COMMON MISTAKES
-- Assuming two statements in READ COMMITTED share one snapshot.
-- Retrying only the failed statement instead of the entire serializable transaction.
-- Assuming application validation is enough to enforce a concurrent invariant.

-- 7. INTERVIEW NOTES
-- ACID: atomicity (all-or-nothing), consistency (valid states/constraints), isolation
-- (concurrent behavior), durability (committed changes survive failures per configuration).
-- PostgreSQL defaults to READ COMMITTED; isolation guarantees should be stated precisely.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Observe two separate statements under READ COMMITTED in two sessions.
-- Level 2: Construct a write-skew example and compare REPEATABLE READ with SERIALIZABLE.
-- Level 3: Add a retry policy for serialization failures without duplicating side effects.
-- Level 4: Compare a unique constraint, SELECT FOR UPDATE, and SERIALIZABLE for a
--          “one active subscription per user” invariant.