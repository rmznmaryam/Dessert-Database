DROP TABLE has;
DROP TABLE Address;
DROP TABLE Invoice;
DROP TABLE PaymentInformation;
DROP TABLE Order_IceCream;
DROP TABLE Employee;
DROP TABLE Customer;
DROP TABLE IceCream;
DROP TABLE Flavour;


CREATE TABLE Flavour (
    Flavour_ID NUMBER PRIMARY KEY UNIQUE,
    Flavour_Type VARCHAR2(50) NOT NULL UNIQUE,
    Flavour_AllergyInfo VARCHAR2(225),
    Flavour_Available VARCHAR2(10) NOT NULL DEFAULT 'Y',
    Flavour_Description VARCHAR2(255),
    Flavour_Ingredients VARCHAR2(255)
);

CREATE TABLE IceCream (
    Icecream_ID NUMBER PRIMARY KEY UNIQUE,
    Icecream_FlavourID NUMBER UNIQUE,
    Icecream_PricePerUnit DECIMAL(10, 2) DEFAULT 2.50,
    Icecream_StockQuantity NUMBER(10) DEFAULT 100,
    FOREIGN KEY (Icecream_FlavourID) REFERENCES Flavour(Flavour_ID)
);

-- Strong Entity: Customer
-- Stores customer details
CREATE TABLE Customer(
    Customer_ID VARCHAR2(20) NOT NULL UNIQUE,
    Customer_Name VARCHAR2(50) NOT NULL,
    Customer_Address_ID VARCHAR2(50) NOT NULL,
    Customer_Phone_Number VARCHAR2(15) NOT NULL,
    Customer_Email VARCHAR2(30) NOT NULL,
    Customer_Payment_ID VARCHAR2(5) NOT NULL,
    PRIMARY KEY (Customer_ID)    
);

-- Strong Entity: Employee
-- Holds personal information about the employee
CREATE TABLE Employee(
    Employee_ID VARCHAR2(20) NOT NULL Unique,
    Employee_Name VARCHAR2(50) NOT NULL,
    Employee_Birth_Date VARCHAR2(15) NOT NULL,
    Employee_Role VARCHAR2(60) NOT NULL,
    Employee_Email VARCHAR2(30) NOT NULL,
    Employee_Phone_Number VARCHAR2(15) NOT NULL,
    Employee_Salary DECIMAL(8,2),
    Employee_Order_ID VARCHAR2(15),
    PRIMARY KEY (Employee_ID)
);

-- Strong Entity: Order (Order_IceCream)
-- Holds the orders that the customer placed
CREATE TABLE Order_IceCream(
    Order_ID VARCHAR2(20) NOT NULL UNIQUE,
    Order_Employee_ID VARCHAR2(50) NOT NULL UNIQUE,
    Order_IceCream_ID NUMBER NOT NULL UNIQUE, -- Reference to IceCream(Icecream_ID)
    Order_Payment_ID VARCHAR2(10) NOT NULL UNIQUE,
    Order_Order_Status VARCHAR2(20) NOT NULL, -- Increased length for status
    Order_Total_Order DECIMAL(8,2) NOT NULL,
    Order_Invoice_ID VARCHAR2(15) NOT NULL UNIQUE,
    Order_Date DATE NOT NULL, -- Changed to DATE type
    Order_Customer_ID VARCHAR2(10) NOT NULL UNIQUE,
    PRIMARY KEY (Order_ID)
);

CREATE TABLE PaymentInformation (
    Payment_ID VARCHAR2(50) NOT NULL UNIQUE,          
    Method_of_Payment VARCHAR2(50) NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Status VARCHAR2(50) NOT NULL,
    Payment_Amount DECIMAL(10, 2) NOT NULL,
    Customer_ID VARCHAR2(50) UNIQUE,                      
    Invoice_ID VARCHAR2(50) UNIQUE,                      
    PRIMARY KEY (Payment_ID) 
);

-- Weak Entity: Invoice
-- Helps store the bill details which the customer placed an order
CREATE TABLE Invoice (
    Invoice_ID VARCHAR2(20) NOT NULL UNIQUE,
    Invoice_Order_ID VARCHAR2(20) NOT NULL UNIQUE,
    Invoice_Date VARCHAR2(40) NOT NULL,
    Invoice_Total_Amount DECIMAL(8,2) NOT NULL,
    Invoice_Status VARCHAR2(40) NOT NULL,
    Invoice_Customer_ID VARCHAR2(20) NOT NULL UNIQUE,
    Invoice_Payment_Information_ID VARCHAR2(30) NOT NULL UNIQUE,
    FOREIGN KEY (Invoice_Order_ID) REFERENCES Order_IceCream(Order_ID),
    FOREIGN KEY (Invoice_Customer_ID) REFERENCES Customer(Customer_ID),
    PRIMARY KEY (Invoice_ID)
);

CREATE TABLE Address (
    Address_CustomerID VARCHAR2(50) NOT NULL UNIQUE,
    Address_Province VARCHAR2(255),
    Address_City VARCHAR2(255),
    Address_Location VARCHAR2(255),
    Address_ID VARCHAR2(50) NOT NULL UNIQUE,
    Address_Country VARCHAR2(255),
    Address_PostalCode VARCHAR2(255),
    PRIMARY KEY (Address_CustomerID, Address_ID),
    FOREIGN KEY (Address_CustomerID) REFERENCES Customer(Customer_ID)
);

-- Relationship: between Customer and Invoice
CREATE TABLE has (
    Customer_ID VARCHAR2(20) NOT NULL UNIQUE,
    Invoice_ID VARCHAR2(20) NOT NULL UNIQUE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    PRIMARY KEY (Customer_ID, Invoice_ID)
);

-- Populate Tables
--Flavour(ID,TYPE,ALLERGY,AVAILABLE, DESCRIPTION, INGREDIENTS)
INSERT INTO Flavour VALUES(1, 'Mint Chocolate Chip', 'NO Nuts', 'Y', 'Fresh minty ice cream with chocolate chips', 'mint, cocoa, ice cream');
INSERT INTO Flavour VALUES(2, 'Chocolate', 'May contain Hazel nuts', 'Y', 'Rich chocolate ice cream made from high-quality cocoa', 'cocoa, cream, sugar');
INSERT INTO Flavour VALUES(3, 'Vanilla', 'No nuts', 'N', 'Classic vanilla ice cream with a smooth texture', 'vanilla extract, cream, sugar');
INSERT INTO Flavour VALUES(4, 'Strawberry', 'No nuts', 'N', 'Fresh strawberry ice cream made with real strawberries', 'strawberries, cream, sugar');
INSERT INTO Flavour VALUES(5, 'Cookie Dough', 'May contain nuts', 'Y', 'Delicious ice cream with chunks of cookie dough and chocolate chips', 'cookie dough, chocolate chips, cream');

--F
INSERT INTO IceCream VALUES(14, 1, 2.29, 1000);
INSERT INTO IceCream VALUES(15, 2, 2.49, 800);
INSERT INTO IceCream VALUES(16, 3, 2.19, 500);
INSERT INTO IceCream VALUES(17, 4, 2.39, 700);
INSERT INTO IceCream VALUES(18, 5, 2.59, 600);

-- Customer(Customer_ID, Customer_Name, Customer_Address, Customer_Phone_Number, Customer_Email, Customer_Payment_ID)
INSERT INTO Customer VALUES('AA1', 'Azaan', '341 Yonge St, Toronto, ON M4B71', '647-899-1234', 'azaan@gmail.com', 'P1');
INSERT INTO Customer VALUES('AA2', 'Maryam', '15 Wallingford Rd, North York, ON M3G2V1', '647-343-1567', 'maryam@gmail.com', 'P2');
INSERT INTO Customer VALUES('AA3', 'Dan', '27 Kings College Cir, Toronto, ON M5K1A1', '647-256-1273', 'dan@gmail.com', 'P3');
INSERT INTO Customer VALUES('AA4', 'Susan', '300 Borough Dr, Scarborough, ON M1O4P5', '647-999-1415', 'susan@gmail.com', 'P4');
INSERT INTO Customer VALUES('AA5', 'Ali', '245 Church St, Toronto, ON M1T6W1', '647-766-1322', 'ali@gmail.com', 'P5');

-- Employee(Employee_ID, Employee_Name, Employee_Birth_Date, Employee_Role, Employee_Email, Employee_Phone_Number, Employee_Salary, Employee_Order_ID)
INSERT INTO Employee VALUES ('EM1', 'Vaishnavi', '02/02/1999', 'Production Operator', 'vaishnavi@gmail.com', '647-222-5555', 60000.50, 'R1');
INSERT INTO Employee VALUES ('EM2', 'Fatimah', '02/06/1997', 'Flavor Development Specialist', 'fatima@gmail.com', '647-333-5565', 50000.80, 'R2');
INSERT INTO Employee VALUES ('EM3', 'Bilal', '17/05/2000', 'Packaging Operator', 'bilal@gmail.com', '647-221-5499', 65000.80, 'R3');
INSERT INTO Employee VALUES ('EM4', 'Sayeed', '11/04/1995', 'Food Safety Operator', 'bilal@gmail.com', '647-321-8766', 90000.90, 'R4');
INSERT INTO Employee VALUES ('EM5', 'Alexis', '31/09/2000', 'Mainetance Technician', 'alexis@gmail', '647-441-4499', 80000.80, 'R5');

-- Order (Order_ID, Order_Employee_ID, Order_Icecream_ID, Order_Payment_ID, Order_Status, Order_Total_Order, Order_Invoice_ID, Order_Date, Order_Customer_ID)
INSERT INTO Order_IceCream VALUES('OD1', 'EO1', 1, 'OP1', 'Order Complete', 160.50, 'OIN1', TO_DATE('04/12/2024', 'MM/DD/YYYY'), 'CC1');
INSERT INTO Order_IceCream VALUES('OD2', 'EO2', 2, 'OP2', 'Order Pending', 250.25, 'OIN2', TO_DATE('05/12/2023', 'MM/DD/YYYY'), 'CC2');
INSERT INTO Order_IceCream VALUES('OD3', 'EO3', 3, 'OP3', 'Order Shipping', 100.05, 'OIN3', TO_DATE('06/17/2024', 'MM/DD/YYYY'), 'CC3');
INSERT INTO Order_IceCream VALUES('OD4', 'EO4', 4, 'OP4', 'Order Completed', 170.30, 'OIN4', TO_DATE('01/04/2022', 'MM/DD/YYYY'), 'CC4');
INSERT INTO Order_IceCream VALUES('OD5', 'EO5', 5, 'OP5', 'Order Cancelled', 135.95, 'OIN5', TO_DATE('03/19/2019', 'MM/DD/YYYY'), 'CC4');

INSERT INTO PaymentInformation VALUES('401R', 'VISA', TO_DATE('02/03/2024', 'MM/DD/YYYY'), 'DONE', 2443.00, '4001', '120E');
INSERT INTO PaymentInformation VALUES('402R', 'MasterCard', TO_DATE('02/05/2024', 'MM/DD/YYYY'), 'PENDING', 1500.00, 'AA2', '121E');
INSERT INTO PaymentInformation VALUES('403R', 'PayPal', TO_DATE('02/10/2024', 'MM/DD/YYYY'), 'FAILED', 300.50, 'AA3', '122E');
INSERT INTO PaymentInformation VALUES('404R', 'American Express', TO_DATE('02/12/2024', 'MM/DD/YYYY'), 'DONE', 750.75, 'AA4', '123E');
INSERT INTO PaymentInformation VALUES('405R', 'Debit Card', TO_DATE('02/15/2024', 'MM/DD/YYYY'), 'DONE', 120.00, 'AA5', '124E');

-- Invoice (Invoice_ID, Invoice_Order_ID, Invoice_Date, Invoice_Total_Amount, Invoice_Status, Invoice_Customer_ID, Invoice_Payment_Information_ID)
-- Now you can insert into Invoice
INSERT INTO Invoice VALUES ('OIN1', 'OD1', '06/01/2024', 160.50, 'Paid', 'AA1', 'P1');
INSERT INTO Invoice VALUES ('OIN2', 'OD2', '07/01/2024', 250.25, 'Pending', 'AA2', 'P2');
INSERT INTO Invoice VALUES ('OIN3', 'OD3', '06/01/2024', 90.10, 'Paid', 'AA3', 'P3');

-- Address(CustomerID, AddressID, Country, Province, City, Location, PostalCode)
INSERT INTO Address VALUES('AA1', '4001', 'Canada', 'Ontario', 'Toronto', '341 Bloor St E', 'L6V 4T3');
INSERT INTO Address VALUES('AA2', '4002', 'Canada', 'Ontario', 'Toronto', '123 King St W', 'M5H 1K4');
INSERT INTO Address VALUES('AA3', '4003', 'Canada', 'Ontario', 'Mississauga', '456 Main St N', 'L5B 1M4');
INSERT INTO Address VALUES('AA4', '4004', 'Canada', 'Ontario', 'Ottawa', '789 Elm St S', 'K1A 0B1');
INSERT INTO Address VALUES('AA5', '4005', 'Canada', 'Ontario', 'Hamilton', '321 Maple Ave', 'L8P 1B5');

-- has
INSERT INTO has VALUES('AA1', 'OIN1');
INSERT INTO has VALUES('AA2', 'OIN2');
INSERT INTO has VALUES('AA3', 'OIN3');