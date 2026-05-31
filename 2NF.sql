-- 1. the columms who has partial dependancy are: product_name and unit_price - both depends on product_ID. customer_name depends only on order_id.
-- 2. the schema is on main folder
-- 3. Write CREATE TABLE statements for all four tables.
CREATE TABLE customers(
	customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_name TEXT NOT NULL
);

CREATE TABLE products(
	product_id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_name TEXT NOT NULL,
	price REAL
);

CREATE TABLE orders(
	order_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
	order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	qty INT NOT NULL,
	PRIMARY KEY (order_id, product_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 4. Insert the data from the original table into your 2NF schema.

INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO products (product_id, product_name, price) VALUES
(42, 'Keyboard', 49.99),
(77, 'Mouse', 29.99);

INSERT INTO orders (order_id, customer_id) VALUES
(1001, 1),
(1002, 2);

INSERT INTO order_items (order_id, product_id, qty) VALUES
(1001, 42, 2),
(1001, 77, 1),
(1002, 42, 1);

-- 5. Write a query to reproduce the original table's data using JOINs.

SELECT
	o.order_id,
	p.product_id,
	oi.qty,
	c.customer_name,
	p.product_name,
	p.price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_id;

-- 6. Bonus: rename "Keyboard" to "Mechanical Keyboard" — in the bad table vs the 2NF table. How many rows changed in each?

UPDATE bad_table
SET product_name = 'Mechanical Keyboard'
WHERE product_name = 'Keyboard';

-- two rows will change becauce the are no relationships between tables

UPDATE products
SET product_name = 'Mechanical Keyboard'
WHERE product_id = 42;

-- here in the 2NF table you are certain that you have changed the right item because of the id relationship and its connection to the original keyboard item
