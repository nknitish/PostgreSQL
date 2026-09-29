-- ============================================
-- ARRAYS: store ordered values of one element type
-- ============================================

-- PostgreSQL arrays can be useful for compact, bounded collections. They do not
-- replace a child table when elements need independent keys, constraints, or joins.

SELECT ARRAY['sql', 'postgresql', 'interview'] AS topics;

SELECT (ARRAY[10, 20, 30])[1] AS first_element;

-- Array subscripts normally start at 1. ANY checks a scalar against array members.
SELECT 'Bangalore' = ANY(ARRAY['Delhi', 'Bangalore']) AS city_is_in_array;

-- Array containment operators: @> contains, <@ is contained by, && overlaps.
SELECT ARRAY[1, 2, 3] @> ARRAY[2, 3] AS contains_values;

-- Practical scratch examples; array data is not added to users because cities and
-- product/order relationships belong in relational columns/tables for this dataset.
CREATE TEMP TABLE array_demo (
	id INTEGER PRIMARY KEY,
	labels TEXT[] NOT NULL DEFAULT '{}'
);

INSERT INTO array_demo (id, labels)
VALUES (1, ARRAY['backend', 'postgresql']), (2, ARRAY['frontend']);

SELECT id, labels
FROM array_demo
WHERE labels @> ARRAY['postgresql'];

-- GIN indexes can support array containment/overlap queries.
-- CREATE INDEX array_demo_labels_gin_idx ON array_demo USING GIN (labels);

-- Watch out for NULL arrays versus empty arrays and NULL elements within arrays.
-- Interview notes: arrays are PostgreSQL-specific; normalize when values need
-- referential integrity or independent lifecycle.
-- Practice tasks: query overlap; unnest labels; decide whether a tags array or
-- normalized tag/link tables fit a heavily queried multi-tenant product catalog.
