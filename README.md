# PostgreSQL SQL Interview Handbook

A self-paced PostgreSQL 16 reference for learning SQL from first principles through
multi-stage interview queries. Lessons explain the reasoning behind the syntax,
show runnable examples against a shared practice dataset, call out common mistakes,
and finish with exercises that intentionally do not include solutions.

## PostgreSQL Setup

Install PostgreSQL 16 and a client such as `psql` or a PostgreSQL VS Code extension.
This repository uses PostgreSQL syntax; psql-specific backslash commands are labeled
separately and are not SQL statements.

## Database Setup

Create the practice database from a connection to an existing database such as `postgres`:

```sql
CREATE DATABASE sql_interview;
```

Connect with psql:

```text
\c sql_interview
```

Or connect from a shell with `psql -d sql_interview`. In a GUI, select `sql_interview`
as the active database. `CREATE DATABASE` must not be run inside a transaction block.

## Dataset

The shared model contains:

- `users`: customer profiles, including deliberate NULL and inactive examples.
- `departments`: organizational units, including one with no employees.
- `employees`: staff, salaries, departments, and a self-referencing manager relationship.
- `products`: catalog items, including an inactive item that has sold.
- `orders`: customer order headers and statuses.
- `order_items`: product, quantity, and purchase-time unit-price snapshots per order.

Rebuild in dependency order from the repository root. Each dataset script replaces its
own table; the users script uses `CASCADE`, so rebuilding the shared data is destructive
to the practice tables and must only be done in the disposable learning database.

```sh
psql -d sql_interview -f 00-dataset/01-users.sql
psql -d sql_interview -f 00-dataset/02-departments.sql
psql -d sql_interview -f 00-dataset/04-products.sql
psql -d sql_interview -f 00-dataset/03-employees.sql
psql -d sql_interview -f 00-dataset/05-orders.sql
psql -d sql_interview -f 00-dataset/06-order-items.sql
```

Order totals should use `order_items.unit_price`, which is the price recorded when
the purchase happened; `products.list_price` is the current catalog value.

## Folder Structure

| Folder                    | Focus                                                               |
| ------------------------- | ------------------------------------------------------------------- |
| `00-database-basics/`     | psql commands, database objects, metadata catalogs                  |
| `00-dataset/`             | Shared tables and deterministic sample rows                         |
| `01-basics/`              | SQL orientation, SELECT, WHERE, sorting, pagination, DISTINCT       |
| `02-database/`            | Create and drop databases                                           |
| `03-tables/`              | Table definitions, migrations, constraints, table lifecycle         |
| `04-crud/`                | INSERT, UPDATE, DELETE, RETURNING                                   |
| `05-filtering/`           | Comparisons, patterns, sets, ranges, NULL                           |
| `06-functions/`           | String, date/time, numeric, and CASE expressions                    |
| `07-aggregation/`         | COUNT, SUM, AVG, GROUP BY, HAVING                                   |
| `08-joins/`               | Inner, outer, and self joins                                        |
| `09-subqueries/`          | Scalar, IN, EXISTS, and correlated queries                          |
| `10-cte/`                 | CTEs, staged queries, recursive traversal                           |
| `11-window-functions/`    | Ranking, partitions, offsets, and analytic patterns                 |
| `12-constraints/`         | Primary, foreign, unique, not-null, and check constraints           |
| `13-indexes/`             | Index design, composite keys, EXPLAIN                               |
| `14-transactions/`        | Commit, rollback, savepoints, isolation, and ACID-oriented practice |
| `15-postgresql/`          | Types/identity, JSONB, arrays, RETURNING, upsert, ILIKE             |
| `16-interview-questions/` | Concept checks and unsolved interview challenges                    |

## Learning Order

Follow the numeric progression, while using `00-dataset/` as shared setup rather than
a lesson to run after every topic. Start with database basics and `01-basics/`; move
through schema/data changes, filters, functions, aggregation, and joins. Then study
subqueries and CTEs before window functions. Finish with constraints, indexes,
transactions, PostgreSQL features, and the interview question sets.

The repository preserves its original topic folders where possible. The dedicated
database-basics folder is an addition; set operations such as `UNION` and `UNION ALL`
are introduced in the basic interview questions.

## Running SQL Files

From the repository root, run a lesson against the practice database:

```sh
psql -d sql_interview -f 01-basics/01-select.sql
```

Inside `psql`, connect with `\c sql_interview`, then use `\i path/to/file.sql`.
In VS Code, select the `sql_interview` connection and run the whole file or a selected
statement using the extension's commands. Exact editor shortcuts depend on the extension.

Mutation lessons use temporary objects or `BEGIN`/`ROLLBACK` where practical. Read each
file's comments before running it. Dataset rebuild scripts drop/recreate practice tables.

## SQL vs PostgreSQL

Core clauses such as SELECT, WHERE, JOIN, GROUP BY, constraints, and transactions are
standard SQL concepts, though details vary by database. PostgreSQL-specific examples
are labeled and include features such as `ILIKE`, `DISTINCT ON`, `RETURNING`, `ON CONFLICT`,
`FILTER`, JSONB operators, arrays, catalog views, identity columns, and `EXPLAIN` options.

psql commands such as `\l`, `\c`, `\dt`, `\d`, `\dn`, and `\du` are client meta-commands,
not SQL. Use SQL queries against `information_schema` or `pg_catalog` in ordinary query editors.

## Interview Preparation Roadmap

1. Be fluent with filtering, NULL/three-valued logic, ordering, and deterministic limits.
2. State row grain before joining or aggregating; watch one-to-many fan-out.
3. Explain WHERE vs HAVING, COUNT(\*) vs COUNT(column), and LEFT JOIN ON vs WHERE.
4. Choose between JOIN, IN, EXISTS, CTEs, and window functions based on intended semantics.
5. Handle ties deliberately with ROW_NUMBER, RANK, or DENSE_RANK.
6. Explain constraints, ACID, isolation, index trade-offs, and plan evidence.
7. Solve each challenge without viewing an answer; validate edge cases including no rows,
   duplicates, ties, NULLs, and boundary timestamps.

## Advanced / Complex Query Practice Roadmap

For each challenge, write assumptions first: output grain, inclusion rules, NULL meaning,
tie behavior, time zone, and whether cancelled orders count. Break the problem into named
stages, test each stage at its own grain, then compose it. Challenge themes progress from
top-N per group and relational division to cohort retention, consecutive streaks,
sessionization, recursive hierarchies, and idempotent writes. Once correctness is established,
scale the data and use `EXPLAIN (ANALYZE, BUFFERS)` to support one targeted optimization.

Solutions are intentionally omitted from practice sections. Ask for a separate solutions
set when ready to compare approaches.
