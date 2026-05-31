-- 1. Check: is this table in 1NF? Explain why.

--    Yes, every field has a single value. No multiple items

-- 2. Check: is this table in 2NF? Explain why (single-column PK).

--    Yes, it does not voilates it because there is only one PK to be dependant on, so there is no partial dependecy

-- 3. Identify all transitive dependencies in the table.

--    The transitive dependencies are:

--    isbn -> author_id -> author_name
--    isbn -> publisher_id -> publisher_name
--    isbn ->  publisher_id -> publisher_city

-- 4. the table design is on the main folder

-- 5. Write CREATE TABLE statements for all three tables with proper PKs and FKs.

CREATE TABLE authors(
	author_id TEXT PRIMARY KEY,
	author_name TEXT NOT NULL
);

CREATE TABLE publishers(
	publisher_id TEXT PRIMARY KEY,
	publisher_name TEXT NOT NULL,
	publisher_city TEXT NOT NULL
);

CREATE TABLE books(
	isbn TEXT PRIMARY KEY,
	title TEXT NOT NULL,
	author_id TEXT NOT NULL,
	publisher_id TEXT NOT NULL,
	FOREIGN KEY (author_id) REFERENCES authors(author_id),
	FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

-- 6. Insert the original data into the normalized tables.

INSERT INTO authors (author_id, author_name) VALUES
('A1', 'Jane Doe'),
('A2', 'John Smith');

INSERT INTO publishers (publisher_id, publisher_name, publisher_city) VALUES
('P1', 'TechPress', 'New York'),
('P2', 'DataBooks', 'Paris');

INSERT INTO books (isbn, title, author_id, publisher_id) VALUES
('978-1', 'SQL Mastery', 'A1', 'P1'),
('978-2', 'Python Pro', 'A2', 'P1'),
('978-3', 'Data Viz', 'A1', 'P2');

-- 7. Write a query to reproduce all original columns using JOINs.

SELECT
	b.isbn,
	b.title,
	b.author_id,
	a.author_name,
	b.publisher_id,
	p.publisher_name,
	p.publisher_city
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id
ORDER BY b.isbn;

-- 8. Bonus: Change Jane Doe's name to "Jane Doe-Smith" — how many rows change in the 3NF vs original schema?

UPDATE bad_table
SET author_name = 'Jane Doe-Smith'
WHERE author_name = 'Jane Doe';

-- This query will change two rows in the table

UPDATE authors
SET author_name = 'Jane Doe-Smith'
WHERE author_id = 'A1';

-- This query will change only one row in the authors table and it will look for the ID so it is certain of the authos identity (same name mistake in big sata)
