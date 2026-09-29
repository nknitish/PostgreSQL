-- ============================================
-- ROW_NUMBER: assign a unique sequence within a result
-- ============================================

-- 1. CONCEPT
-- ROW_NUMBER numbers rows from 1 according to a window ORDER BY. With PARTITION BY,
-- numbering restarts for each partition. Unlike RANK, every row gets a distinct number.

-- 2. WHY IT IS USED
-- It supports deterministic deduplication, pagination, and top-N-per-group selection.

-- 3. BASIC EXAMPLE
SELECT id,
	   name,
	   ROW_NUMBER() OVER (ORDER BY created_at, id) AS signup_sequence
FROM users;

-- 4. PRACTICAL EXAMPLE
-- Pick one latest order per user; id resolves timestamp ties deterministically.
WITH ranked_orders AS (
	SELECT orders.*,
		   ROW_NUMBER() OVER (
			   PARTITION BY orders.user_id
			   ORDER BY orders.ordered_at DESC, orders.id DESC
		   ) AS row_num
	FROM orders
)
SELECT user_id, id AS latest_order_id, ordered_at, status
FROM ranked_orders
WHERE row_num = 1;

-- 5. IMPORTANT RULES
-- A window function preserves rows; filter its result in an outer query/CTE.
-- ORDER BY must include a unique tie-breaker if a deterministic winner is required.
-- Window ORDER BY does not guarantee final output order; add a query ORDER BY too.

-- 6. COMMON MISTAKES
-- Using ROW_NUMBER when ties should all qualify. Use RANK/DENSE_RANK for that.

-- 7. INTERVIEW NOTES
-- Top-N per group and duplicate removal are common patterns. Explain tie behavior.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Number products from cheapest to most expensive.
-- Level 2: Return each customer's two newest orders.
-- Level 3: Keep the latest staging record per natural key with stable tie-breaking.
-- Level 4: Paginate within each department while preserving equal-salary ties separately.
