-- ============================================
-- AVG: calculate an arithmetic mean
-- ============================================

-- 1. CONCEPT
-- AVG computes SUM(non-NULL values) / COUNT(non-NULL values). NULL values are ignored.

-- 2. WHY IT IS USED
-- Averages summarize salary, prices, quantities, response time, and other measures.

-- 3. BASIC EXAMPLE
SELECT AVG(age) AS average_known_age
FROM users;

-- PostgreSQL returns a numeric result for integer inputs; output scale can be formatted.
SELECT ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- 4. PRACTICAL EXAMPLE
-- Average order value: sum lines to order grain before averaging orders.
WITH order_totals AS (
	SELECT orders.id,
		   SUM(order_items.quantity * order_items.unit_price) AS order_total
	FROM orders
	JOIN order_items ON order_items.order_id = orders.id
	WHERE orders.status = 'delivered'
	GROUP BY orders.id
)
SELECT AVG(order_total) AS average_delivered_order_value
FROM order_totals;

-- 5. IMPORTANT RULES
-- AVG ignores NULL inputs; an absent value is not treated as zero.
-- Average of row-level values differs from average of group-level totals.
-- Weighted averages require SUM(value * weight) / SUM(weight), with zero/null handling.

-- 6. COMMON MISTAKES
-- Averaging line-item prices gives each line equal weight, not each order.
-- Integer division outside AVG can truncate; cast intentionally for ratios.

-- 7. INTERVIEW NOTES
-- Ask what the unit of analysis is before calculating an average. Explain weighted versus
-- unweighted average and how NULL differs from zero.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find average known user age.
-- Level 2: Find average salary by department.
-- Level 3: Find average delivered order value per customer, then rank customers.
-- Level 4: Compare average order value with average line value for multi-line orders.
