-- ============================================
-- CREATE TABLE: define a relation and its columns
-- ============================================

-- 1. CONCEPT
-- A table stores rows with a fixed set of named columns and data types. Constraints
-- express invariants so invalid state is rejected close to where it is written.

-- 2. WHY IT IS USED
-- A deliberate schema makes relationships, valid values, and storage expectations
-- explicit for every application client.

-- 3. SYNTAX
-- CREATE TABLE schema_name.table_name (
--     column_name data_type [constraint],
--     table_constraint
-- );

-- 4. BASIC EXAMPLE
CREATE TABLE projects_demo (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	project_name TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	budget NUMERIC(12, 2) CHECK (budget >= 0)
);

-- 5. PRACTICAL EXAMPLE
-- The practice dataset's order_items table uses a composite key because an order
-- can contain many products but must not repeat a product line in this exercise model.
-- See 00-dataset/06-order-items.sql for the complete relationship and seed rows.

-- 6. IMPORTANT RULES
-- Choose NUMERIC for exact decimal quantities such as money; floating point is approximate.
-- TIMESTAMPTZ stores an instant normalized internally and renders in the session zone.
-- NOT NULL, CHECK, UNIQUE, PRIMARY KEY, and FOREIGN KEY constraints are different rules.
-- CREATE TABLE AS copies query results but does not automatically copy constraints.

-- 7. COMMON MISTAKES
-- Avoid storing a comma-separated list of products in one column; use related rows.
-- Avoid using reserved words or quoted mixed-case identifiers for table/column names.

-- 8. INTERVIEW NOTES
-- Be prepared to justify type/constraint choices and to identify candidate and
-- composite keys. A primary key is unique and not null.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Create a scratch table for support tickets with an identity primary key.
-- Level 2: Add a nonnegative priority and a default creation timestamp.
-- Level 3: Model a many-to-many student/course relationship with a composite key.
-- Level 4: Design a normalized schema for subscriptions and billing periods.
