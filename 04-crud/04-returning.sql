-- ============================================
-- RETURNING: inspect rows changed by a statement
-- ============================================

-- 1. CONCEPT
-- PostgreSQL's RETURNING clause emits values from rows inserted, updated, or deleted.

-- 2. WHY IT IS USED
-- It can return generated identifiers and changed values in one round trip, avoiding
-- a follow-up SELECT that might observe a later concurrent change.

-- 3. SYNTAX
-- INSERT ... RETURNING column, ...;
-- UPDATE ... RETURNING column, ...;
-- DELETE ... RETURNING column, ...;

-- 4. BASIC EXAMPLE
BEGIN;

INSERT INTO users (name, email, age, city)
VALUES ('Returning Demo', 'returning.demo@example.com', 29, 'Pune')
RETURNING id, name, created_at;

ROLLBACK;

-- 5. PRACTICAL EXAMPLE
BEGIN;

UPDATE orders
SET status = 'processing'
WHERE id = 11
	AND status = 'pending'
RETURNING id, user_id, status;

ROLLBACK;

-- 6. IMPORTANT RULES
-- RETURNING emits one result row for each affected row; zero affected rows means
-- zero returned rows. It is PostgreSQL syntax supported for DML statements.
-- RETURNING does not commit the transaction.

-- 7. COMMON MISTAKES
-- Treating a returned row as proof that a multi-statement transaction committed.
-- Forgetting to check the number of rows returned when an update should be conditional.

-- 8. INTERVIEW NOTES
-- Describe how INSERT ... RETURNING id replaces a separate generated-key lookup.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Insert a scratch product and return its generated id.
-- Level 2: Update one order only if it is pending and return whether it changed.
-- Level 3: Delete a scratch row and return an audit payload for the caller.
