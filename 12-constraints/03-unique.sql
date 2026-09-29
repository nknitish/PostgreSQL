-- ============================================
-- UNIQUE: reject duplicate key values
-- ============================================

-- UNIQUE creates a unique B-tree index and rejects conflicting non-NULL key values.
-- By default, PostgreSQL treats NULLs as distinct, so multiple NULLs are allowed.

CREATE TABLE unique_demo (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	tenant_id BIGINT NOT NULL,
	email TEXT,
	CONSTRAINT unique_demo_tenant_email UNIQUE (tenant_id, email)
);

-- PostgreSQL 15+: opt into treating NULLs as equal for uniqueness.
CREATE TABLE unique_nulls_not_distinct_demo (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	external_code TEXT UNIQUE NULLS NOT DISTINCT
);

-- Partial unique indexes express conditional uniqueness, e.g. one active row per key:
-- CREATE UNIQUE INDEX one_active_subscription_per_user
--     ON subscriptions (user_id)
--     WHERE ended_at IS NULL;

-- Common mistake: assuming UNIQUE(email) makes email comparison case-insensitive.
-- Use a carefully chosen lower(email) unique index or citext with understood semantics.

-- Interview focus: NULL behavior, composite uniqueness, partial uniqueness, and
-- handling duplicate-write races with constraints rather than check-then-insert.
-- Practice tasks: enforce one active subscription per user; enforce tenant-local
-- username uniqueness; decide how NULL email values should behave.
