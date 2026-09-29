-- ============================================
-- RANK: rank rows while leaving gaps after ties
-- ============================================

-- RANK assigns the same rank to peers with equal ordering values. The next rank
-- skips by the number of tied rows (1, 1, 3). DENSE_RANK has no gaps (1, 1, 2).

SELECT id,
	   product_name,
	   category,
	   list_price,
	   RANK() OVER (
		   PARTITION BY category
		   ORDER BY list_price DESC
	   ) AS price_rank
FROM products
WHERE is_active IS TRUE
ORDER BY category, price_rank, id;

-- To return everyone tied for the top price in a category, filter rank = 1 in
-- an outer query. Do not add a unique id to the window ORDER BY if equal prices
-- should remain peers; use id only for final presentation order.

-- Important distinction: ROW_NUMBER forces unique positions; RANK preserves peers
-- but leaves gaps; DENSE_RANK preserves peers without gaps.
-- Practice tasks (no solutions):
-- Level 1: Rank employees by salary within each department.
-- Level 2: Return all employees in each department's top two distinct salary levels.
-- Level 3: Rank customers by monthly revenue, retaining equal-revenue ties.
-- Challenge: Explain how adding a tie-breaker changes peer groups and rank values.
