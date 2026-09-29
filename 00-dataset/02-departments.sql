-- ============================================
-- DEPARTMENTS: organizational units for employees
-- ============================================
-- Run before employees because employees.department_id references departments.id.
-- For a clean rebuild, use users, departments, products, employees, orders,
-- then order_items (see README).

DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
	id SERIAL PRIMARY KEY,
	department_name VARCHAR(100) UNIQUE NOT NULL,
	location VARCHAR(100) NOT NULL
);

INSERT INTO departments (department_name, location)
VALUES
	('Engineering', 'Bangalore'),
	('Sales', 'Delhi'),
	('Finance', 'Mumbai'),
	('Human Resources', 'Bangalore'),
	('Support', 'Pune');
