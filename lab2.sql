--1
create database lab2;

--2
create table countries(
    country_id serial primary key,
    country_name varchar(100),
    region_id int,
    population int
);
drop  table  countries;

--3
insert into countries(country_id, country_name, region_id, population) values
(1, 'Sample1', 100, 10000);


select * from countries;

--4
insert into countries(country_id, country_name) values
(2, 'Sample2');

--5
update countries set region_id=null;

--6
insert into countries(country_id, country_name, region_id, population) values
(3, 'Sample3', 200, 144000),
(4, 'Sample4', 300, 132000),
(5, 'Sample5', 400, 14000);

--7
alter table countries alter column country_name set  default 'Kazakhstan';
insert into countries(country_id) values
(6);

alter sequence countries_country_id_seq restart 1;
--8
update countries set country_name=default;

--9
update countries set country_id = default;
update countries set country_name = default;
update countries set region_id = default;
update countries set population = default;

--10
create table countries_new(like countries);
select * from countries_new;

--11
insert into countries_new select * from countries;

--12
update countries_new set region_id=1 where region_id is null;

--13
update countries
set population = 10000;

update countries
set population = population*1.1
returning countries.country_name, population as new_population;

--14
select * from countries;
delete from countries where population < 100000;

--15
delete from countries_new
where country_id in (select country_id from countries)
returning *;

insert into countries(country_id) values (2);

--16
delete from countries
returning *;