create database lab10;

--Tables
create table book(
    book_id integer primary key,
    title varchar(50),
    author varchar(50),
    price decimal,
    quantity integer
);

create table orders(
    order_id integer primary key,
    book_id integer,
    foreign key (book_id) references book(book_id),
    customer_id integer,
    order_date date,
    quantity integer
);

create table customers(
    customer_id integer primary key,
    name varchar(20),
    email varchar(100)
);

--Data
insert into book(book_id, title, author, price, quantity) values (1, 'Database 101', 'A.Smith', 40.00, 10);
insert into book(book_id, title, author, price, quantity) values (2, 'Learn SQL', 'B.Johnson', 35.00, 15);
insert into book(book_id, title, author, price, quantity) values (3, 'Advenced DB', 'C.Lee', 50.00, 5);

insert into orders(order_id, book_id, customer_id, order_date, quantity) values(1, 1, 101, '18-03-24', 5);
insert into orders(order_id, book_id, customer_id, order_date, quantity) values(2, 2, 102, '20-03-24', 3);

insert into customers(customer_id, name, email) values(101, 'John Doe', 'johndoe@example.com');
insert into customers(customer_id, name, email) values(102, 'Jane Doe', 'janedoe@example.com');

--Tasks: 1
begin;
insert into orders(order_id, book_id, customer_id, order_date, quantity) values(1, 1, 101, '2024-12-05', 2);
update book
set quantity = quantity - 2
where book_id = 1;
commit;

ROLLBACK TRANSACTION

--Task: 2
begin;
insert into orders(order_id, book_id, customer_id, order_date, quantity) values(3, 3, 102, '2024-11-05', 10);
if (select quantity from book where book_id = 3) < 10 then rollback;
else
update book
set quantity = quantity - 10
where book_id = 3;
commit;
end if;

--Task: 3
begin;
set transaction isolation level read committed;
update book
set price = price + 5.00
where book_id = 1;
select price from book where book_id = 1;
commit;

--Task: 4
begin;
update customers
set email = 'johndoeupdated@example.com'
where customer_id = 101;
commit;
select * from customers where customer_id = 101;