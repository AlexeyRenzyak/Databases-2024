--LAB 1

--1
create database lab1;


--2
create table users(
    id SERIAL,
    firstname varchar(50),
    lastname varchar(50)
);

--3
alter table users
add isadmin integer check (isadmin = 0 or isadmin = 1);

--4
alter table users
drop constraint if exists users_isadmin_check;

alter table users
alter column isadmin type bool
using (not isadmin = 0);

--5
alter table users
alter column isadmin set default false;

--6
alter table users
add constraint pkey primary key(id);

--7
create table tasks(
    id SERIAL,
    name varchar(50),
    userid int
);

--8
drop table tasks;

--9
drop database lab1;
