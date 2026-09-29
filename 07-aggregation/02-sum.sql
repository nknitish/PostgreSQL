-- ============================================
-- SUM: total numeric values
-- ============================================

-- SUM(expression) adds non-NULL input values. If there are no non-NULL values,
-- the result is NULL (not zero); use COALESCE only when zero is the intended meaning.

SELECT SUM(list_price) AS catalog_list_price_total
FROM products
WHERE is_active IS TRUE;

-- Order revenue from line-item snapshots; decide whether cancelled orders count.
SELECT SUM(order_items.quantity * order_items.unit_price) AS delivered_revenue
FROM orders
JOIN order_items ON order_items.order_id = orders.id
WHERE orders.status = 'delivered';

-- Revenue by customer; INNER JOIN omits customers with no qualifying orders.
SELECT orders.user_id,
	   SUM(order_items.quantity * order_items.unit_price) AS delivered_revenue
FROM orders
JOIN order_items ON order_items.order_id = orders.id
WHERE orders.status = 'delivered'
GROUP BY orders.user_id
ORDER BY delivered_revenue DESC;

-- PostgreSQL supports aggregate FILTER for multiple conditional totals in one scan.
SELECT SUM(order_items.quantity * order_items.unit_price)
		   FILTER (WHERE orders.status = 'delivered') AS delivered_total,
	   SUM(order_items.quantity * order_items.unit_price)
		   FILTER (WHERE orders.status = 'cancelled') AS cancelled_total
FROM orders
JOIN order_items ON order_items.order_id = orders.id;

-- Interview focus: NULL behavior, join multiplication, and the business definition
-- of revenue (ordered, shipped, delivered, refunded, discounted, or net).
-- Practice: compute monthly delivered revenue; include months with no revenue;
-- compare product-level and order-level totals without double-counting.
