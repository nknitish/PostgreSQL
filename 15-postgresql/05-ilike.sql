-- ============================================
-- ILIKE: PostgreSQL case-insensitive pattern matching
-- ============================================

-- ILIKE behaves like LIKE but compares case-insensitively according to the active
-- locale/collation. It is a PostgreSQL extension rather than standard SQL syntax.

SELECT id, name
FROM users
WHERE name ILIKE 'r%';

SELECT id, email
FROM users
WHERE email ILIKE '%@EXAMPLE.COM';

-- A leading wildcard is generally not accelerated by a regular B-tree index.
-- For high-volume substring search, evaluate pg_trgm and a GIN/GiST trigram index.
-- For case-insensitive equality, consider a unique expression index on lower(email)
-- or citext after evaluating collation and normalization requirements.

-- ILIKE does not remove accents or perform full Unicode normalization.
-- Interview notes: distinguish ILIKE from lower(column) LIKE lower(pattern), and
-- explain why production search requirements need an explicit collation/index strategy.
-- Practice tasks (no solutions): case-insensitive prefix, suffix, and substring search;
-- escape literal % and _; compare EXPLAIN plans for indexed and unindexed search.
