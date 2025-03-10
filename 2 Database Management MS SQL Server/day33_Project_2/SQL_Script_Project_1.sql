
-- SQL Script Part 1

-- 1. Create the Database
CREATE DATABASE MotorsCertification;
USE MotorsCertification;

-- 2. Create Tables
-- 2.1. Create offices table first since employees reference it
CREATE TABLE offices (
    officeCode VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postalCode VARCHAR(50),
    territory VARCHAR(50)
);

-- 2.2. Create employees table
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50),
    firstName VARCHAR(50),
    extension VARCHAR(50),
    email VARCHAR(100),
    officeCode VARCHAR(50),
    reportsTo INT,
    jobTitle VARCHAR(50),
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber),
    FOREIGN KEY (officeCode) REFERENCES offices(officeCode)
);

-- 2.3. Create customers table
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50),
    salesRepEmployeeNumber INT,
    creditLimit FLOAT,
    FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

-- 2.4. Create orders table before orderdetails
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(50),
    comments TEXT,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- 2.5. Create productlines table
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000)
);

-- 2.6. Create products table
CREATE TABLE products (
    productCode VARCHAR(50) PRIMARY KEY,
    productName VARCHAR(100),
    productLine VARCHAR(50),
    productScale VARCHAR(50),
    productVendor VARCHAR(100),
    productDescription TEXT,
    quantityInStock SMALLINT,
    buyPrice FLOAT,
    MSRP FLOAT,
    FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

-- 2.7. Create orderdetails table after orders and products exist
CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(50),
    quantityOrdered INT,
    priceEach FLOAT,
    orderLineNumber SMALLINT,
    PRIMARY KEY (orderNumber, productCode), -- Composite Primary Key
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);

-- 2.8. Create payments table
CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount FLOAT,
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);


