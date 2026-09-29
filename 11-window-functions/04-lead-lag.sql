-- ============================================
-- LEAD / LAG: access a neighboring row in a window
-- ============================================

-- 1. CONCEPT
-- LAG reads a value from a preceding row; LEAD reads from a following row according
-- to the window order. They do not collapse rows like GROUP BY.

-- 2. WHY IT IS USED
-- They support period-over-period changes, event gaps, and sequence comparisons.

-- 3. BASIC EXAMPLE
SELECT user_id,
	   id AS order_id,
	   ordered_at,
	   LAG(ordered_at) OVER (
		   PARTITION BY user_id
		   ORDER BY ordered_at, id
	   ) AS previous_order_at,
	   LEAD(ordered_at) OVER (
		   PARTITION BY user_id
		   ORDER BY ordered_at, id
	   ) AS next_order_at
FROM orders
ORDER BY user_id, ordered_at, id;

-- 4. PRACTICAL EXAMPLE
WITH monthly_revenue AS (
	SELECT date_trunc('month', orders.ordered_at) AS month_start,
		   SUM(order_items.quantity * order_items.unit_price) AS revenue
	FROM orders
	JOIN order_items ON order_items.order_id = orders.id
	WHERE orders.status = 'delivered'
	GROUP BY date_trunc('month', orders.ordered_at)
)
SELECT month_start,
	   revenue,
	   LAG(revenue) OVER (ORDER BY month_start) AS prior_observed_month_revenue,
	   revenue - LAG(revenue) OVER (ORDER BY month_start) AS change_from_prior_row
FROM monthly_revenue
ORDER BY month_start;

-- 5. IMPORTANT RULES
-- The first LAG row (and last LEAD row) returns NULL unless a default is supplied.
-- The offset and default can be provided as additional arguments.
-- Missing calendar months are absent rows; generate a date series if “previous month”
-- must mean the previous calendar month rather than previous observed row.

-- 6. INTERVIEW NOTES
-- Clarify ordering, partition boundaries, tie-breakers, and gaps in time series.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Show each user's previous order date.
-- Level 2: Calculate days between a user's consecutive orders.
-- Level 3: Calculate month-over-month revenue change including months with zero orders.
-- Level 4: Detect an order followed by no activity for more than 90 days.
