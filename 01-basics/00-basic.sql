-- ============================================
-- SQL BASICS: talking to PostgreSQL
-- ============================================

-- 1. CONCEPT
-- SQL is the declarative language used to define, query, and change relational
-- data. You describe the result or change you want; PostgreSQL plans the work.
-- psql is PostgreSQL's terminal client. Its backslash commands are client-side
-- meta-commands, not SQL, and are not sent to the database as SQL statements.

-- 2. WHY IT IS USED
-- Backend engineers use SQL to persist application state, enforce data rules,
-- investigate production behavior, and answer questions across related tables.

-- 3. PSQL META-COMMANDS (run inside psql; do not add a semicolon)
-- \l                 list databases visible to this role
-- \c sql_interview   connect to the sql_interview database
-- \dt                list tables in the current search path
-- \dt public.*       list tables in the public schema
-- \d users           describe a table, including columns and indexes
-- \dn                list schemas
-- \du                list roles
-- These are not portable SQL and will fail in most SQL query editors.

-- 4. SQL ALTERNATIVES
-- List databases (requires suitable catalog visibility):
SELECT datname
FROM pg_database
WHERE datistemplate = FALSE
ORDER BY datname;

-- List ordinary tables in the current database's public schema:
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
	AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- PostgreSQL catalog alternative; pg_tables is a PostgreSQL system view:
SELECT schemaname,
			 tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- 5. IMPORTANT RULES
-- SQL statements normally end with a semicolon. psql meta-commands do not.
-- PostgreSQL folds unquoted identifiers to lower case; quote identifiers only
-- when necessary, because quoted mixed-case names must always be quoted.
-- SQL keywords are case-insensitive by convention, but uppercase improves scanability.

-- 6. COMMON MISTAKES
-- WRONG (MySQL syntax; PostgreSQL does not implement SHOW TABLES):
-- SHOW TABLES;
-- CORRECT: use \dt in psql, or query information_schema.tables as above.

-- 7. INTERVIEW NOTES
-- Be ready to distinguish SQL from client commands and from PostgreSQL system
-- catalogs. information_schema is standardized; pg_catalog exposes richer,
-- PostgreSQL-specific metadata.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: List all non-template databases and all public tables.
-- Level 2: Find the schemas in the current database that contain tables.
-- Level 3: Compare the information_schema and pg_catalog table listings.
-- Level 4: Find each public table's estimated row count using PostgreSQL catalogs;
--          explain why the result is an estimate rather than an exact count.

-- Existing editor workflow note (shortcuts depend on the installed SQL extension):
-- Run entire file: Shift + Enter
-- Run current line: Shift + Control + Enter
-- In psql, use \? for meta-command help and \h SELECT for SQL syntax help.
