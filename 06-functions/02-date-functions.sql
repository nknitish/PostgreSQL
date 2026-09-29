-- ============================================
-- DATE / TIME FUNCTIONS: calculate with temporal values
-- ============================================

-- 1. CONCEPT
-- PostgreSQL has distinct DATE, TIME, TIMESTAMP, and TIMESTAMPTZ types. Functions
-- extract parts, truncate to a reporting grain, or perform interval arithmetic.

-- 2. WHY IT IS USED
-- Applications need reliable age, duration, retention, and time-bucket calculations.

-- 3. BASIC EXAMPLES
SELECT id,
	   ordered_at::date AS order_date,
	   EXTRACT(YEAR FROM ordered_at) AS order_year,
	   date_trunc('month', ordered_at) AS order_month
FROM orders;

SELECT CURRENT_DATE AS today,
	   CURRENT_TIMESTAMP AS now_with_time_zone,
	   CURRENT_TIMESTAMP - INTERVAL '7 days' AS one_week_ago;

-- 4. PRACTICAL EXAMPLE
-- Monthly order counts, keeping timestamps as timestamps for correct grouping.
SELECT date_trunc('month', ordered_at) AS month_start,
	   COUNT(*) AS order_count
FROM orders
GROUP BY date_trunc('month', ordered_at)
ORDER BY month_start;

-- 5. IMPORTANT RULES
-- TIMESTAMP is without time zone; TIMESTAMPTZ represents an instant and is rendered
-- using the session time zone. A timestamp literal without zone does not identify UTC.
-- `date + integer` adds days; timestamp arithmetic with INTERVAL is explicit.
-- `age()` returns a symbolic interval (years/months/days), not a fixed duration.
-- Filter a timestamp by a half-open range rather than casting the indexed column to date.
-- CURRENT_TIMESTAMP is fixed at transaction start; clock_timestamp() advances in real time.

-- 6. COMMON MISTAKES
-- Comparing local wall-clock times as if they were UTC.
-- Using BETWEEN with an incomplete final-day timestamp and missing fractional seconds.
-- Grouping by month number alone merges the same month across different years.

-- 7. INTERVIEW NOTES
-- Explain TIMESTAMP vs TIMESTAMPTZ, session time zones, DST, and sargable time ranges.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Return each order's calendar date and month.
-- Level 2: Count delivered orders by month and year.
-- Level 3: Find users who placed an order within 30 days of account creation.
-- Level 4: Build daily UTC metrics while accepting requests in arbitrary local time zones.
