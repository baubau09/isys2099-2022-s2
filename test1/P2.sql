-- SQL statement (the WHERE clause has the form e.id = some_value)
SELECT e.name AS employee_name, a.name AS application_name, `level`
FROM employee e JOIN skill s
ON e.id = s.employee_id
JOIN application a
ON a.id = s.application_id
WHERE e.id = 1;

-- Indexing
-- Explanation: the following fields are searched/joined to find needed data
-- id of employee table
-- id of application table
-- employee_id and application_id of skill table
-- you can create 3 or 4 indexes:
-- first: employee(id)
-- second: application(id)
-- option A: one index can be created on a combination of 2 fields: skill(employee_id, application_id)
-- option B: create 2 separate indexes one on skill(employee_id) and one on skill(application_id)
CREATE INDEX e_id ON employee(id);
CREATE INDEX a_id ON application(id);
CREATE INDEX s_eid ON skill(employee_id);
CREATE INDEX s_aid ON skill(application_id);
