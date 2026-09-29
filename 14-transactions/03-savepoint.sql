-- ============================================
-- SAVEPOINT: roll back part of a transaction
-- ============================================

-- A savepoint marks a position inside the current transaction. ROLLBACK TO
-- SAVEPOINT undoes later work while keeping the transaction open.

BEGIN;

UPDATE users
SET city = 'Temporary City'
WHERE id = 2;

SAVEPOINT before_optional_change;

UPDATE users
SET age = -1
WHERE id = 2;

-- Undo only the work after the savepoint, then finish by rolling back the demo.
ROLLBACK TO SAVEPOINT before_optional_change;
RELEASE SAVEPOINT before_optional_change;
ROLLBACK;

-- A real age CHECK constraint would reject the invalid update before savepoint rollback.
-- Savepoints are not a substitute for validation or short transactions.

-- Interview focus: nested business operations, error recovery, and transaction-aborted
-- state. PostgreSQL does not implement independently committed nested transactions.
-- Practice tasks (no solutions): selectively undo one optional step; design recovery
-- around a batch where a few rows can fail while the rest should proceed.
