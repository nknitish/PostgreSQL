-- ============================================
-- DROP TABLE: remove a table definition and its data
-- ============================================

-- DROP TABLE removes the table object. It is different from DELETE (remove rows)
-- and TRUNCATE (remove all rows while keeping the table).

-- Safe form for an optional scratch object:
-- DROP TABLE IF EXISTS projects_demo;

-- RESTRICT is the default: fail if dependent objects exist.
-- CASCADE also removes dependent objects and can have a much wider effect.
-- DROP TABLE projects_demo CASCADE;

-- This lesson intentionally does not execute a destructive command. Inspect the
-- target and dependencies first; backups and migrations matter for shared databases.

-- Interview notes: PostgreSQL DDL is generally transactional, unlike DROP DATABASE.
-- Practice tasks (no solutions): distinguish DROP TABLE, DELETE, and TRUNCATE;
-- explain when RESTRICT is safer than CASCADE; identify dependencies before a drop.
