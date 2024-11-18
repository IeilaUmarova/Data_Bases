--1
CREATE DATABASE lab8;

--2
CREATE TABLE salesman(
    salesman_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    comission FLOAT
);

CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesman
);

CREATE TABLE orders(
    ord_no INTEGER PRIMARY KEY,
    purch_amt FLOAT,
    ord_date INTEGER,
    customer_id INTEGER REFERENCES customers,
    salesman_id INTEGER REFERENCES salesman
);

INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5001, 'James Hong', 'New York', 0.15);
INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5002, 'Nail Knite', 'Paris', 0.13);
INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5005, 'Pit Alex', 'London', 0.11);
INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5006, 'Mc Lyon', 'Paris', 0.14);
INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5003, 'Lauson Hen', DEFAULT, 0.12);
INSERT INTO salesman(salesman_id, name, city, comission) VALUES (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3002, 'Nick Rimando', 'New York', 100, 5001);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3001, 'Brad Guzan', 'London', DEFAULT, 5005);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3004, 'Fabian Johns', 'Paris', 300, 5006);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3009, 'Geoff Camero', 'Berlin', 100, 5003);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70001, 150.5, 2012-10-05, 3005, 5002);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70009, 270.65, 2012-09-10, 3001, 5005);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70002, 65.26, 2012-10-05, 3002, 5001);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70004, 110.5, 2012-08-17, 3009, 5003);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70007, 948.5, 2012-09-10, 3005, 5002);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70005, 2400.6, 2012-07-27, 3007, 5001);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70008, 5760, 2012-09-10, 3002, 5001);

--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE VIEW salesman_view AS
    SELECT * FROM salesman
WHERE city = 'New York';

--5
CREATE VIEW orders_view AS
    SELECT * FROM orders o
JOIN customers c on c.customer_id = o.customer_id
JOIN salesman s on s.salesman_id = o.salesman_id;

GRANT ALL PRIVILEGES ON orders_view TO junior_dev;

--6
CREATE VIEW customers_grade_view AS
    SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON customers_grade_view TO junior_dev;

--7
CREATE VIEW number_of_salesman AS
    SELECT city, COUNT(*) FROM salesman
GROUP BY city;

--8
CREATE VIEW each_salesman AS
    SELECT * FROM salesman s
JOIN customers c on s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

--9
CREATE ROLE intern;

GRANT junior_dev TO intern;