-- ============================================================
-- SQL TASK 1 - E-COMMERCE SALES ANALYSIS
-- ============================================================

CREATE DATABASE ecommerce_task;
USE ecommerce_task;

-- ============================================================
-- CREATE TABLE
-- ============================================================

CREATE TABLE ecommerce_sales (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    Order_Date DATE,
    City VARCHAR(50)
);

-- ============================================================
-- INSERT 1000 RECORDS
-- ============================================================

INSERT INTO ecommerce_sales
(Order_ID, Customer_ID, Product, Category, Quantity, Price, Order_Date, City)

WITH RECURSIVE numbers AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000
)

SELECT
    n AS Order_ID,

    1000 + ((n * 7) % 500) AS Customer_ID,

    CASE ((n - 1) % 10)
        WHEN 0 THEN 'Laptop'
        WHEN 1 THEN 'Smartphone'
        WHEN 2 THEN 'Headphones'
        WHEN 3 THEN 'Keyboard'
        WHEN 4 THEN 'Mouse'
        WHEN 5 THEN 'Monitor'
        WHEN 6 THEN 'Tablet'
        WHEN 7 THEN 'Smartwatch'
        WHEN 8 THEN 'Printer'
        WHEN 9 THEN 'Camera'
    END AS Product,

    CASE ((n - 1) % 5)
        WHEN 0 THEN 'Electronics'
        WHEN 1 THEN 'Computers'
        WHEN 2 THEN 'Accessories'
        WHEN 3 THEN 'Mobile'
        WHEN 4 THEN 'Home Office'
    END AS Category,

    ((n * 3) % 10) + 1 AS Quantity,

    CASE ((n - 1) % 10)
        WHEN 0 THEN 55000.00
        WHEN 1 THEN 35000.00
        WHEN 2 THEN 2500.00
        WHEN 3 THEN 4500.00
        WHEN 4 THEN 1800.00
        WHEN 5 THEN 22000.00
        WHEN 6 THEN 28000.00
        WHEN 7 THEN 12000.00
        WHEN 8 THEN 15000.00
        WHEN 9 THEN 45000.00
    END AS Price,

    DATE_ADD('2025-01-01', INTERVAL ((n - 1) % 365) DAY) AS Order_Date,

    CASE ((n - 1) % 10)
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Pune'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Bangalore'
        WHEN 4 THEN 'Hyderabad'
        WHEN 5 THEN 'Chennai'
        WHEN 6 THEN 'Kolkata'
        WHEN 7 THEN 'Ahmedabad'
        WHEN 8 THEN 'Nagpur'
        WHEN 9 THEN 'Nashik'
    END AS City

FROM numbers;

-- ============================================================
-- CHECK DATA
-- ============================================================

SELECT COUNT(*) AS Total_Records
FROM ecommerce_sales;

SELECT *
FROM ecommerce_sales
LIMIT 10;


-- ============================================================
-- SQL TASK - 10 QUESTIONS
-- ============================================================

-- Q1. Display all records from the ecommerce_sales table.

SELECT * FROM ecommerce_sales;


-- Q2. Display all orders where the Price is greater than 20000.

SELECT * FROM ecommerce_sales
WHERE Price > 20000;


-- Q3. Find all orders where the Category is 'Electronics'
--     AND the Price is greater than 30000.

SELECT * FROM ecommerce_sales
WHERE Category = "Electronics" AND Price > 30000;


-- Q4. Find all orders where the City is either 'Mumbai'
--     OR 'Pune'.

SELECT * FROM ecommerce_sales
WHERE City IN ("Mumbai","Pune");


-- Q5. Display all orders where the Category is either
--     'Electronics', 'Computers', or 'Mobile'.
--     Use the IN operator.

SELECT * FROM ecommerce_sales
WHERE Category IN ("Electronics","Computers","Mobile");


-- Q6. Display the 10 most expensive products/orders.
--     Sort the records by Price from highest to lowest.

SELECT * FROM ecommerce_sales
ORDER BY Price DESC
LIMIT 10;


-- Q7. Find the following for the complete dataset:
--     a) Total Quantity
--     b) Average Price
--     c) Maximum Price
--     d) Minimum Price

SELECT SUM(Quantity) AS Total_Quantity FROM ecommerce_sales;

SELECT AVG(Price) AS Average_Price FROM ecommerce_sales;

SELECT MAX(Price) AS Maximum_Price FROM ecommerce_sales; 

SELECT MIN(Price) AS Minimum_Price FROM ecommerce_sales;


-- Q8. Find the total quantity of products sold
--     for each Category.
--     Display Category and Total Quantity.

SELECT Category, SUM(Quantity) AS Total_Quantity FROM ecommerce_sales
GROUP BY Category;


-- Q9. Find the categories where the total quantity sold
--     is greater than 1000.
--     Use GROUP BY and HAVING.

SELECT Category, SUM(Quantity) AS Total_Quantity_Sold FROM ecommerce_sales
GROUP BY Category
HAVING SUM(Quantity) > 1000;


-- Q10. Display the 5 orders with the highest Price.
--      Show Order_ID, Product, Category, Price and City.
--      Use ORDER BY and LIMIT.

SELECT Order_ID, Product, Category, Price, City FROM ecommerce_sales
ORDER BY Price DESC
LIMIT 5;

