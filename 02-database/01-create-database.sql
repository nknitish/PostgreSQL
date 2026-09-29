-- ============================================
-- CREATE DATABASE: create an isolated database
-- ============================================

-- 1. CONCEPT
-- A PostgreSQL database is a named collection of schemas and objects inside a
-- PostgreSQL cluster. A cluster can contain many databases; connections use one.

-- 2. WHY IT IS USED
-- Separate databases isolate environments or applications and simplify ownership,
-- backup, and access control. A schema is often better for organizing one app's objects.

-- 3. SYNTAX
-- CREATE DATABASE database_name
--     WITH OWNER = role_name
--          ENCODING = 'UTF8'
--          TEMPLATE = template0;

-- 4. BASIC EXAMPLE
-- Run as a role allowed to create databases. This is SQL, not a psql meta-command.
CREATE DATABASE sql_interview
	WITH ENCODING = 'UTF8'
		 TEMPLATE = template0;

-- 5. CONNECT
-- psql meta-command, entered in psql (not sent to PostgreSQL as SQL):
-- \c sql_interview
-- In a terminal, connect with: psql -d sql_interview

-- 6. IMPORTANT RULES
-- CREATE DATABASE cannot run inside a transaction block.
-- Database names are cluster-level, so connect to an existing maintenance database
-- such as postgres when creating another database.
-- TEMPLATE = template0 provides a clean template and avoids locale add-ons from template1.

-- 7. COMMON MISTAKES
-- Do not put \c in a SQL migration executed by an application; it is psql-specific.
-- Do not create a database on every application startup.

-- 8. INTERVIEW NOTES
-- Distinguish cluster, database, schema, table, and role. PostgreSQL connections
-- cannot query ordinary tables across databases without an extension or FDW.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Create a local practice database with UTF8 encoding.
-- Level 2: Connect to it using both psql and a GUI client.
-- Level 3: Explain when a schema is preferable to a separate database.
