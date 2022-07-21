-- Q1
SELECT v.name AS vendor_name, a.name AS application_name
FROM vendor v JOIN application a
ON v.id = a.vendor_id;

-- Q2
SELECT `name`
FROM vendor
WHERE id NOT IN (
  SELECT vendor_id FROM application
);

-- Q3
-- Explanation: inner most statement (i.e., inner2)=> vendor id and its most expensive application's price
-- 2nd inner most statement (i.e., inner1) => vendor id and its 2nd most expensive application's price
-- outer most statement: search vendor and application based on vendor id and its application's price
SELECT vendor.name, app.`name`, app.price
FROM application app JOIN vendor
ON vendor.id = app.vendor_id
WHERE (vendor_id, price) IN
(
	SELECT inner1.vendor_id, MAX(inner1.price)
	FROM application inner1
	WHERE (vendor_id, price) NOT IN
	(
		SELECT inner2.vendor_id, MAX(inner2.price)
		FROM application inner2
		GROUP BY inner2.vendor_id
	)
  GROUP BY inner1.vendor_id
);