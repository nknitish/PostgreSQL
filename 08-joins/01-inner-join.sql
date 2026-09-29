-- ============================================
-- INNER JOIN: keep rows with matching keys
-- ============================================

-- 1. CONCEPT
-- An inner join combines rows from two sources only when the ON condition is TRUE.
-- One left row can produce multiple output rows if multiple right rows match.

-- 2. WHY IT IS USED
-- Normalized data stores related facts in separate tables; joins reconstruct a useful view.

-- 3. SYNTAX
-- SELECT ...
-- FROM left_table AS l
-- JOIN right_table AS r ON r.key = l.foreign_key;

-- 4. BASIC EXAMPLE
SELECT orders.id AS order_id,
	   users.name AS customer_name,
	   orders.ordered_at,
	   orders.status
FROM orders
INNER JOIN users ON users.id = orders.user_id
ORDER BY orders.id;

-- 5. PRACTICAL EXAMPLE
-- Order revenue requires joining line items; each line is a separate output row.
SELECT orders.id AS order_id,
	   products.product_name,
	   order_items.quantity,
	   order_items.unit_price,
	   order_items.quantity * order_items.unit_price AS line_total
FROM orders
JOIN order_items ON order_items.order_id = orders.id
JOIN products ON products.id = order_items.product_id
ORDER BY orders.id, products.id;

-- 6. IMPORTANT RULES
-- Qualify ambiguous columns with table/alias names. Explicit ON documents the relationship.
-- Duplicate key values on either side cause many-to-many combinations.
-- ON defines match logic; WHERE filters the joined result.

-- 7. COMMON MISTAKES
-- Joining unrelated keys because their values happen to look similar.
-- Aggregating after a fan-out join without checking the intended grain.

-- 8. INTERVIEW NOTES
-- State the join key, expected cardinality, and output grain before writing the query.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Show each order with its customer's name.
-- Level 2: Show each order line with product name and calculated line amount.
-- Level 3: Find customers and products involved in delivered orders only.
-- Level 4: Calculate customer revenue without counting the same order more than once.
