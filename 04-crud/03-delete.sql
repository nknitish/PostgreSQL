-- ============================================
-- DELETE: remove selected rows
-- ============================================

-- 1. CONCEPT
-- DELETE removes rows that satisfy its WHERE condition. It preserves the table.

-- 2. WHY IT IS USED
-- It supports retention policies and explicit removal of entities or dependent data.

-- 3. SYNTAX
-- DELETE FROM table_name
-- WHERE condition;

-- 4. BASIC EXAMPLE
-- Keep the demonstration reversible and inspect deleted rows with RETURNING.
BEGIN;

DELETE FROM users
WHERE email = 'demo.customer@example.com'
RETURNING id, name, email;

ROLLBACK;

-- 5. PRACTICAL EXAMPLE
-- A child row may be removed only when referential actions allow it.
-- In this model, deleting an order with order_items still referencing it is rejected.
-- Prefer an explicit business policy (archive, cancel, or delete children) over CASCADE.

-- 6. IMPORTANT RULES
-- Without WHERE, every row is deleted. DELETE is transactional in PostgreSQL.
-- Foreign keys can block deletion or trigger configured ON DELETE actions.
-- DELETE fires row-level DELETE triggers; TRUNCATE does not fire those row triggers.

-- 7. COMMON MISTAKES
-- Do not use DELETE when you mean to cancel an order; preserve the audit event.
-- A DELETE ... USING join must still identify exactly which target rows to remove.

-- 8. INTERVIEW NOTES
-- Explain soft delete versus hard delete, FK actions, transaction rollback, and
-- how RETURNING helps verify precisely what was removed.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Delete a specific scratch user by its unique email.
-- Level 2: Find and remove duplicate staging rows while retaining one chosen row.
-- Level 3: Delete expired sessions in bounded batches without locking the whole table too long.
-- Level 4: Design account deletion that honors order history and privacy requirements.
