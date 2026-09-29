-- ============================================
-- DROP DATABASE: remove a database permanently
-- ============================================

-- 1. CONCEPT
-- DROP DATABASE deletes the database and all objects and data inside it.

-- 2. WHY IT IS USED
-- It is appropriate for disposable local/test databases and controlled teardown,
-- never as a routine application data-cleanup mechanism.

-- 3. SYNTAX
-- DROP DATABASE [IF EXISTS] database_name;

-- 4. EXAMPLE (INTENTIONALLY COMMENTED OUT)
-- Uncomment only after confirming that the target is disposable and backed up.
-- DROP DATABASE IF EXISTS sql_interview;

-- 5. IMPORTANT RULES
-- You cannot drop the database to which your session is currently connected.
-- Connect to another database first. PostgreSQL 16 supports WITH (FORCE) to
-- terminate other connections when possible, but it does not make deletion reversible.
-- DROP DATABASE cannot run inside a transaction block.

-- 6. COMMON MISTAKES
-- IF EXISTS avoids an error when absent; it does not protect existing data.
-- Do not confuse DROP DATABASE with DROP SCHEMA or DELETE FROM table.

-- 7. INTERVIEW NOTES
-- Explain scope and reversibility: DROP DATABASE is DDL and cannot be rolled back
-- like ordinary transactional table changes in PostgreSQL.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Determine which database your current session uses.
-- Level 2: Write a guarded command to remove a disposable database from another connection.
-- Level 3: Describe a safer test-database teardown workflow including connection checks.
