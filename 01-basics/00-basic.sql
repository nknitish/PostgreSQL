-- show all databases in the PostgreSQL server

SELECT datname
FROM pg_database;

-- show all tables in the current database

select tablename
from pg_tables
where schemaname = 'public';

-- Run Entire file
-- Shift + Enter
 -- Run Current line
 --Shft + Control + Enter