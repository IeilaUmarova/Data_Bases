CREATE DATABASE lab7;

--1
CREATE INDEX index_countries_name ON countries(name);

--2
CREATE INDEX index_employees_name_surname ON employees(name, surname);

--3
CREATE UNIQUE INDEX index_employee_difference ON employees(salary);

--4
CREATE INDEX index_employees_substring ON employees(substring(name from 1 for 4));

--5
CREATE INDEX index_employees_departments_salary_budget ON employees(salary) INCLUDE (departments_id);
CREATE INDEX index_departments_budget ON departments(budget);