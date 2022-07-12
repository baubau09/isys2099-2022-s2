USE citizen;

-- 1/ Using indexing to optimize

-- Query 1
SELECT * FROM people WHERE id = 12345;
-- No need to do anything because the `id` field has a primary index on it already


-- Query 2
SELECT * FROM people WHERE first_name LIKE 'A%';
-- We should create an index on the first_name field
ALTER TABLE people
ADD INDEX idx_first_name (first_name);


-- Query 3
SELECT first_name, last_name
FROM people join cities
ON current_location = cities.id
WHERE cities.name = 'Melbourne';
-- We should create an index on the `name` of cities table for the WHERE
-- and another index on the current_location of people table for the JOIN
ALTER TABLE cities
ADD INDEX idx_name (name);

ALTER TABLE people
ADD INDEX idx_current_location (current_location);


-- 2/ Using partitioning to optimize

CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` datetime NOT NULL,
  `birth_location` int(11) NOT NULL,
  `current_location` int(11) NOT NULL,
  PRIMARY KEY (`id`, birth_date)
) PARTITION BY RANGE (year(birth_date)) (
PARTITION p0 VALUES LESS THAN (1970),
PARTITION p1 VALUES LESS THAN (1980),
PARTITION p2 VALUES LESS THAN (1990),
PARTITION p3 VALUES LESS THAN (2000),
PARTITION p4 VALUES LESS THAN (2010),
PARTITION p5 VALUES LESS THAN MAXVALUE
);
