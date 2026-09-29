-- ============================================
-- BEGIN / COMMIT: group changes atomically
-- ============================================

-- 1. CONCEPT
-- A transaction groups statements into one unit. COMMIT makes its changes visible
-- and durable according to PostgreSQL durability configuration; ROLLBACK abandons them.

-- 2. WHY IT IS USED
-- Multi-step operations must not leave partial state, such as an order without lines.

-- 3. PRACTICAL EXAMPLE
BEGIN;

INSERT INTO orders (user_id, ordered_at, status)
VALUES (1, CURRENT_TIMESTAMP, 'pending')
RETURNING id;

-- Use the returned id to insert related order_items in the same transaction.
-- This teaching example rolls back, so it does not leave an order in the dataset.
ROLLBACK;

-- Replace ROLLBACK with COMMIT only after all statements and checks succeed.

-- 4. IMPORTANT RULES
-- PostgreSQL defaults to autocommit in many clients: each standalone statement commits.
-- BEGIN/COMMIT is also supported as START TRANSACTION / COMMIT.
-- A transaction sees a consistent snapshot according to its isolation level.
-- Keep transactions short; long transactions hold locks and can delay vacuum cleanup.

-- 5. COMMON MISTAKES
-- Catching an error and continuing without ROLLBACK TO SAVEPOINT/ROLLBACK leaves
-- the transaction in aborted state.
-- Do not make network calls or wait for user interaction while holding a transaction open.

-- 6. INTERVIEW NOTES
-- ACID: atomicity, consistency, isolation, durability. Discuss each in PostgreSQL terms.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Insert an order and its items atomically.
-- Level 2: Update account balances for a transfer with consistency checks.
-- Level 3: Demonstrate rollback after a constraint violation.
-- Level 4: Explain what concurrent transactions can observe at READ COMMITTED.
