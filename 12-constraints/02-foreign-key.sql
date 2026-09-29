-- ============================================
-- FOREIGN KEY: enforce a valid relationship
-- ============================================

-- A foreign key requires each non-NULL referencing value to match a referenced
-- primary/unique key. It can also define what happens when the parent is changed.

-- Example from the dataset: orders.user_id REFERENCES users(id), and order_items
-- references both orders and products.

CREATE TABLE foreign_key_demo_parent (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

CREATE TABLE foreign_key_demo_child (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	parent_id BIGINT NOT NULL,
	CONSTRAINT foreign_key_demo_child_parent_fk
		FOREIGN KEY (parent_id)
		REFERENCES foreign_key_demo_parent(id)
		ON DELETE RESTRICT
);

-- ON DELETE options include NO ACTION (default, checked at constraint timing),
-- RESTRICT, CASCADE, SET NULL, and SET DEFAULT. Pick according to domain semantics.

-- PostgreSQL does not automatically index the referencing columns. Add an index
-- when joins, parent deletes, or updates need efficient child lookup.

-- Common mistake: CASCADE can remove a large dependent graph unexpectedly.
-- Interview notes: explain referential integrity and why a FK alone does not imply
-- the child column is NOT NULL.

-- Practice tasks (no solutions): model optional employee manager references;
-- choose deletion behavior for product history; add an appropriate child-side index.
