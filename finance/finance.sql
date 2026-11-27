-- ============================================================
-- SQL TASK 2 - FINANCE / BANKING ANALYSIS
-- ============================================================

CREATE DATABASE finance_task;
USE finance_task;

-- ============================================================
-- CREATE TABLE
-- ============================================================

CREATE TABLE bank_transactions (
    Transaction_ID INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(30),
    Transaction_Type VARCHAR(30),
    Amount DECIMAL(12,2),
    Transaction_Date DATE,
    Branch VARCHAR(50),
    City VARCHAR(50)
);

-- ============================================================
-- INSERT 1000 RECORDS
-- ============================================================

INSERT INTO bank_transactions
(Transaction_ID, Customer_ID, Account_Type, Transaction_Type,
 Amount, Transaction_Date, Branch, City)

WITH RECURSIVE numbers AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000
)

SELECT
    n AS Transaction_ID,

    10000 + ((n * 7) % 500) AS Customer_ID,

    CASE ((n - 1) % 4)
        WHEN 0 THEN 'Savings'
        WHEN 1 THEN 'Current'
        WHEN 2 THEN 'Salary'
        WHEN 3 THEN 'Business'
    END AS Account_Type,

    CASE ((n - 1) % 5)
        WHEN 0 THEN 'Deposit'
        WHEN 1 THEN 'Withdrawal'
        WHEN 2 THEN 'Transfer'
        WHEN 3 THEN 'Payment'
        WHEN 4 THEN 'Investment'
    END AS Transaction_Type,

    CASE ((n - 1) % 10)
        WHEN 0 THEN 75000.00
        WHEN 1 THEN 25000.00
        WHEN 2 THEN 50000.00
        WHEN 3 THEN 12000.00
        WHEN 4 THEN 95000.00
        WHEN 5 THEN 15000.00
        WHEN 6 THEN 45000.00
        WHEN 7 THEN 85000.00
        WHEN 8 THEN 30000.00
        WHEN 9 THEN 60000.00
    END AS Amount,

    DATE_ADD('2025-01-01', INTERVAL ((n - 1) % 365) DAY)
    AS Transaction_Date,

    CASE ((n - 1) % 8)
        WHEN 0 THEN 'Main Branch'
        WHEN 1 THEN 'MG Road Branch'
        WHEN 2 THEN 'Market Branch'
        WHEN 3 THEN 'Station Branch'
        WHEN 4 THEN 'City Center Branch'
        WHEN 5 THEN 'Airport Branch'
        WHEN 6 THEN 'Industrial Branch'
        WHEN 7 THEN 'Camp Branch'
    END AS Branch,

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
FROM bank_transactions;

SELECT *
FROM bank_transactions
LIMIT 10;


-- ============================================================
-- SQL TASK - 10 QUESTIONS
-- ============================================================

-- Q1. Display all records from the bank_transactions table.

select * from bank_transactions;


-- Q2. Display all transactions where the Amount
--     is greater than 50000.

select * from bank_transactions
where Amount > 50000;


-- Q3. Find all transactions where Account_Type is 'Savings'
--     AND Amount is greater than 30000.

select * from bank_transactions 
where Account_Type = "Savings"
and Amount > 30000;


-- Q4. Find all transactions where the Transaction_Type is
--     'Deposit' OR 'Investment'.

select * from bank_transactions
where Transaction_type in ("Deposit","Investment");


-- Q5. Display all transactions where City is either
--     'Mumbai', 'Pune', or 'Delhi'.
--     Use the IN operator.

select * from bank_transactions
where City in ("Mumbai","Pune","Delhi");


-- Q6. Display the 10 transactions with the highest Amount.
--     Sort Amount from highest to lowest.

select * from bank_transactions
order by Amount desc
limit 10;


-- Q7. Find the following for the complete dataset:
--     a) Total Transaction Amount
--     b) Average Transaction Amount
--     c) Maximum Transaction Amount
--     d) Minimum Transaction Amount

select sum(Amount) as Total_Transaction_Amount from bank_transactions;

select avg(Amount) as Avg_Transaction_Amount from bank_transactions;

select max(Amount) as Maximum_Transaction_Amount from bank_transactions;

select min(Amount) as Minimum_Transaction_Amount from bank_transactions;


-- Q8. Find the total transaction Amount for each
--     Account_Type.
--     Display Account_Type and Total Amount.

select Account_Type, sum(Amount) as Total_Amount from bank_transactions
group by Account_Type;


-- Q9. Find the Account_Type where the total transaction
--     Amount is greater than 15000000.
--     Use GROUP BY and HAVING.

select Account_Type, sum(Amount) as Total_Transaction_Amount from bank_transactions
group by Account_Type
having sum(Amount) > 15000000;


-- Q10. Display the 5 highest-value transactions.
--      Show Transaction_ID, Customer_ID, Transaction_Type,
--      Amount, Account_Type and City.
--      Use ORDER BY and LIMIT.

select Transaction_ID, Customer_ID, Transaction_Type, Amount,  Account_Type, City from bank_transactions
order by Amount desc
limit 5;