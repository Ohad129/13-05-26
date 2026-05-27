-- 1. the columms who has partial dependancy are: product_name and unit_price - both depends on product_ID. customer_name depends only on order_id.
-- 2. the diagram is on main folder
-- 3. Write CREATE TABLE statements for all four tables.

CREATE TABLE customers(
	customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
	cutomer_name TEXT NOT NULL
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
