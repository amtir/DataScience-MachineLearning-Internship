
-- T-SQL Part2 
-- 1. Insert Data into offices Table
INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES 
('001', 'New York', '123-456-7890', '123 Main St', NULL, 'NY', 'USA', '10001', 'Northeast'),
('002', 'Los Angeles', '987-654-3210', '456 Sunset Blvd', NULL, 'CA', 'USA', '90001', 'West'),
('003', 'Chicago', '312-555-0198', '789 Lake Shore Dr', NULL, 'IL', 'USA', '60601', 'Midwest'),
('004', 'Houston', '713-555-0187', '101 Main St', NULL, 'TX', 'USA', '77001', 'South'),
('005', 'Miami', '305-555-0176', '202 Ocean Dr', NULL, 'FL', 'USA', '33101', 'Southeast'),
('006', 'Seattle', '206-555-0165', '303 Rainy St', NULL, 'WA', 'USA', '98101', 'Northwest'),
('007', 'San Francisco', '415-555-0154', '404 Golden Gate', NULL, 'CA', 'USA', '94101', 'West'),
('008', 'Boston', '617-555-0143', '505 Harvard Ave', NULL, 'MA', 'USA', '02101', 'Northeast'),
('009', 'Dallas', '214-555-0132', '606 Cowboy Rd', NULL, 'TX', 'USA', '75201', 'South'),
('010', 'Denver', '303-555-0121', '707 Rocky Rd', NULL, 'CO', 'USA', '80201', 'Midwest');

-- 2. Insert Data into employees Table
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES 
(1001, 'Smith', 'John', 'x123', 'john.smith@example.com', '001', NULL, 'Manager'),
(1002, 'Doe', 'Jane', 'x124', 'jane.doe@example.com', '002', 1001, 'Sales Rep'),
(1003, 'Johnson', 'Robert', 'x125', 'robert.johnson@example.com', '003', 1001, 'Sales Rep'),
(1004, 'Brown', 'Emily', 'x126', 'emily.brown@example.com', '004', 1002, 'Sales Rep'),
(1005, 'Davis', 'Michael', 'x127', 'michael.davis@example.com', '005', 1002, 'Sales Rep'),
(1006, 'Wilson', 'Sarah', 'x128', 'sarah.wilson@example.com', '006', 1003, 'Sales Rep'),
(1007, 'Martinez', 'Daniel', 'x129', 'daniel.martinez@example.com', '007', 1003, 'Sales Rep'),
(1008, 'Anderson', 'Laura', 'x130', 'laura.anderson@example.com', '008', 1004, 'Sales Rep'),
(1009, 'Thomas', 'James', 'x131', 'james.thomas@example.com', '009', 1004, 'Sales Rep'),
(1010, 'Hernandez', 'Patricia', 'x132', 'patricia.hernandez@example.com', '010', 1005, 'Sales Rep');

-- 3. Insert Data into customers Table
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES 
(2001, 'Hercules Garage', 'Doe', 'Jane', '555-789-1234', '456 Auto Rd', NULL, 'Los Angeles', 'CA', '90001', 'USA', 1001, 50000.00),
(2002, 'Speedy Motors', 'Johnson', 'Michael', '555-234-5678', '789 Car Ave', NULL, 'New York', 'NY', '10001', 'USA', 1002, 30000.00),
(2003, 'Luxury Cars Ltd', 'Brown', 'Emily', '555-345-6789', '101 Luxury St', NULL, 'Chicago', 'IL', '60601', 'USA', 1003, 70000.00),
(2004, 'MotoHub', 'Wilson', 'Daniel', '555-456-7890', '202 Racing Blvd', NULL, 'Houston', 'TX', '77001', 'USA', 1004, 40000.00),
(2005, 'Elite Auto', 'Davis', 'Sarah', '555-567-8901', '303 Prestige Rd', NULL, 'Miami', 'FL', '33101', 'USA', 1005, 65000.00),
(2006, 'Turbo Cars', 'Martinez', 'Laura', '555-678-9012', '404 Speed St', NULL, 'San Francisco', 'CA', '94101', 'USA', 1006, 35000.00),
(2007, 'Superbike World', 'Anderson', 'James', '555-789-0123', '505 Fast Ln', NULL, 'Boston', 'MA', '02101', 'USA', 1007, 20000.00),
(2008, 'Hyper Cars', 'Thomas', 'Patricia', '555-890-1234', '606 Acceleration Dr', NULL, 'Dallas', 'TX', '75201', 'USA', 1008, 90000.00),
(2009, 'Moto Enthusiasts', 'Hernandez', 'Robert', '555-901-2345', '707 Drive Ave', NULL, 'Denver', 'CO', '80201', 'USA', 1009, 45000.00),
(2010, 'HighSpeed Auto', 'Gonzalez', 'David', '555-012-3456', '808 Racing Rd', NULL, 'Seattle', 'WA', '98101', 'USA', 1010, 55000.00);

-- 4. Insert Data into orders Table
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES 
(3001, '2025-03-01', '2025-03-05', '2025-03-04', 'Shipped', 'Delivered on time', 2001),
(3002, '2025-03-02', '2025-03-06', '2025-03-05', 'Shipped', 'No issues', 2002),
(3003, '2025-03-03', '2025-03-07', NULL, 'Pending', 'Awaiting payment', 2003),
(3004, '2025-03-04', '2025-03-08', '2025-03-07', 'Shipped', 'Customer satisfied', 2004),
(3005, '2025-03-05', '2025-03-09', NULL, 'Pending', 'Delayed due to weather', 2005),
(3006, '2025-03-06', '2025-03-10', '2025-03-09', 'Shipped', 'Express delivery', 2006),
(3007, '2025-03-07', '2025-03-11', '2025-03-10', 'Shipped', 'Delivered before schedule', 2007),
(3008, '2025-03-08', '2025-03-12', NULL, 'Pending', 'Pending stock arrival', 2008),
(3009, '2025-03-09', '2025-03-13', '2025-03-12', 'Shipped', 'Customer requested early delivery', 2009),
(3010, '2025-03-10', '2025-03-14', NULL, 'Pending', 'Awaiting dispatch', 2010);

-- 5. Insert Data into productlines Table
INSERT INTO productlines (productLine, textDescription)
VALUES 
('Bikes', 'Motorbikes and custom bikes for all enthusiasts.'),
('Cars', 'Luxury and high-performance cars.'),
('Trucks', 'Heavy-duty trucks and transport vehicles.'),
('Electric Vehicles', 'Eco-friendly electric cars and bikes.'),
('Sports Cars', 'High-speed sports cars for performance lovers.'),
('SUVs', 'Spacious and powerful SUVs for family and off-road.'),
('Classic Cars', 'Vintage and collector classic cars.'),
('ATVs', 'All-terrain vehicles for adventure seekers.'),
('Scooters', 'Lightweight scooters for city travel.'),
('Hybrid Vehicles', 'Fuel-efficient hybrid cars and motorcycles.');

-- 6. Insert Data into products Table 
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES 
('P001', 'Harley Davidson', 'Bikes', '1:10', 'MotoCorp', 'High-performance cruiser bike.', 50, 15000.00, 18000.00),
('P002', 'Ducati SuperSport', 'Bikes', '1:10', 'MotoCorp', 'Sporty and sleek superbike.', 40, 18000.00, 22000.00),
('P003', 'Tesla Model S', 'Electric Vehicles', '1:18', 'Tesla Inc.', 'Luxury electric sedan.', 30, 75000.00, 80000.00),
('P004', 'Ford F-150', 'Trucks', '1:20', 'Ford', 'Reliable and tough pickup truck.', 60, 40000.00, 45000.00),
('P005', 'Porsche 911', 'Sports Cars', '1:18', 'Porsche', 'Iconic sports car.', 25, 95000.00, 100000.00),
('P006', 'Toyota Highlander', 'SUVs', '1:24', 'Toyota', 'Spacious and family-friendly SUV.', 40, 42000.00, 47000.00),
('P007', 'Chevrolet Camaro', 'Classic Cars', '1:18', 'Chevrolet', 'American muscle car.', 20, 35000.00, 38000.00),
('P008', 'Yamaha R1', 'Bikes', '1:10', 'Yamaha', 'High-speed superbike.', 35, 17000.00, 19000.00),
('P009', 'Honda Civic Hybrid', 'Hybrid Vehicles', '1:24', 'Honda', 'Fuel-efficient hybrid sedan.', 50, 28000.00, 31000.00),
('P010', 'BMW X5', 'SUVs', '1:24', 'BMW', 'Luxury mid-size SUV.', 30, 60000.00, 65000.00);

-- 7. Insert Data into orderdetails Table
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES 
(3001, 'P001', 2, 15000.00, 1),
(3002, 'P002', 1, 18000.00, 1),
(3003, 'P003', 1, 75000.00, 1),
(3004, 'P004', 3, 40000.00, 1),
(3005, 'P005', 1, 95000.00, 1),
(3006, 'P006', 2, 42000.00, 1),
(3007, 'P007', 1, 35000.00, 1),
(3008, 'P008', 2, 17000.00, 1),
(3009, 'P009', 1, 28000.00, 1),
(3010, 'P010', 1, 60000.00, 1);

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES 
(2001, 'CHK001', '2025-03-02', 30000.00),
(2002, 'CHK002', '2025-03-03', 18000.00),
(2003, 'CHK003', '2025-03-04', 75000.00),
(2004, 'CHK004', '2025-03-05', 120000.00),
(2005, 'CHK005', '2025-03-06', 95000.00),
(2006, 'CHK006', '2025-03-07', 84000.00),
(2007, 'CHK007', '2025-03-08', 35000.00),
(2008, 'CHK008', '2025-03-09', 34000.00),
(2009, 'CHK009', '2025-03-10', 28000.00),
(2010, 'CHK010', '2025-03-11', 60000.00);


SELECT * FROM offices;
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM productlines;
SELECT * FROM products;
SELECT * FROM orderdetails;
SELECT * FROM payments;






