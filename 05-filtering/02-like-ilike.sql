-- ============================================
-- LIKE / ILIKE: match text patterns
-- ============================================

-- 1. CONCEPT
-- LIKE matches a string against a pattern. % matches zero or more characters;
-- _ matches exactly one character. In PostgreSQL, ILIKE is case-insensitive.

-- 2. WHY IT IS USED
-- Pattern matching supports basic search, prefix matching, and data-quality checks.

-- 3. BASIC EXAMPLES
SELECT name
FROM users
WHERE name LIKE 'R%';

SELECT name
FROM users
WHERE name ILIKE '%a_';

-- 4. PRACTICAL EXAMPLE
SELECT product_name, category
FROM products
WHERE product_name ILIKE '%keyboard%';

-- 5. IMPORTANT RULES
-- LIKE and ILIKE are PostgreSQL pattern operators, not regular expressions.
-- To search for a literal % or _, use ESCAPE and escape that character.
-- A normal B-tree index can support some anchored prefix LIKE patterns under
-- compatible collation/operator-class conditions, but not a leading wildcard.
-- For scalable substring search, PostgreSQL's pg_trgm extension is a common option.

-- 6. COMMON MISTAKES
-- '%' matches any length (including empty); '_' matches one character only.
-- ILIKE is PostgreSQL-specific; standard SQL LIKE is case-sensitive in PostgreSQL.

-- 7. INTERVIEW NOTES
-- Expect a discussion of case sensitivity, wildcard meaning, escaping, and indexing.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find names beginning with 'r', ignoring case.
-- Level 2: Find emails from a particular domain using a suffix pattern.
-- Level 3: Find product names containing a literal underscore.
-- Level 4: Design indexed case-insensitive prefix and substring search for a large catalog.
