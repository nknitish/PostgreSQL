-- ============================================
-- CHECK: constrain allowed values or relationships within a row
-- ============================================

-- A CHECK constraint rejects a row when its condition is FALSE. TRUE and NULL/UNKNOWN
-- pass; pair with NOT NULL if missing values are forbidden.

CREATE TABLE check_demo (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	quantity INTEGER NOT NULL CHECK (quantity > 0),
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	CHECK (end_date >= start_date)
);

-- Check constraints should describe deterministic row-local rules. Do not use a
-- CHECK to enforce conditions over other rows or tables; use UNIQUE/FK/exclusion
-- constraints or a suitable transaction-level design.

-- Example dataset rules: salary > 0, quantity > 0, and enumerated order statuses.

-- Common mistake: CHECK (value > 0) does not reject NULL by itself.
-- Interview focus: know what constraints are concurrency-safe and why an application
-- validation query cannot replace a database constraint.
-- Practice tasks: constrain percentages, date intervals, and valid status transitions.
