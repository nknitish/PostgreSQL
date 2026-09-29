-- ============================================
-- STRING FUNCTIONS: transform and inspect text
-- ============================================

-- 1. CONCEPT
-- String functions return transformed or derived text without changing stored rows.

-- 2. WHY IT IS USED
-- They support display formatting, normalization, validation, and reporting.

-- 3. BASIC EXAMPLES
SELECT name,
	   UPPER(name) AS uppercase_name,
	   LOWER(name) AS lowercase_name,
	   LENGTH(name) AS character_count
FROM users;

SELECT product_name,
	   TRIM(product_name) AS trimmed_name,
	   LEFT(product_name, 10) AS short_name,
	   REPLACE(product_name, '-', ' ') AS display_name
FROM products;

-- PostgreSQL concatenation with concat handles NULL arguments as empty strings;
-- || propagates NULL. Choose deliberately.
SELECT concat(name, ' / ', city) AS concat_function,
	   name || ' / ' || city AS concatenation_operator
FROM users;

-- 4. PRACTICAL EXAMPLE
-- Normalize a comparison key for display/search; this is not a uniqueness guarantee.
SELECT id,
	   email,
	   LOWER(TRIM(email)) AS normalized_email
FROM users;

-- 5. IMPORTANT RULES
-- LENGTH(text) counts characters, not bytes; OCTET_LENGTH counts bytes.
-- LOWER/UPPER behavior depends on locale/collation; Unicode case-folding is nuanced.
-- Applying a function to an indexed column may prevent a plain index from being used;
-- use a matching expression index or store a normalized key when justified.

-- 6. COMMON MISTAKES
-- Do not assume concatenation treats NULL identically across functions/operators.
-- Do not use string formatting for data that should remain a date or numeric value.

-- 7. INTERVIEW NOTES
-- Explain expression indexes for queries such as WHERE lower(email) = ... and
-- why a unique constraint on raw email may not enforce case-insensitive uniqueness.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Return trimmed and uppercase product categories.
-- Level 2: Count the characters and bytes in every user email.
-- Level 3: Find duplicate emails after lowercasing and trimming a staging dataset.
-- Level 4: Propose a case-insensitive email uniqueness design with migration considerations.
