-- Exercise 1

delimiter $
create procedure sp_assign_as_manager(in Dno int, in Essn char(9))
begin
  start transaction;
	  update department set Mgr_ssn = Essn, Mgr_start_date = curdate()
	  where Dnumber = Dno;
	  
	  update employee set salary = salary + 1000
	  where ssn = Essn;
  commit;
end $$
delimiter ;

call sp_assign_as_manager(5, '123456789');


-- Exercise 2

delimiter $$
create procedure sp_assign_new_project(in emp_ssn char(10),
                                       in proj_no int,
									                     in work_hours float)
begin
  start transaction;
	  insert into works_on(Essn, Pno, Hours)
    values(emp_ssn, proj_no, work_hours);
	  
	  update employee set salary = salary + 500
	  where ssn = emp_ssn;
      
    select sum(hours) into @total_hours
    from works_on where Essn = emp_ssn;
      
    if @total_hours > 40 then
      rollback;
	  else
      commit;
	  end if;
end $$
delimiter ;

call sp_assign_new_project('888665555', 2, 15);
