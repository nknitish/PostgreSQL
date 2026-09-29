-- ============================================
-- DATABASE BASICS: psql commands and catalogs
-- ============================================

-- 1. CONCEPT
-- A PostgreSQL cluster hosts databases; each database contains schemas, which
-- contain tables and other objects. A role is a cluster-level identity.
-- psql is a terminal client. Its backslash meta-commands are not SQL statements.

-- 2. PSQL META-COMMANDS (run inside psql; no semicolon)
-- \l                 list databases
-- \c sql_interview   connect to database
-- \dt                list tables in the current search path
-- \dt public.*       list tables in public
-- \d users           describe table columns, indexes, and constraints
-- \dn                list schemas
-- \du                list roles
-- \conninfo          show current connection information
-- \?                 help for psql commands
-- \h SELECT          SQL command help

-- 3. SQL ALTERNATIVES
-- Databases in the cluster (visibility depends on privileges):
SELECT datname
FROM pg_catalog.pg_database
WHERE datistemplate IS FALSE
ORDER BY datname;

-- Tables in this connected database:
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
  AND table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY table_schema, table_name;

-- PostgreSQL-specific catalog view equivalent for ordinary tables:
SELECT schemaname, tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- Schemas (SQL-visible catalog view):
SELECT schema_name
FROM information_schema.schemata
ORDER BY schema_name;

-- Roles are cluster-wide; pg_roles is a PostgreSQL system view:
SELECT rolname, rolsuper, rolcreatedb, rolcanlogin
FROM pg_catalog.pg_roles
ORDER BY rolname;

-- 4. IMPORTANT RULES
-- pg_database is cluster-wide metadata, but normal table data is database-local.
-- information_schema is standardized and privilege-filtered; pg_catalog is
-- PostgreSQL-specific and often exposes additional details.
-- In SQL clients, execute SQL queries above. A line such as \dt is interpreted only
-- by psql (or a client that explicitly implements psql meta-commands).

-- 5. COMMON MISTAKES
-- WRONG in PostgreSQL: SHOW TABLES;
-- CORRECT in psql: \dt
-- CORRECT in an SQL editor: query information_schema.tables.
-- Do not mistake a schema for a database.

-- 6. INTERVIEW NOTES
-- Clearly distinguish psql client commands, SQL language, standard metadata views,
-- and PostgreSQL catalogs. Remember that PostgreSQL connections select one database.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: List public tables and inspect the users table in both psql and SQL.
-- Level 2: Find which schemas contain tables in the current database.
-- Level 3: Compare information_schema.tables with pg_catalog.pg_tables.
-- Level 4: Find estimated row counts for all public tables and explain limitations.