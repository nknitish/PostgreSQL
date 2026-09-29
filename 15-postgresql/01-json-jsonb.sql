-- ============================================
-- JSON / JSONB: store and query semi-structured values
-- ============================================

-- 1. CONCEPT
-- json stores the original input text; jsonb stores a decomposed binary form that
-- is generally faster to query and index, but does not preserve whitespace/key order.

-- 2. WHY IT IS USED
-- JSONB is useful for flexible attributes and integration payloads when fields vary.
-- Stable, frequently joined or constrained fields usually belong in typed columns.

-- 3. BASIC EXAMPLES
SELECT '{"theme":"dark","alerts":true}'::jsonb AS settings;

SELECT '{"theme":"dark","alerts":true}'::jsonb -> 'theme' AS theme_json,
	   '{"theme":"dark","alerts":true}'::jsonb ->> 'theme' AS theme_text;

-- -> returns JSON/JSONB; ->> returns text. #> and #>> accept a path array.
SELECT '{"profile":{"city":"Bangalore"}}'::jsonb #>> '{profile,city}' AS city;

-- 4. PRACTICAL EXAMPLE
-- The existing normalized dataset needs no JSON column; this scratch query shows
-- the PostgreSQL operators without changing the users schema.
SELECT payload ->> 'event_type' AS event_type
FROM (VALUES
	('{"event_type":"login","source":"web"}'::jsonb),
	('{"event_type":"purchase","source":"mobile"}'::jsonb)
) AS events(payload)
WHERE payload @> '{"source":"web"}'::jsonb;

-- 5. IMPORTANT RULES
-- Missing key and JSON null are different states. Test key presence with ? and
-- JSON null deliberately; ->> maps JSON scalar values to text and can return SQL NULL.
-- GIN indexes support common containment/existence operations; operator class choice matters.
-- JSONB containment @> is structural, not text substring matching.

-- 6. COMMON MISTAKES
-- Storing all application data in one JSON document weakens relational constraints,
-- type safety, and query clarity. Avoid repeatedly casting text JSON in hot predicates.

-- 7. INTERVIEW NOTES
-- Compare json and jsonb, operators, indexing, missing versus null, and when a field
-- should be promoted to a normal column.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Extract a nested scalar as text.
-- Level 2: Filter documents by containment and create an appropriate GIN index.
-- Level 3: Distinguish absent key, JSON null, and SQL NULL in a query.
-- Level 4: Design a schema for searchable event attributes with a stable typed core.
