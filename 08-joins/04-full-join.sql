-- ============================================
-- FULL OUTER JOIN: preserve rows from both sides
-- ============================================

-- 1. CONCEPT
-- FULL JOIN returns matching row combinations plus unmatched rows from both inputs;
-- columns from the missing side are NULL.

-- 2. WHY IT IS USED
-- It is useful for reconciliation when either side may contain unmatched records.

-- 3. BASIC EXAMPLE
-- This report makes missing city values on either side visible.
WITH expected_cities(city) AS (
	VALUES ('Bangalore'), ('Delhi'), ('Pune'), ('Jaipur')
),
observed_cities AS (
	SELECT DISTINCT city
	FROM users
	WHERE city IS NOT NULL
)
SELECT expected_cities.city AS expected_city,
	   observed_cities.city AS observed_city
FROM expected_cities
FULL OUTER JOIN observed_cities
	ON observed_cities.city = expected_cities.city
ORDER BY COALESCE(expected_cities.city, observed_cities.city);

-- 4. IMPORTANT RULES
-- A full join can produce many rows for duplicate keys on both sides.
-- Use COALESCE on the key to display the value from whichever side exists.
-- Filters on either side can unintentionally remove the unmatched rows you wanted.

-- 5. COMMON MISTAKES
-- Using FULL JOIN for ordinary parent-child listing when LEFT JOIN is sufficient.
-- Assuming the join key is unique without validating source cardinality.

-- 6. INTERVIEW NOTES
-- Explain how a full join supports source-to-source reconciliation and how to classify
-- matched, left-only, and right-only records using NULL tests.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Reconcile two scratch lists of expected and actual product codes.
-- Level 2: Return only unmatched values from either side.
-- Level 3: Explain row multiplication when both sides contain duplicate keys.
