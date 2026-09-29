-- ============================================
-- NOT NULL: require a value for a column
-- ============================================

-- NOT NULL means a row cannot omit this value. It does not require non-empty text,
-- a positive number, or a valid relationship; use CHECK/FK constraints for those.

CREATE TABLE not_null_demo (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	display_name TEXT NOT NULL,
	age INTEGER CHECK (age IS NULL OR age >= 0)
);

-- NOT NULL and CHECK are separate. CHECK (age >= 0) alone accepts NULL because
-- the check expression is UNKNOWN, not FALSE.

-- For an existing large table, a staged migration may add a validated check first,
-- backfill, then enforce NOT NULL with reduced validation work (verify version/plan).

-- Interview focus: distinguish NULL from empty text/zero and explain safe rollout
-- when existing rows do not yet satisfy the invariant.
-- Practice tasks: make a legacy required field non-null without a long blocking backfill;
-- define whether a blank string should count as missing.
