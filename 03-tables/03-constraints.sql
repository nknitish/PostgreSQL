-- ============================================
-- TABLE CONSTRAINTS: enforce valid relational data
-- ============================================

-- A constraint is checked by PostgreSQL for every relevant write. Constraints
-- protect data even when writes come from different application services.

CREATE TABLE inventory_demo (
	warehouse_code TEXT NOT NULL,
	product_code TEXT NOT NULL,
	quantity INTEGER NOT NULL CHECK (quantity >= 0),
	updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (warehouse_code, product_code)
);

-- Example relationship constraint (assumes products(id) exists):
-- ALTER TABLE inventory_demo
-- ADD COLUMN product_id INTEGER REFERENCES products(id);

-- PRIMARY KEY: unique and not null; one per table, can span multiple columns.
-- UNIQUE: prevents duplicate key values; PostgreSQL normally allows multiple NULLs.
-- NOT NULL: rejects missing values.
-- CHECK: accepts TRUE or NULL, so combine with NOT NULL when NULL is invalid.
-- FOREIGN KEY: ensures a referenced parent key exists (or follows its delete action).

-- Common mistake: CHECK (quantity > 0) alone permits NULL. Use NOT NULL too.
-- Common mistake: a foreign key does not automatically create an index on its
-- referencing columns; add one if child-side lookups/deletes need it.

-- Interview focus: distinguish entity integrity (primary key), domain rules
-- (CHECK/NOT NULL), uniqueness, and referential integrity (foreign key).

-- Practice tasks (no solutions):
-- Level 1: Add a unique constraint to a user's email in a scratch table.
-- Level 2: Design a composite primary key for order line items.
-- Level 3: Choose ON DELETE behavior for an order and its line items; justify it.
-- Challenge: Explain why constraints should not be replaced only by application checks.
