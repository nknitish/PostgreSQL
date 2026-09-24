-- ============================================
-- USERS TABLE
-- ============================================

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age INTEGER,
    city VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users (name, email, age, city)
VALUES
    ('Nitish', 'nitish@example.com', 28, 'Bangalore'),
    ('Rahul', 'rahul@example.com', 30, 'Delhi'),
    ('Amit', 'amit@example.com', 25, 'Mumbai'),
    ('Priya', 'priya@example.com', 27, 'Bangalore'),
    ('Sneha', 'sneha@example.com', 32, 'Pune'),
    ('Rohit', 'rohit@example.com', 29, 'Delhi');



SELECT * FROM users;