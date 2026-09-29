-- ============================================
-- PRIMARY KEY: identify each row uniquely
-- ============================================

-- A primary key enforces uniqueness and NOT NULL on one column or a column set.
-- A table has one primary-key constraint; it may be composite. PostgreSQL creates
-- a unique B-tree index to enforce it.

-- Practice dataset examples: users.id, orders.id, and the composite key
-- order_items(order_id, product_id).

CREATE TABLE primary_key_demo (
	tenant_id BIGINT NOT NULL,
	external_id TEXT NOT NULL,
	payload JSONB NOT NULL DEFAULT '{}'::jsonb,
	PRIMARY KEY (tenant_id, external_id)
);

-- Identity columns generate values; SERIAL is older PostgreSQL shorthand involving
-- a sequence. Neither automatically makes an identifier globally meaningful.

-- Interview notes: distinguish natural and surrogate keys, composite keys, and
-- unique constraints. A primary key is the row identity, not necessarily every
-- candidate key in a table.

-- Practice tasks (no solutions): choose keys for order_items, a multi-tenant user
-- table, and an event table with an externally supplied idempotency key.
