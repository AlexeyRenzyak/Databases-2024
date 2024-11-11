--1
SELECT * FROM countries WHERE name = ‘string’;

create index index1 on countries (name);

--2
SELECT * FROM employees WHERE name = ‘string’
AND surname = ‘string’;

create index index2 on employees (name, surname);


--3
SELECT * FROM employees WHERE salary < value1
AND salary > value2;

create unique index index3 on employees (salary);

--4
SELECT * FROM employees WHERE substring(name
from 1 for 4) = ‘abcd’;

create index index4 on employees ((substring(name from 1 for  4)));

--5
SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id WHERE
d.budget > value2 AND e.salary < value2;

create index index51 on departments (department_id, budget);
create index index52 on employees (department_id, salary)
