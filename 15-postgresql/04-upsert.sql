-- ============================================
-- ON CONFLICT: handle uniqueness conflicts atomically
-- ============================================

-- 1. CONCEPT
-- INSERT ... ON CONFLICT implements an atomic insert-or-update (or do-nothing)
-- against a unique/exclusion constraint or index.

-- 2. WHY IT IS USED
-- It safely handles concurrent attempts to create the same logical key without
-- a race-prone application-side check-then-insert.

-- 3. PRACTICAL EXAMPLE
-- Use a temporary table so the demo never edits shared dataset rows.
CREATE TEMP TABLE user_preferences_demo (
	user_id INTEGER PRIMARY KEY,
	preference JSONB NOT NULL
);

INSERT INTO user_preferences_demo (user_id, preference)
VALUES (1, '{"theme":"dark"}'::jsonb)
ON CONFLICT (user_id)
DO UPDATE SET preference = EXCLUDED.preference
RETURNING user_id, preference;

-- EXCLUDED refers to the proposed insert row. An optional WHERE can limit updates.
INSERT INTO user_preferences_demo (user_id, preference)
VALUES (1, '{"theme":"light"}'::jsonb)
ON CONFLICT (user_id)
DO UPDATE SET preference = EXCLUDED.preference
WHERE user_preferences_demo.preference IS DISTINCT FROM EXCLUDED.preference
RETURNING user_id, preference;

-- 4. IMPORTANT RULES
-- A conflict target must correspond to an inferable unique/exclusion rule.
-- ON CONFLICT handles uniqueness conflicts, not arbitrary CHECK/FK errors.
-- Concurrent upserts serialize around the conflicting row; keep update expressions
-- idempotent and define whether overwriting is semantically correct.

-- 5. COMMON MISTAKES
-- Assuming upsert merges JSON automatically; EXCLUDED replaces unless explicitly combined.
-- Using DO NOTHING and then assuming the insert occurred.

-- 6. INTERVIEW NOTES
-- Compare upsert with MERGE and application-side retries. Explain unique-index-backed
-- arbitration and the EXCLUDED pseudo-row.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Upsert a key/value preference by primary key.
-- Level 2: Increment a counter atomically on conflict.
-- Level 3: Avoid rewriting a row when incoming data is unchanged.
-- Level 4: Design idempotent event ingestion with a dedupe key and observable outcomes.
