-- ============================================
-- ORDERS: one purchase event per customer checkout
-- ============================================
-- Requires users. Line items are stored separately in order_items; do not
-- duplicate product or quantity data on this table.

DROP TABLE IF EXISTS orders CASCADE;

CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL REFERENCES users(id),
	ordered_at TIMESTAMP NOT NULL,
	status VARCHAR(20) NOT NULL CHECK (
		status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')
	)
);

INSERT INTO orders (user_id, ordered_at, status)
VALUES
	(1, '2025-01-10 10:15', 'delivered'),
	(1, '2025-02-14 14:30', 'shipped'),
	(2, '2025-01-18 09:00', 'delivered'),
	(2, '2025-03-02 16:45', 'cancelled'),
	(3, '2025-02-03 11:20', 'processing'),
	(4, '2025-01-25 13:10', 'delivered'),
	(4, '2025-03-12 08:40', 'pending'),
	(5, '2025-02-20 17:00', 'delivered'),
	(6, '2025-03-05 12:25', 'shipped'),
	(8, '2025-03-18 15:55', 'delivered'),
	(11, '2025-04-01 10:05', 'pending');
