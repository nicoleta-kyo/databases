-- Answer to the 2nd Database Assignment 2017/18
--
-- 167184 
-- Please insert your candidate number in the line above
-- Do not remove ANY lines of this template.


-- In each section below put your answer in a new line BELOW the corresponding comment.
-- Use ONE SQL statement ONLY per question.
-- If you don’t answer a question just leave the corresponding space blank. 
-- Anything that does not run in SQL you have to put in comments. Your code should never throw a syntax error.
-- Questions with syntax errors will receive zero marks.

-- DO NOT REMOVE ANY LINE FROM THIS FILE.

-- START OF ASSIGNMENT CODE


-- @@01
CREATE TABLE FW_Lorry(
vehicleRegNo CHAR(7) PRIMARY KEY,
make ENUM('Volvo', 'Ashok', 'Ford', 'Hyundai', 'Iveco', 'MAN', 'Mercedes-BENZ', 'Scania', 'Skoda', 'Tata'),
maxLoad DECIMAL(3,1) DEFAULT '40.0',
accessories SET('Combination', 'Dual', 'EOBR', 'Tandem')
);

-- @@02
CREATE TABLE FW_TransportRequirement(
number INT(255),
order_no INT(10) UNSIGNED,
lorry CHAR(7) NOT NULL,
transport_quantity DECIMAL(3,1) DEFAULT '0',
PRIMARY KEY(number, order_no),
CONSTRAINT fk_order_ FOREIGN KEY (order_no) REFERENCES FW_SalesOrder(order_no)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_lorry_ FOREIGN KEY (lorry) REFERENCES FW_Lorry(vehicleRegNo)
);

-- @@03
ALTER TABLE FW_Person
ADD dob DATE;


-- @@04
UPDATE FW_Person
SET house_no = TRIM(LEADING '0' FROM house_no);

-- @@05
DELETE 
FROM FW_PhoneNumbers
WHERE phoneNum = '01273007007' AND owner IN (SELECT person_id FROM FW_Client);


-- @@06
SELECT salesPerson_id
FROM FW_Places
WHERE quantity > 200
ORDER BY salesPerson_id ASC;


-- @@07
SELECT person_id, lastName, monthly_sales_target
FROM FW_Person NATURAL JOIN FW_SalesPerson
ORDER BY lastName, monthly_sales_target DESC;


-- @@08
SELECT COUNT(order_date) number_orders
FROM FW_SalesOrder
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 20 DAY) AND order_date <= CURDATE();

-- @@09
SELECT FW_Client.person_id, firstName firstname, lastName lastname 
FROM FW_Client JOIN FW_Person
ON FW_Client.person_id = FW_Person.person_id
WHERE LEFT(firstname, 2) = BINARY LEFT(lastname, 2);

-- @@10
SELECT order_no, price*quantity total
FROM FW_Places NATURAL JOIN FW_SalesOrder
ORDER BY total DESC;

-- @@11

SELECT person_id, CONCAT(LEFT(firstName, 1), ' ', lastName) name, quantity*price quarterly_sales
FROM (FW_Places JOIN FW_SalesOrder
ON FW_Places.order_no = FW_SalesOrder.order_no)
JOIN FW_Person
ON FW_Places.salesPerson_id = FW_Person.person_id
WHERE QUARTER(order_date) = QUARTER(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())
GROUP BY salesPerson_id;

-- @@12
SELECT FW_Places.salesPerson_id, ROUND(SUM(FW_Places.quantity/quant_s)/num_orders*100) as avg_vol
FROM (FW_Places JOIN (SELECT order_no, SUM(quantity) quant_s
					FROM FW_Places
					GROUP BY order_no) t1 ON FW_Places.order_no = t1.order_no) NATURAL JOIN (SELECT salesPerson_id, COUNT(salesPerson_ID) num_orders
														FROM FW_Places
														GROUP BY salesPerson_id) t2
GROUP BY salesPerson_id;

-- @@13


-- Do not write any DELIMITER command in the submission.
-- For Q14 and Q15 OMIT the termination symbol at the end of your function/procedure declaration


-- @@14

 


-- @@15



 




-- END OF ASSIGNMENT CODE
