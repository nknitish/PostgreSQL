-- ============================================
-- EMPLOYEES: staff with department and manager relationships
-- ============================================
-- Requires departments. manager_id is a self-referencing foreign key.

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	department_id INTEGER NOT NULL REFERENCES departments(id),
	manager_id INTEGER REFERENCES employees(id),
	first_name VARCHAR(80) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	job_title VARCHAR(100) NOT NULL,
	salary NUMERIC(10, 2) NOT NULL CHECK (salary > 0),
	hired_at DATE NOT NULL
);

INSERT INTO employees
	(department_id, manager_id, first_name, last_name, job_title, salary, hired_at)
VALUES
	(1, NULL, 'Ananya', 'Rao', 'Engineering Manager', 145000, '2019-03-18'),
	(1, 1, 'Dev', 'Shah', 'Backend Engineer', 112000, '2020-06-01'),
	(1, 1, 'Isha', 'Nair', 'Backend Engineer', 108000, '2021-09-13'),
	(1, 1, 'Kabir', 'Das', 'Frontend Engineer', 104000, '2022-01-24'),
	(2, NULL, 'Maya', 'Kapoor', 'Sales Manager', 118000, '2018-11-05'),
	(2, 5, 'Arun', 'Mehta', 'Account Executive', 76000, '2022-07-11'),
	(2, 5, 'Tara', 'Sen', 'Account Executive', 79000, '2023-02-20'),
	(3, NULL, 'Vikram', 'Joshi', 'Finance Manager', 125000, '2017-04-03'),
	(3, 8, 'Leena', 'Pillai', 'Financial Analyst', 88000, '2020-10-19'),
	(4, NULL, 'Farah', 'Khan', 'HR Manager', 98000, '2021-05-17');
