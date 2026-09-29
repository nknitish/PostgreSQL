-- ============================================
-- INSERT: add rows to a table
-- ============================================

-- 1. CONCEPT
-- INSERT creates one or more rows. Naming target columns makes the statement
-- resilient to column order changes and documents what the values represent.

-- 2. WHY IT IS USED
-- Applications use INSERT to persist newly created entities and events.

-- 3. SYNTAX
-- INSERT INTO table_name (column_a, column_b)
-- VALUES (value_a, value_b), ...;

-- 4. BASIC EXAMPLE
-- This transaction is rolled back so it is safe to run against the practice data.
BEGIN;

INSERT INTO users (name, email, age, city)
VALUES ('Demo Customer', 'demo.customer@example.com', 33, 'Chennai');

-- Omitted columns use their DEFAULT, or NULL if nullable with no default.
INSERT INTO users (name, email)
VALUES ('New Customer', 'new.customer@example.com');

ROLLBACK;

-- 5. PRACTICAL EXAMPLES
-- Insert multiple rows in one statement:
-- INSERT INTO products (product_name, category, list_price)
-- VALUES ('USB Hub', 'Accessories', 29.00), ('Notebook', 'Office', 8.50);
-- Insert rows derived from a query with INSERT INTO ... SELECT ... .

-- 6. IMPORTANT RULES
-- Values must match target column types and satisfy every constraint.
-- Identity/serial values are normally omitted so PostgreSQL generates them.
-- An INSERT statement is atomic: all its rows succeed or none do.

-- 7. COMMON MISTAKES
-- Avoid relying on physical column order: INSERT INTO users VALUES (...).
-- Do not omit a required NOT NULL value unless it has a default.

-- 8. INTERVIEW NOTES
-- Discuss constraints, generated keys, transaction boundaries, and handling
-- duplicate-key races. Application-side "check then insert" is not concurrency-safe.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Insert a user while allowing PostgreSQL to generate id and created_at.
-- Level 2: Insert two products in one statement.
-- Level 3: Insert one order and its line items atomically.
-- Level 4: Insert users from a staging query while rejecting invalid emails safely.
