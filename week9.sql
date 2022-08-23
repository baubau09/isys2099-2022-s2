-- Exercise 1

create view dept_stats as 
select d.dnumber, dname, mgr_tbl.fname, count(*) as no_emp
from department d join employee mgr_tbl
on d.mgr_ssn = mgr_tbl.ssn
join employee emp_tbl
on d.dnumber = emp_tbl.dno
group by dnumber, dname, fname;


-- Exercise 2

-- Part 1

DELIMITER $$

create procedure sp_update_salary(in essn char(9), in amount decimal(5))
begin
	update Employee set salary = salary + amount
  where Ssn = essn;
end $$

DELIMITER ;

call sp_update_salary('111222333', 5000);


-- Part 2

-- Note: to be able to set "not deterministic", either call
-- SET GLOBAL log_bin_trust_function_creators = 1;
-- in the console
-- or add the following line
-- log_bin_trust_function_creators = 1;
-- in the mysql.ini file
-- Ref: https://stackoverflow.com/questions/26015160/deterministic-no-sql-or-reads-sql-data-in-its-declaration-and-binary-logging-i

DELIMITER $$

create function fn_busiest_emp(dept_no INT)
returns char(9) not deterministic
begin
	declare busiest_emp char(9);

	select Essn into busiest_emp
	from employee join works_on
	on Essn = Ssn
	where Dno = dept_no
  group by Essn
	order by count(*) desc
	limit 1;
    
  return busiest_emp;
end $$

DELIMITER ;

select fn_busiest_emp(5);


-- Exercise 3

-- Part 1

delimiter $$

create trigger tgr_prevent_salary_decrease
before update on employee
for each row
begin
  if old.salary > new.salary then
    signal sqlstate '45000' set message_text = 'Cannot decrease salary';
  end if;
end $$

delimiter ;

update employee set salary = 12000 where ssn = '123456789';


-- Part 2

delimiter $$

create trigger tgr_prevent_overwork
before insert on works_on
for each row
begin
  -- current total hours
  declare current_total decimal(3, 1);
  
  select sum(hours) into current_total
  from works_on
  where Essn = new.Essn;

  if (current_total + new.Hours) > 40 then
    signal sqlstate '45000' set message_text = 'This employee is overworked';
  end if;
end $$

delimiter ;


select essn, sum(hours)
from works_on
group by essn;


insert into works_on values('123456789', 1, 5);
