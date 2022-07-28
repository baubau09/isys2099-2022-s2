USE company;

USE company_no_index;

-- Activity 1

SELECT * FROM Employee WHERE Dno = 5 AND Sex = 'F';

ALTER TABLE Employee
ADD INDEX idx_Dno (Dno);

SELECT * FROM Employee WHERE Sex = 'F' OR Dno = 5;

-- Activity 2

SELECT * FROM (Employee JOIN Dependent ON Ssn = Essn) JOIN Department ON Dno = Dnumber;

SELECT * FROM (Employee JOIN Department ON Dno = Dnumber) JOIN Dependent ON Ssn = Essn;

-- Activity 3

-- Use Sub-query
SELECT Eout.Fname, Dname
FROM Employee Eout JOIN Department
ON Eout.Dno = Dnumber
WHERE Dnumber IN
(SELECT DISTINCT Dno FROM Employee Ein JOIN Dependent ON Essn = Ein.Ssn AND Ei.Ssn = Eout.Ssn);

-- Use Join
SELECT DISTINCT Fname, Dname
FROM Employee JOIN Department
ON Dno = Dnumber
Join Dependent
ON Essn = Ssn;
