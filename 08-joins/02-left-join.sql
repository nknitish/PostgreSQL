-- ============================================
-- LEFT JOIN: preserve every row from the left side
-- ============================================

-- 1. CONCEPT
-- LEFT JOIN returns all left rows and matching right rows. Where there is no match,
-- right-side columns are filled with NULL. One-to-many matches still multiply rows.

-- 2. WHY IT IS USED
-- It answers questions about all entities, including entities with no related activity.

-- 3. BASIC EXAMPLE
SELECT users.id,
	   users.name,
	   orders.id AS order_id
FROM users
LEFT JOIN orders ON orders.user_id = users.id
ORDER BY users.id, orders.id;

-- 4. PRACTICAL EXAMPLE
-- Count child keys, not *, to get zero for users with no orders.
SELECT users.id,
	   users.name,
	   COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders ON orders.user_id = users.id
GROUP BY users.id, users.name
ORDER BY users.id;

-- 5. ON VS WHERE: a common interview distinction
-- Keep all users, attaching only delivered orders:
SELECT users.id,
	   users.name,
	   orders.id AS delivered_order_id
FROM users
LEFT JOIN orders
	ON orders.user_id = users.id
   AND orders.status = 'delivered';

-- This WHERE filter removes NULL-extended rows and behaves like an inner join
-- for the delivered condition:
-- SELECT ... FROM users LEFT JOIN orders ON orders.user_id = users.id
-- WHERE orders.status = 'delivered';

-- 6. IMPORTANT RULES
-- Conditions defining which right rows match usually belong in ON when preserving
-- left rows is required. WHERE filters after the join.
-- COUNT(*) counts one NULL-extended row for a left entity with zero matches.

-- 7. INTERVIEW NOTES
-- Predict whether unmatched rows survive each predicate. Carefully distinguish
-- filters on the preserved side from filters on the nullable side.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: List every user and any order id, including users with none.
-- Level 2: Count only delivered orders per user while retaining users with zero.
-- Level 3: List departments with employee counts, including empty departments.
-- Level 4: Find users who have never placed a non-cancelled order using an anti-join.
