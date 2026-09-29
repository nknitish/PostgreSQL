-- ============================================
-- NUMERIC FUNCTIONS: calculate and round numbers
-- ============================================

-- 1. CONCEPT
-- Numeric functions perform arithmetic, rounding, and numeric conversion.

-- 2. WHY IT IS USED
-- Financial and analytical queries derive totals, percentages, and readable measures.

-- 3. BASIC EXAMPLES
SELECT product_name,
	   list_price,
	   ROUND(list_price * 1.08, 2) AS price_with_tax,
	   CEIL(list_price / 10) AS ten_unit_buckets
FROM products;

SELECT ABS(-12.5) AS absolute_value,
	   POWER(2, 3) AS exponent_result,
	   MOD(17, 5) AS remainder;

-- 4. PRACTICAL EXAMPLE
SELECT order_id,
	   SUM(quantity * unit_price) AS exact_order_total,
	   ROUND(SUM(quantity * unit_price) * 0.10, 2) AS estimated_tax
FROM order_items
GROUP BY order_id
ORDER BY order_id;

-- 5. IMPORTANT RULES
-- NUMERIC/DECIMAL provide exact decimal arithmetic; REAL/DOUBLE PRECISION are
-- approximate binary floating-point types. Do not use float for exact money.
-- Integer division truncates: cast one operand to numeric for fractional results.
-- Rounding policy (per line versus after summing) can change financial totals.

-- 6. COMMON MISTAKES
-- `quantity / 2` with integer operands may produce an integer result.
-- Do not assume ROUND removes the need to define a currency/rounding policy.

-- 7. INTERVIEW NOTES
-- Be able to explain exact versus approximate numeric types and aggregate overflow/precision.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Calculate a 15% discount for each active product.
-- Level 2: Calculate each order's subtotal from stored purchase-time prices.
-- Level 3: Compare round-each-line-then-sum with sum-then-round for a receipt.
-- Level 4: Design numeric precision and rounding rules for multi-currency invoices.
