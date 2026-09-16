DROP DATABASE IF EXISTS sales_management;

CREATE DATABASE sales_management;

USE sales_management;
-- 1. Create table: productlines
CREATE TABLE productlines (
productLine VARCHAR(50) PRIMARY KEY,
textDescription VARCHAR(4000) DEFAULT NULL,
htmlDescription MEDIUMTEXT DEFAULT NULL,
image BLOB DEFAULT NULL
);

-- 2. Create table: products
CREATE TABLE products(
productCode VARCHAR(15) primary KEY,
productName VARCHAR(70) NOT NULL,
productLine VARCHAR(50) NOT NULL,
productScale VARCHAR(10) NOT NULL,
productVendor VARCHAR(50) NOT NULL,
productDescription TEXT NOT NULL,
quantityInStock SMALLINT NOT NULL,
buyPrice DECIMAL(10, 2) NOT NULL,
MSRP DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

-- 3. Create table: offices
CREATE TABLE offices (
officeCode INT PRIMARY KEY,
city VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLinel VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50) DEFAULT NULL,
state VARCHAR(50) DEFAULT NULL,
country VARCHAR(50) NOT NULL,
postalCode VARCHAR(15) NOT NULL,
territory VARCHAR(10) NOT NULL
);

-- 4. Create table: employees
CREATE TABLE employees (
employeeNumber INT PRIMARY KEY,
lastName VARCHAR(50) NOT NULL,
firstName VARCHAR(50) NOT NULL,
extension VARCHAR(10) NOT NULL,
email VARCHAR(100) NOT NULL,
officeCode INT NOT NULL,
reportsTo INT DEFAULT NULL,
jobTitle VARCHAR(50) NOT NULL,

FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);


-- 5. Create table: customers
CREATE TABLE customers (
customerNumber INT PRIMARY KEY,
customerName VARCHAR(58) NOT NULL,
contactLastName VARCHAR(58) NOT NULL,
contactFirstName VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50) DEFAULT NULL,
city VARCHAR(58) NOT NULL,
state VARCHAR(50) DEFAULT NULL,
postalCode VARCHAR(15) DEFAULT NULL,
country VARCHAR(50) NOT NULL,
salesRepEmployeeNumber INT DEFAULT NULL,
creditLimit DECIMAL(10, 2) DEFAULT NULL,
FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

-- 6. Create table: orders
CREATE TABLE orders (
orderNumber INT PRIMARY KEY,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE DEFAULT NULL,
status VARCHAR(15) NOT NULL,
comments TEXT DEFAULT NULL,
customerNumber INT NOT NULL,
FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- 7. Create table: orderdetails
CREATE TABLE orderdetails (
orderNumber INT NOT NULL,
productCode VARCHAR(15) NOT NULL,
quantityOrdered INT NOT NULL,
priceEach DECIMAL(10,2) NOT NULL,
orderLineNumber SMALLINT NOT NULL,

PRIMARY KEY(orderNumber,productCode),
FOREIGN KEY(orderNumber) REFERENCES orders(orderNumber),
FOREIGN KEY(productCode) REFERENCES products(productCode)
);

-- 8. Create table: payments
CREATE TABLE payments (
customerNumber INT NOT NULL,
checkNumber VARCHAR(58) NOT NULL,
paymentDate DATE NOT NULL,
amount DECIMAL(10,2) NOT NULL,

PRIMARY KEY(customerNumber,checkNumber),
FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber)
);

INSERT INTO productlines 
(productLine, textDescription)
VALUES
('Classic Cars','Vintage and classic car models'),
('Motorcycles','Motorcycle models'),
('Planes','Aircraft models'),
('Ships','Ship models'),
('Trains','Train models');

INSERT INTO products
(productCode, productName, productLine, productScale, productVendor,productDescription, quantityInStock, buyPrice, MSRP)
VALUES
('S10_001','Toyota Supra','Classic Cars','1:18','Toyota','Sports car model',100,45.00,90.00),
('S10_002','Ford Mustang','Classic Cars','1:18','Ford','Classic muscle car',80,50.00,100.00),
('M10_001','Honda CB750','Motorcycles','1:10','Honda','Classic motorcycle model',120,35.00,75.00),
('P10_001','Boeing 747','Planes','1:200','Boeing','Commercial aircraft model',50,70.00,150.00),
('SH10_001','Titanic Ship','Ships','1:700','Ocean Models','Historical ship model',60,55.00,120.00);



INSERT INTO offices
(officeCode, city, phone, addressLinel, addressLine2,state, country, postalCode, territory)
VALUES
(1,'Colombo','0112345678','Main Street',NULL,'Western','Sri Lanka','00100','Asia'),
(2,'Kandy','0812345678','Peradeniya Road',NULL,'Central','Sri Lanka','20000','Asia'),
(3,'Galle','0912345678','Beach Road',NULL,'Southern','Sri Lanka','80000','Asia');


INSERT INTO employees
(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES
(1001,'Perera','Nimal','x101','nimal@company.com',1,NULL,'President'),
(1002,'Silva','Kamal','x102','kamal@company.com',1,1001,'Sales Manager'),
(1003,'Fernando','Amal','x103','amal@company.com',2,1002,'Sales Representative'),
(1004,'Jayasinghe','Ruwan','x104','ruwan@company.com',3,1002,'Sales Representative');


INSERT INTO customers
(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,
city,state,postalCode,country,salesRepEmployeeNumber,creditLimit)

VALUES
(2001,'ABC Motors','Fernando','Kasun','0771234567','Colombo Road',NULL,'Colombo','Western','10100','Sri Lanka',1003,50000),
(2002,'Auto World','Perera','Saman','0712345678','Kandy Road',NULL,'Kandy','Central','20000','Sri Lanka',1004,30000),
(2003,'Global Traders','Silva','Nuwan','0755555555','Galle Road',NULL,'Galle','Southern','80000','Sri Lanka',1003,40000);


INSERT INTO orders
(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber)
VALUES
(5001,'2026-01-10','2026-01-20','2026-01-15','Shipped','Delivered successfully',2001),
(5002,'2026-02-05','2026-02-15',NULL,'Pending','Waiting for shipment',2002),
(5003,'2026-03-01','2026-03-10','2026-03-08','Shipped',NULL,2003);

INSERT INTO orderdetails
(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
VALUES
(5001,'S10_001',2,90.00,1),
(5001,'S10_002',1,100.00,2),
(5002,'M10_001',3,75.00,1),
(5003,'P10_001',1,150.00,1),
(5003,'SH10_001',2,120.00,2);


INSERT INTO payments
(customerNumber,checkNumber,paymentDate,amount)
VALUES
(2001,'CHK10001','2026-01-18',180.00),
(2002,'CHK10002','2026-02-10',225.00),
(2003,'CHK10003','2026-03-05',390.00);


-- 1.select particular colom from the table
select customerName from customers;
select customerName,contactLastName from customers;

-- 2.select all colom from the particular table
select * from customers;


-- 3.return only distinct (unique) values without duplicate.
select distinct country from customers;
select distinct postalCode from customers;
select distinct postalCode,state,city from customers;

-- 4.counts the number of unique values in the particular table
select count(distinct country) from customers;

-- 5.used to filter records / used to extract only those records that fulfill a specific condition.
select * from customers
where country = 'Sri Lanka';

select city,country from customers
where city='colombo' and country='Sri Lanka';

select * from customers
where customerNumber>2002;

-- 6.The WHERE clause is not only used in SELECT statements, it is also used in UPDATE, DELETE, etc.

-- 7.ORDER BY keyword is used to sort the result-set in ascending or descending order.	
select * from products
order by buyPrice;

select * from products
order by buyPrice;

select * from products
order by buyPrice,MSRP;

select * from products
order by buyPrice,MSRP desc;

select * from products
order by buyPrice desc, MSRP asc;

select * from products
order by buyPrice desc;

select buyPrice from products
order by buyPrice;

-- 8. The WHERE clause can contain one or many AND operators.
--    The AND operator is used to filter records based on more than one condition.
--    The AND operator displays a record if all the conditions are TRUE.

select * from offices
where city='colombo' and country='Sri Lanka';

select * from offices
where country='Sri Lanka' and territory='Asia' and postalCode='20000';

-- 9.The AND operator displays a record if all the conditions are TRUE.
--   The OR operator displays a record if any of the conditions are TRUE.
select * from offices
where country='Sri Lanka' and (city='Kandy'or city='Jaffna');

-- 10.The NOT operator is used in the WHERE clause to return all records that DO NOT match the specified criteria. 
select * from offices
where not city='colombo';

select * from offices
where not city='colombo' and not city='kandy';

-- 11.The NOT LIKE operator is used in the WHERE clause to exclude rows that match a specified character pattern.
-- There are two wildcards often used in conjunction with the NOT LIKE operator:
--           A percent sign % - represents zero, one, or multiple characters
--           A underscore sign _ - represents a single character   

-- 12. The NOT BETWEEN operator is used in the WHERE clause to select rows where a value falls outside a specified inclusive range.
-- The NOT BETWEEN operator can be used with numeric, text, or date values

-- 13.The NOT IN operator is used in the WHERE clause to exclude rows that match any value in a specified list or a subquery result set.
-- 14. The INSERT INTO statement is used to insert new records in a table.
