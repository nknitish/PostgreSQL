-- ============================================
-- COMPOSITE INDEX: index multiple columns in key order
-- ============================================

-- A multicolumn B-tree index is ordered by its first key, then second, and so on.
-- Key order should match common predicates/orderings, not just a list of columns.

CREATE INDEX orders_user_status_date_idx
	ON orders (user_id, status, ordered_at DESC);

-- This can suit queries constraining user_id and status, then reading newest first.
-- It is not equivalent to (status, user_id, ordered_at): leading-key use differs.

-- PostgreSQL B-tree skip scan may help some predicates omitting a leading key when
-- distinct leading values are few; do not rely on it instead of workload measurement.

-- INCLUDE adds non-key payload columns for possible index-only scans, but does not
-- change search ordering:
-- CREATE INDEX orders_user_date_covering_idx
--     ON orders (user_id, ordered_at DESC) INCLUDE (status);

-- Interview focus: leftmost prefix behavior, equality before range/order keys,
-- selectivity, covering indexes, and the cost of redundant indexes.
-- Practice tasks: index employee lookup by department and salary; design a stable
-- order-history page index; justify column order with actual query predicates.
