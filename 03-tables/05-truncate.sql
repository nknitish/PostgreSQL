-- ============================================
-- TRUNCATE: quickly remove all rows from a table
-- ============================================

-- 1. CONCEPT
-- TRUNCATE removes every row but keeps the table structure, indexes, and constraints.

-- 2. WHY IT IS USED
-- It is useful for resetting disposable staging or test data efficiently.

-- 3. SYNTAX
-- TRUNCATE TABLE table_name [RESTART IDENTITY] [CASCADE];

-- 4. EXAMPLE (commented out to protect the practice data)
-- TRUNCATE TABLE projects_demo RESTART IDENTITY;

-- 5. IMPORTANT RULES
-- PostgreSQL TRUNCATE is transactional and takes a strong table lock.
-- RESTART IDENTITY resets owned sequences; CONTINUE IDENTITY is the default.
-- Referenced tables prevent truncation unless CASCADE is specified. CASCADE can
-- truncate additional tables, so enumerate effects before using it.
-- TRUNCATE does not fire row-level DELETE triggers, though statement-level
-- TRUNCATE triggers can run.

-- 6. COMMON MISTAKES
-- TRUNCATE has no WHERE clause. Use DELETE for selective removal.
-- Do not assume TRUNCATE is always faster overall; locks and foreign keys matter.

-- 7. INTERVIEW NOTES
-- Compare TRUNCATE with DELETE for logging, triggers, identity behavior, locking,
-- and transactional behavior in PostgreSQL.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Empty a scratch table while preserving its sequence.
-- Level 2: Reset a table and its owned identity sequence.
-- Level 3: Explain what happens when another table references the target.
