--1
create database lab8;

--2
create table salesman (
    salesman_id serial primary key,
    name varchar(50) not null,
    city varchar(50),
    commission decimal(10, 2)
);

create table customers (
    customer_id serial primary key,
    name varchar(50) not null,
    city varchar(50),
    grade int,
    salesman_id int references salesman(salesman_id)
);

create table orders (
    order_id serial primary key,
    order_date date not null,
    amount decimal(10, 2) not null,
    customer_id int references customers(customer_id),
    salesman_id int references salesman(salesman_id)
);

insert into salesman (salesman_id, name, city, commission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

insert into customers (customer_id, name, city, grade, salesman_id) values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

insert into orders (order_id, amount, order_date, customer_id, salesman_id) values
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

--3
create role junior_dev with login;

--4
create or replace view salesmen_in_new_york as
select *
from salesman
where city = 'New York';

select * from salesmen_in_new_york;

--5
create or replace view orders_with_salesmen_customers as
select o.order_id, o.order_date, o.amount, c.name as customer_name, s.name as salesman_name
from orders o
join customers c on o.customer_id = c.customer_id
join salesman s on o.salesman_id = s.salesman_id;

grant all privileges on orders_with_salesmen_customers to junior_dev;

select * from orders_with_salesmen_customers;

--6
create or replace view highest_grade_customers as
select *
from customers where grade = (select max(grade) from customers);

grant select on highest_grade_customers to junior_dev;

select * from highest_grade_customers;

--7
create or replace view salesmen_count_by_city as
select city, count(*) as num_of_salesmen
from salesman
group by city;

select * from salesmen_count_by_city;

--8
create or replace view salesmen_with_multiple_customers as
select s.salesman_id, s.name, count(c.customer_id) as customer_count
from salesman s
join customers c on s.salesman_id = c.salesman_id
group by s.salesman_id
having count(c.customer_id) > 1;

select * from salesmen_with_multiple_customers;

--9
create role intern;

grant junior_dev to intern;



