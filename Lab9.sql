CREATE DATABASE lab9;
-------------------------------------------------------
CREATE TABLE employee (
                           name VARCHAR(255) NOT NULL ,
                           lastname VARCHAR(255) NOT NULL ,
                           department INTEGER NOT NULL ,
                           city VARCHAR(255),
                           salary INT
);
INSERT INTO employee(name,lastname,department, city, salary) VALUES('Michael','Rogers',14, 'Almaty', 300000);
INSERT INTO employee(name,lastname,department, city, salary) VALUES('Anand','Manikutty',14, 'Shymkent', 350000);
INSERT INTO employee(name,lastname,department, city, salary) VALUES('Carol','Smith',37, 'Astana', 320000);
INSERT INTO employee(name,lastname,department, city, salary) VALUES('Joe','Stevens',37, 'Almaty', 400000);
--------------------------------------------------------

--------------------------------------------------------
CREATE TABLE product(
                       ord_no INTEGER PRIMARY KEY,
                       purch_amt FLOAT,
                       ord_date INTEGER
);
INSERT INTO product(ord_no, purch_amt, ord_date) VALUES (70001, 150.5, 2012-10-05);
INSERT INTO product(ord_no, purch_amt, ord_date) VALUES (70009, 270.65, 2012-09-10);
INSERT INTO product(ord_no, purch_amt, ord_date) VALUES (70002, 65.26, 2012-10-05);
--------------------------------------------------------

-- 1
CREATE FUNCTION increase_value(num INT) RETURNS INT AS
    $$
    BEGIN
        RETURN num + 10;
    END;
    $$
LANGUAGE PLPGSQL;

SELECT increase_value(10);

--2
CREATE FUNCTION compare_number(num1 int, num2 int, out equal boolean, out lesser numeric, out greater numeric) AS
    $$
    BEGIN
        lesser = least(num1, num2);
        greater = greatest(num1, num2);
        equal = (num1 = num2);
    END;
    $$
LANGUAGE plpgsql;

SELECT compare_number(3, 6);

--3
CREATE FUNCTION number_series(n int) RETURNS TABLE(series_n INT) AS
    $$
    BEGIN
        RETURN QUERY
        SELECT generate_series(1, n);
    END;
    $$
LANGUAGE plpgsql;

SELECT number_series(7);

--4
CREATE FUNCTION find_employee(e_name VARCHAR) RETURNS TABLE (lastname VARCHAR, department INT, city VARCHAR) AS
    $$
    BEGIN
        RETURN QUERY SELECT e.lastname, e.department, e.city
        FROM employee e
        WHERE e.name = e_name;
    END;
    $$
LANGUAGE plpgsql;

SELECT * FROM find_employee('Joe');

--5
CREATE FUNCTION list_products(prod_num INT) RETURNS TABLE(purch_amt FLOAT, ord_date INT) AS
    $$
    BEGIN
        RETURN QUERY SELECT p.purch_amt, p.ord_date
        FROM product p
        WHERE ord_no = prod_num;
    END;
    $$
LANGUAGE plpgsql;

SELECT * FROM list_products(70001);

--6
CREATE FUNCTION calculate_bonus(salary FLOAT) RETURNS FLOAT AS
    $$
    DECLARE new_salary FLOAT;
    BEGIN
        new_salary = salary * 1.5;
        RETURN new_salary;
    END;
    $$
LANGUAGE plpgsql;

CREATE FUNCTION update_salary(emp_name VARCHAR) RETURNS FLOAT AS
    $$
    DECLARE bonus FLOAT;
    DECLARE current_sal FLOAT;
    BEGIN
        SELECT salary FROM employee WHERE name = emp_name;
        bonus = calculate_bonus(current_sal);
        RETURN bonus;
    END;
    $$
LANGUAGE plpgsql;

SELECT calculate_bonus(300000);

--7
CREATE FUNCTION complex_colculation(num INT, str VARCHAR) RETURNS VARCHAR(200) AS
    $$
    DECLARE num_computation INT;
    DECLARE str_manipulation VARCHAR;
    BEGIN
        --sub block 1
        num_computation = (num + 10) - 5;

        --sub block 2
        str_manipulation = REPLACE('City Olympics', 'City', 'World');

        RETURN CONCAT('String result: ', str_manipulation, '; Number result: ', num_computation);
    END;
    $$
LANGUAGE plpgsql;

SELECT complex_colculation(5, 'City Olympic');