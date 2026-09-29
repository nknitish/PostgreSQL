-- ============================================
-- DENSE_RANK: rank peers without gaps
-- ============================================

-- DENSE_RANK gives equal values the same rank and advances by one for the next
-- distinct ordering value: 1, 1, 2. It is useful for top-N distinct score levels.

SELECT id,
	   first_name,
	   department_id,
	   salary,
	   DENSE_RANK() OVER (
		   PARTITION BY department_id
		   ORDER BY salary DESC
	   ) AS salary_band_rank
FROM employees
ORDER BY department_id, salary_band_rank, id;

-- Example pattern: to include everyone in the top three distinct salary amounts,
-- place this query in a CTE and filter salary_band_rank <= 3 outside.

-- Interview note: clarify whether “top 3” means three rows (ROW_NUMBER), rank positions
-- with gaps (RANK), or three distinct value levels (DENSE_RANK).
-- Practice tasks (no solutions): rank products within category by price; return the
-- top two distinct prices per category; compare ties under all three ranking functions.
