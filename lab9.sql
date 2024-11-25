--1
create function increase_value(input_value int)
returns int as $$
begin
    return input_value + 10;
end;
$$ language plpgsql;

select * from increase_value(5);

--2
create function compare_numbers(num1 int, num2 int)
returns text as $$
begin
    if num1 > num2 then
        return 'Greater';
    elsif num1 = num2 then
        return 'Equal';
    else
        return 'Lesser';
    end if;
end;
$$ language plpgsql;

select * from compare_numbers(10, 12);

--3
create function number_series(n int)
returns table(series int) as $$
declare
    i int;
begin
    i := 1;
    while i <= n loop
        series := i;
        return next;
        i := i + 1;
    end loop;
end;
$$ language plpgsql;

select * from number_series(10);

--4
create function find_employee(emp_name varchar)
returns table(employee_id int, name varchar, department varchar, salary numeric) as $$
begin
    return query
    select employee_id, name, department, salary
    from employees
    where name = emp_name;
end;
$$ language plpgsql;

--5
create function list_products(category_name varchar)
returns table(product_id int, product_name varchar, price numeric) as $$
begin
    return query
    select product_id, product_name, price
    from products
    where category = category_name;
end;
$$ language plpgsql;

--6
create function calculate_bonus(emp_id int)
returns numeric as $$
declare
    salary numeric;
    bonus numeric;
begin
    select salary into salary from employees where employee_id = emp_id;
    if salary is not null then
        bonus := salary * 0.10;
        return bonus;
    else
        raise exception 'employee not found';
    end if;
end;
$$ language plpgsql;

create or replace function update_salary(emp_id int)
returns void as $$
declare
    bonus numeric;
begin
    bonus := calculate_bonus(emp_id);
    update employees
    set salary = salary + bonus
    where employee_id = emp_id;
end;
$$ language plpgsql;

--7
create or replace function complex_calculation(input_number int, input_text varchar)
returns text as $$
declare
    numeric_result int;
    string_result varchar;
    final_result text;
begin
    <<main_block>>
    begin
        <<numeric_computation>>
        begin
            numeric_result := input_number * 2;
        end numeric_computation;

        <<string_manipulation>>
        begin
            string_result := upper(input_text);
        end string_manipulation;

        final_result := numeric_result || ' ' || string_result;

        return final_result;
    end main_block;
end;
$$ language plpgsql;

select * from complex_calculation(10, 'abc');








