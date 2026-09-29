-- ============================================
-- PARTITION BY: calculate windows independently by group
-- ============================================

-- 1. CONCEPT
-- PARTITION BY divides rows into independent windows while keeping every input row.
-- Unlike GROUP BY, it does not collapse each group into one output row.

-- 2. WHY IT IS USED
-- Per-group ranks, running totals, shares, and comparisons need group-level
-- calculations alongside row-level detail.

-- 3. BASIC EXAMPLE
SELECT id,
	   department_id,
	   salary,
	   AVG(salary) OVER (PARTITION BY department_id) AS department_average
FROM employees;

-- 4. PRACTICAL EXAMPLE
-- Running delivered spend by customer in chronological order.
SELECT orders.user_id,
	   orders.id AS order_id,
	   orders.ordered_at,
	   SUM(order_items.quantity * order_items.unit_price) AS order_total,
	   SUM(SUM(order_items.quantity * order_items.unit_price)) OVER (
		   PARTITION BY orders.user_id
		   ORDER BY orders.ordered_at, orders.id
		   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	   ) AS running_customer_total
FROM orders
JOIN order_items ON order_items.order_id = orders.id
WHERE orders.status = 'delivered'
GROUP BY orders.user_id, orders.id, orders.ordered_at
ORDER BY orders.user_id, orders.ordered_at, orders.id;

-- 5. IMPORTANT RULES
-- PARTITION BY sets group boundaries; window ORDER BY sets sequence within a group.
-- With ORDER BY, the default frame is peer-aware RANGE behavior. For row-by-row
-- running totals, specify a ROWS frame and a deterministic ordering key.
-- A window result cannot normally be filtered in WHERE at the same query level.

-- 6. COMMON MISTAKES
-- Confusing window PARTITION BY with GROUP BY, or forgetting that ties share the
-- default RANGE frame's current peer group.

-- 7. INTERVIEW NOTES
-- Explain window versus aggregate, partitions versus groups, and ROWS/RANGE frames.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Show each employee's salary as a percentage of department payroll.
-- Level 2: Add rank and department average to each employee row.
-- Level 3: Calculate a three-order moving average for every customer.
-- Level 4: Find each customer's largest order and its share of lifetime spend.
