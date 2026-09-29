-- ============================================
-- PRODUCTS: items that can be included in an order
-- ============================================
-- products has no dependency on the other sample tables.

DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	product_name VARCHAR(150) NOT NULL,
	category VARCHAR(80) NOT NULL,
	list_price NUMERIC(10, 2) NOT NULL CHECK (list_price >= 0),
	is_active BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO products (product_name, category, list_price, is_active)
VALUES
	('Mechanical Keyboard', 'Accessories', 89.00, TRUE),
	('Wireless Mouse', 'Accessories', 35.50, TRUE),
	('27-inch Monitor', 'Displays', 329.00, TRUE),
	('USB-C Dock', 'Accessories', 149.00, TRUE),
	('Laptop Stand', 'Accessories', 48.00, TRUE),
	('Noise-Cancelling Headphones', 'Audio', 219.00, TRUE),
	('Webcam', 'Video', 79.00, FALSE),
	('Desk Lamp', 'Office', 42.00, TRUE);
