
USE MotorsCertification;

-- 6. Find Out the Highest and Lowest Amount
SELECT 
    MAX(amount) AS HighestAmount, 
    MIN(amount) AS LowestAmount 
FROM payments;

-- 7. Get the Unique Count of customerName from customers
SELECT COUNT(DISTINCT customerName) AS UniqueCustomerCount FROM customers;

-- 8. Create a View cust_payment
CREATE VIEW cust_payment AS
SELECT 
    c.customerName, 
    p.amount, 
    c.contactLastName, 
    c.contactFirstName
FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber;

-- Select from the View
SELECT * FROM cust_payment;

-- Truncate and Drop the View
DROP VIEW cust_payment;


-- 9. Create a Stored Procedure for Classic Cars Product Line
CREATE PROCEDURE GetClassicCars
AS
BEGIN
    SELECT * FROM products WHERE productLine = 'Classic Cars';
END;

-- Execute the Stored Procedure
EXEC GetClassicCars;

-- 10 Create a Function to Get creditLimit of Customers Less Than 96800
CREATE FUNCTION GetCustomersByCreditLimit()
RETURNS TABLE
AS
RETURN 
(
    SELECT customerNumber, customerName, creditLimit 
    FROM customers 
    WHERE creditLimit < 96800
);

-- Execute the Function
SELECT * FROM GetCustomersByCreditLimit();

-- 11. Create a Trigger to Store Transaction Record for Employee Table
-- Step 1: Create an Audit Table
CREATE TABLE EmployeeAudit (
    auditID INT IDENTITY(1,1) PRIMARY KEY,
    employeeNumber INT,
    lastName VARCHAR(50),
    firstName VARCHAR(50),
    officeCode VARCHAR(50),
    insertedAt DATETIME DEFAULT GETDATE()
);

-- Step 2: Create the Trigger
CREATE TRIGGER trg_Employee_Insert
ON employees
AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeAudit (employeeNumber, lastName, firstName, officeCode)
    SELECT employeeNumber, lastName, firstName, officeCode FROM inserted;
    
    PRINT 'Employee transaction recorded successfully.';
END;

-- Insert a New Employee (Trigger Will Fire Automatically)
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (1011, 'Williams', 'Sophia', 'x133', 'sophia.williams@example.com', '003', 1001, 'Sales Rep');
-- Check If the Trigger Stored the Transaction in EmployeeAudit
SELECT * FROM EmployeeAudit;

-- 12. Create a Trigger to Display Customer Number If Amount > 10,000
-- Whenever a new payment is added, if the amount is greater than 10,000, the trigger will print the customerNumber.
CREATE TRIGGER trg_HighPayment
ON payments
AFTER INSERT
AS
BEGIN
    DECLARE @customerNumber INT;

    SELECT @customerNumber = customerNumber FROM inserted WHERE amount > 10000;

    IF @customerNumber IS NOT NULL
    BEGIN
        PRINT 'Customer Number with High Payment: ' + CAST(@customerNumber AS VARCHAR);
    END
END;

-- Insert a Payment Greater Than 10,000 (Trigger Should Fire)
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (2005, 'CHK011', '2025-03-12', 9500.00); -- Amount < 10,000
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (2006, 'CHK012', '2025-03-13', 15000.00); -- Amount > 10,000

SELECT * FROM sys.triggers WHERE name = 'trg_HighPayment';

-- 13. Create Users, Roles, and Logins
-- Step 1: Create Logins
CREATE LOGIN AdminLogin WITH PASSWORD = 'Admin@123';
CREATE LOGIN HRLogin WITH PASSWORD = 'HR@123';
CREATE LOGIN EmployeeLogin WITH PASSWORD = 'Employee@123';
-- Step 2: Create Database Users
USE MotorsCertification;

CREATE USER AdminUser FOR LOGIN AdminLogin;
CREATE USER HRUser FOR LOGIN HRLogin;
CREATE USER EmployeeUser FOR LOGIN EmployeeLogin;

-- Step 3: Create Roles
CREATE ROLE AdminRole;
CREATE ROLE HRRole;
CREATE ROLE EmployeeRole;

-- Step 4: Assign Permissions
-- Admin Role (Full Access)
GRANT CONTROL ON DATABASE::MotorsCertification TO AdminRole;
ALTER ROLE AdminRole ADD MEMBER AdminUser;

-- HR Role (Access Only employees and offices Tables)
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO HRRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON offices TO HRRole;
ALTER ROLE HRRole ADD MEMBER HRUser;

-- Employee Role (Read-Only Access to All Tables)
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO HRRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON offices TO HRRole;
ALTER ROLE HRRole ADD MEMBER HRUser;
-- Admin has full database access
-- HR can only manage employees and offices
-- Employees can only view all tables



-- 14. Schedule a Job for Database Backup 
-- This job will automatically back up the database on a scheduled basis.
-- Step 1: Create a Backup Job Using SQL Server Agent
-- This switches to the msdb database because SQL Server Agent jobs are stored there.
USE msdb;
-- Create a Backup Job
EXEC sp_add_job 
    @job_name = 'MotorsCertification_Backup';
-- Creates a new scheduled job named MotorsCertification_Backup
-- -- Add a Job Step (Perform Database Backup)
EXEC sp_add_jobstep 
    @job_name = 'MotorsCertification_Backup',
    @step_name = 'Full Database Backup',
    @subsystem = 'TSQL',
    @command = 'BACKUP DATABASE MotorsCertification TO DISK = ''C:\SQLBackups\MotorsCertification.bak'' WITH FORMAT, INIT, NAME = ''Motors Backup'';',
    @database_name = 'MotorsCertification';
-- Schedule the Job to Run Daily at 2:00 AM
EXEC sp_add_schedule 
    @schedule_name = 'DailyBackupSchedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @active_start_time = 020000; -- Runs at 2:00 AM
-- Attach the Schedule to the Backup Job
EXEC sp_attach_schedule 
    @job_name = 'MotorsCertification_Backup',
    @schedule_name = 'DailyBackupSchedule';
-- Assign the Job to the SQL Server Instance
EXEC sp_add_jobserver 
    @job_name = 'MotorsCertification_Backup';
-- This will run a daily backup at 2:00 AM.
--  Verify if the Job Exists
USE msdb;
SELECT name, enabled FROM sysjobs WHERE name = 'MotorsCertification_Backup';
















