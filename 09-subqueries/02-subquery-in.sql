-- ============================================
-- IN SUBQUERY: compare against a query result set
-- ============================================

-- IN tests whether the left expression equals any value returned by the subquery.
-- The subquery must return one column but can return many rows.

-- Customers with at least one delivered order:
SELECT users.id, users.name
FROM users
WHERE users.id IN (
	SELECT orders.user_id
	FROM orders
	WHERE orders.status = 'delivered'
)
ORDER BY users.id;

-- NOT IN can be unsafe if the subquery yields NULL. A NULL in the candidate set
-- can turn nonmatches into UNKNOWN. Prefer NOT EXISTS for anti-join logic.
-- For this schema orders.user_id is NOT NULL, but verify this property in other schemas.

-- IN ignores duplicate candidate values for truth testing; it does not multiply
-- outer rows the way a join can.

-- Interview notes: compare IN with JOIN and EXISTS, paying attention to output
-- duplication and NULL semantics. PostgreSQL can decorrelate many such forms.

-- Practice tasks (no solutions):
-- Level 1: Find products that appear in at least one order line.
-- Level 2: Find users with an order in a selected status set.
-- Level 3: Find departments containing an employee above the company average.
-- Challenge: Produce a correct anti-membership query even if the subquery key is nullable.
