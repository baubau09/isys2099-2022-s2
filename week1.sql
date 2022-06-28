-- 2.1
SELECT DISTINCT Fname FROM Employee JOIN Department
ON Dno = Dnumber JOIN Works_on
ON Essn = Ssn
WHERE hours >= 10 AND Dname = 'Research';

-- 2.2
SELECT DISTINCT Emp.Fname
FROM Employee Mgr JOIN Department ON Mgr.Ssn = Mgr_ssn
JOIN Employee Emp ON Mgr.Ssn = Emp.Super_ssn
WHERE Dname = 'Research';

-- 2.3
SELECT Fname FROM Employee JOIN Department
ON Mgr_ssn = Ssn
WHERE Ssn NOT IN
  (SELECT Essn FROM works_on);

-- 2.4
SELECT Pname, SUM(Hours) AS Total_hour
FROM Project JOIN Works_on ON Pnumber = Pno
GROUP BY Pname;

-- 2.5
SELECT DISTINCT Fname
FROM Employee
WHERE Ssn NOT IN
(
  SELECT Essn
  FROM Project JOIN Works_on ON Pnumber = Pno
  WHERE Plocation = 'Houston'
);

-- 2.6
SELECT DISTINCT Fname
FROM Employee JOIN Works_on w_out ON Ssn = Essn
WHERE NOT EXISTS
(
  SELECT Pnumber
  FROM Project LEFT JOIN (SELECT * FROM Works_on w_in WHERE w_out.Essn = W_in.Essn) AS Prj_Emp
  ON Pnumber = Prj_Emp.Pno
  WHERE Plocation = 'Houston' AND Prj_Emp.Pno IS NULL
);

-- 2.7
SELECT Fname, Salary
FROM Employee
WHERE (Dno, Salary) IN
(
  SELECT Dno, Max(Salary)
  FROM Employee
  GROUP BY Dno
);

-- 2.8
SELECT Dname, COUNT(*) No_Emp
FROM Department JOIN Employee ON Dnumber = Dno
GROUP BY Dname
HAVING COUNT(*) >= 3;

-- 2.9
SELECT Supervisee.Fname, Supervisee.Bdate, Supervisor.Fname, Supervisor.Bdate
FROM Employee Supervisee JOIN Employee Supervisor ON Supervisee.Super_ssn = Supervisor.Ssn
WHERE Supervisee.Bdate <= Supervisor.Bdate;
