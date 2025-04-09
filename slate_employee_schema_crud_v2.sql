-- 📁 Create SLATE Schema
CREATE SCHEMA IF NOT EXISTS slate;

-- 📄 Create Employee Table
CREATE TABLE IF NOT EXISTS slate.Employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    join_date DATE
);

-- 📄 Create Contact Details Table
CREATE TABLE IF NOT EXISTS slate.ContactDetails (
    contact_id SERIAL PRIMARY KEY,
    employee_id INT UNIQUE,
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    CONSTRAINT fk_contact_employee FOREIGN KEY (employee_id)
        REFERENCES slate.Employee (employee_id) ON DELETE CASCADE
);

-- 📄 Create Bank Details Table
CREATE TABLE IF NOT EXISTS slate.BankDetails (
    bank_id SERIAL PRIMARY KEY,
    employee_id INT UNIQUE,
    account_holder_name VARCHAR(100),
    account_number VARCHAR(20),
    bank_name VARCHAR(100),
    ifsc_code VARCHAR(20),
    CONSTRAINT fk_bank_employee FOREIGN KEY (employee_id)
        REFERENCES slate.Employee (employee_id) ON DELETE CASCADE
);

-- 📄 Create Documents Table
CREATE TABLE IF NOT EXISTS slate.Documents (
    document_id SERIAL PRIMARY KEY,
    employee_id INT,
    document_type VARCHAR(50),
    document_path TEXT,
    CONSTRAINT fk_document_employee FOREIGN KEY (employee_id)
        REFERENCES slate.Employee (employee_id) ON DELETE CASCADE
);

-- ✅ INSERT Example
-- Add a new employee
INSERT INTO slate.Employee (first_name, last_name, date_of_birth, gender, join_date)
VALUES ('Kiran', 'Kumar', '1995-07-21', 'Male', CURRENT_DATE);

-- Add contact details for the employee (assume employee_id = 1)
INSERT INTO slate.ContactDetails (employee_id, phone, email, address, city, state, pincode)
VALUES (1, '9876543210', 'kiran@example.com', '123 Main St', 'Hyderabad', 'Telangana', '500001');

-- Add bank details
INSERT INTO slate.BankDetails (employee_id, account_holder_name, account_number, bank_name, ifsc_code)
VALUES (1, 'Kiran Kumar', '1234567890', 'SBI', 'SBIN0012345');

-- Add a document
INSERT INTO slate.Documents (employee_id, document_type, document_path)
VALUES (1, 'Aadhaar', '/docs/kiran_aadhaar.pdf');

-- 🧾 SELECT Operations
-- View all employee data
SELECT * FROM slate.Employee;

-- View joined contact, bank, and document info
SELECT e.*, c.phone, c.email, b.account_number, d.document_type
FROM slate.Employee e
LEFT JOIN slate.ContactDetails c ON e.employee_id = c.employee_id
LEFT JOIN slate.BankDetails b ON e.employee_id = b.employee_id
LEFT JOIN slate.Documents d ON e.employee_id = d.employee_id;

-- ✏️ UPDATE Operation
-- Update contact number for employee_id 1
UPDATE slate.ContactDetails
SET phone = '9998887770'
WHERE employee_id = 1;

-- ❌ DELETE Operation
-- Delete employee (will cascade delete related details)
DELETE FROM slate.Employee
WHERE employee_id = 1;

-- 📋 View all tables under SLATE schema
-- Run this in SQL Shell or psql
-- \dt slate.*
