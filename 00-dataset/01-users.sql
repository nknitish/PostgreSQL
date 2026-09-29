-- ============================================
-- USERS: customers who can place orders
-- ============================================
-- Run this file first. Other datasets reference users(id).
-- Re-running this file replaces this table and dependent tables because of CASCADE.

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age INTEGER,
    city VARCHAR(100),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, age, city, is_active, created_at)
VALUES
    ('Nitish', 'nitish@example.com', 28, 'Bangalore', TRUE, '2024-01-10 09:00'),
    ('Rahul', 'rahul@example.com', 30, 'Delhi', TRUE, '2024-02-12 10:30'),
    ('Amit', 'amit@example.com', 25, 'Mumbai', TRUE, '2024-03-15 12:00'),
    ('Priya', 'priya@example.com', 27, 'Bangalore', TRUE, '2024-04-02 08:15'),
    ('Sneha', 'sneha@example.com', 32, 'Pune', FALSE, '2024-05-20 16:45'),
    ('Rohit', 'rohit@example.com', 29, 'Delhi', TRUE, '2024-06-11 11:20'),
    ('Riya', 'riya@example.com', 24, 'Hyderabad', TRUE, '2024-07-08 14:10'),
    ('Karan', 'karan@example.com', 35, 'Mumbai', TRUE, '2024-08-19 09:40'),
    ('Meera', 'meera@example.com', NULL, 'Chennai', TRUE, '2024-09-01 13:00'),
    ('Arjun', 'arjun@example.com', 31, NULL, FALSE, '2024-10-23 17:25'),
    ('Neha', 'neha@example.com', 26, 'Pune', TRUE, '2025-01-05 07:50'),
    ('Rohan', 'rohan@example.com', 28, 'Bangalore', TRUE, '2025-02-14 19:15');