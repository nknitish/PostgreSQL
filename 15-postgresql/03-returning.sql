-- ============================================
-- RETURNING: PostgreSQL DML result rows
-- ============================================

-- PostgreSQL allows INSERT, UPDATE, and DELETE to return affected row values.
-- This is especially useful for generated keys and optimistic conditional updates.

BEGIN;

INSERT INTO products (product_name, category, list_price)
VALUES ('Returning Example', 'Office', 12.00)
RETURNING id, product_name, is_active;

UPDATE products
SET list_price = list_price + 1
WHERE product_name = 'Returning Example'
RETURNING id, list_price;

DELETE FROM products
WHERE product_name = 'Returning Example'
RETURNING id, product_name;

ROLLBACK;

-- RETURNING is PostgreSQL syntax. It returns only affected rows and does not commit.
-- Combine with a predicate such as `WHERE id = $1 AND version = $2` to implement
-- optimistic concurrency; zero returned rows means no row matched that version.

-- Practice tasks (no solutions): return generated order id; perform compare-and-swap
-- update with a version field; return deleted rows for an audit event in one transaction.
