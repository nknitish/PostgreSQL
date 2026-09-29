-- ============================================
-- ALTER TABLE: evolve an existing table
-- ============================================

-- 1. CONCEPT
-- ALTER TABLE changes a table's structure or constraints without replacing the table.

-- 2. WHY IT IS USED
-- Production schemas evolve as requirements change; migrations make those changes
-- repeatable and reviewable.

-- 3. SYNTAX AND EXAMPLES
-- Add a nullable column (typically the least disruptive first step):
ALTER TABLE users
ADD COLUMN phone_number TEXT;

-- Set a default for future rows. Existing rows are not conceptually backfilled
-- with business-specific values merely because a default is chosen.
ALTER TABLE users
ALTER COLUMN phone_number SET DEFAULT 'unknown';

-- Rename, change a type, or remove a default:
-- ALTER TABLE users RENAME COLUMN phone_number TO contact_phone;
-- ALTER TABLE users ALTER COLUMN age TYPE SMALLINT;
-- ALTER TABLE users ALTER COLUMN contact_phone DROP DEFAULT;

-- 4. IMPORTANT RULES
-- Many ALTER operations acquire locks; exact behavior and rewrite cost depend on
-- PostgreSQL version, operation, table size, and defaults.
-- A type change may fail if existing values cannot be converted. Use USING for an
-- explicit conversion expression when needed.
-- Separate expand/backfill/contract migrations can reduce deployment risk.

-- 5. COMMON MISTAKES
-- Do not drop a column before checking application readers, writers, views, and jobs.
-- Adding NOT NULL to populated data requires a valid value for every existing row.

-- 6. INTERVIEW NOTES
-- Discuss backward-compatible migrations, locks, backfills, and deployment order.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Add a nullable preferred_language column to users.
-- Level 2: Backfill existing rows before enforcing NOT NULL.
-- Level 3: Plan a rename that keeps old and new application versions working during rollout.
