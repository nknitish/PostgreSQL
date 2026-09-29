-- ============================================
-- ROLLBACK: abandon uncommitted changes
-- ============================================

-- ROLLBACK ends the current transaction and discards its uncommitted database changes.

BEGIN;

UPDATE users
SET is_active = FALSE
WHERE id = 1;

-- Inspect within the transaction if desired, then undo the update:
SELECT id, is_active
FROM users
WHERE id = 1;

ROLLBACK;

-- The update is no longer visible after rollback. Sequence values obtained from
-- nextval are not rolled back, so gaps in generated ids are normal.

-- PostgreSQL marks a transaction failed after many statement errors. Use ROLLBACK
-- (or ROLLBACK TO SAVEPOINT) before issuing more normal statements.

-- Interview notes: rollback database state does not reverse external side effects
-- such as emails or HTTP calls; coordinate those with an outbox/saga design.
-- Practice tasks (no solutions): cause a constraint failure and recover; compare
-- transaction rollback with compensating actions in distributed workflows.
