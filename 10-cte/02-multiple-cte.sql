-- ============================================
-- MULTIPLE CTEs: build a query in named stages
-- ============================================

-- Each CTE below answers one question at a defined grain. Later CTEs may read
-- earlier ones, which helps prevent accidental order-line/customer fan-out.

WITH order_totals AS (
	SELECT orders.id AS order_id,
		   orders.user_id,
		   orders.ordered_at,
		   orders.status,
		   SUM(order_items.quantity * order_items.unit_price) AS order_total
	FROM orders
	JOIN order_items ON order_items.order_id = orders.id
	GROUP BY orders.id, orders.user_id, orders.ordered_at, orders.status
),
customer_totals AS (
	SELECT order_totals.user_id,
		   COUNT(*) FILTER (WHERE order_totals.status = 'delivered') AS delivered_orders,
		   COALESCE(SUM(order_totals.order_total)
			   FILTER (WHERE order_totals.status = 'delivered'), 0) AS delivered_revenue
	FROM order_totals
	GROUP BY order_totals.user_id
)
SELECT users.id,
	   users.name,
	   COALESCE(customer_totals.delivered_orders, 0) AS delivered_orders,
	   COALESCE(customer_totals.delivered_revenue, 0) AS delivered_revenue
FROM users
LEFT JOIN customer_totals ON customer_totals.user_id = users.id
ORDER BY delivered_revenue DESC, users.id;

-- Important: order_totals has one row per order, customer_totals one per user.
-- Always identify and preserve each stage's grain before joining stages together.

-- Interview notes: CTEs can make complex logic inspectable, but repeated references
-- and materialization decisions may affect cost. Validate high-impact assumptions by plan.

-- Practice tasks (no solutions):
-- Level 1: Build stages for employee counts and department averages.
-- Level 2: Build monthly revenue then customer-level lifetime revenue.
-- Level 3: Add a stage that ranks each customer's months by revenue.
-- Challenge: Keep customers with no orders and report zero without changing aggregate meaning.
