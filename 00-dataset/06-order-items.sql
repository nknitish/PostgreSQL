-- ============================================
-- ORDER_ITEMS: products and quantities on each order
-- ============================================
-- Requires orders and products. unit_price is a purchase-time snapshot:
-- historical order totals must not change when a product's list_price changes.

DROP TABLE IF EXISTS order_items CASCADE;

CREATE TABLE order_items (
    order_id INTEGER NOT NULL REFERENCES orders(id),
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 89.00),
    (1, 2, 1, 35.50),
    (2, 3, 1, 329.00),
    (2, 4, 1, 149.00),
    (3, 6, 1, 219.00),
    (4, 5, 2, 48.00),
    (5, 2, 2, 35.50),
    (5, 8, 1, 42.00),
    (6, 1, 1, 89.00),
    (6, 5, 1, 48.00),
    (7, 3, 2, 329.00),
    (8, 7, 1, 79.00),
    (9, 4, 1, 149.00),
    (9, 2, 1, 35.50),
    (10, 6, 1, 219.00),
    (10, 1, 2, 89.00),
    (11, 8, 1, 42.00);