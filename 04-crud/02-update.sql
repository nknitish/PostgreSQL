-- ============================================
-- UPDATE: change existing rows
-- ============================================

-- 1. CONCEPT
-- UPDATE modifies columns on every row matched by its WHERE condition.

-- 2. WHY IT IS USED
-- It records changes to existing entities, such as profile edits or order status
-- transitions.

-- 3. SYNTAX
-- UPDATE table_name
-- SET column_a = expression, ...
-- WHERE condition;

-- 4. BASIC EXAMPLE
-- Use RETURNING to inspect affected rows. ROLLBACK leaves the seed data unchanged.
BEGIN;

UPDATE users
SET city = 'Bangalore',
		is_active = TRUE
WHERE id = 10
RETURNING id, name, city, is_active;

ROLLBACK;

-- 5. PRACTICAL EXAMPLE
-- Derive values from the old row; the right-hand expressions use its old values.
BEGIN;

UPDATE order_items
SET quantity = quantity + 1
WHERE order_id = 1
	AND product_id = 1
RETURNING order_id, product_id, quantity;

ROLLBACK;

-- 6. IMPORTANT RULES
-- Omitting WHERE updates every row. In PostgreSQL, UPDATE is atomic per statement.
-- Use a transaction for a multi-statement business operation.
-- A row count of zero means no row matched; it is not necessarily a SQL error.

-- 7. COMMON MISTAKES
-- Before a high-impact update, run the matching SELECT with the same WHERE clause.
-- Avoid using nullable comparisons without deciding what NULL should mean.

-- 8. INTERVIEW NOTES
-- Know how UPDATE ... FROM works in PostgreSQL and avoid ambiguous multiple source
-- matches, which can make the chosen update value unpredictable.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Change one user's city by id and return the changed row.
-- Level 2: Deactivate users who have not placed an order (identify carefully).
-- Level 3: Increase each order line's quantity only for pending orders.
-- Level 4: Apply an inventory decrement and order insert atomically with concurrency control.
