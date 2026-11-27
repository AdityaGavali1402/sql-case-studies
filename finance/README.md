# Finance / Banking Transaction Analysis

> Transaction, account-type and city analysis of 1,000 bank transactions using core SQL.

## Business Problem

A bank wants to find its high-value transactions, understand which account types move the most money, and see how deposits, investments and city activity are distributed.

## Dataset

Table: `bank_transactions` (1,000 rows, generated with a recursive CTE so the whole project is reproducible).

| Column | Type | Description |
|---|---|---|
| Transaction_ID | INT (PK) | Unique transaction number |
| Customer_ID | INT | Customer who made the transaction |
| Account_Type | VARCHAR(30) | Savings, Current, Salary or Business |
| Transaction_Type | VARCHAR(30) | Deposit, Withdrawal, Transfer, Payment or Investment |
| Amount | DECIMAL(12,2) | Transaction amount in INR |
| Transaction_Date | DATE | Date during 2025 |
| Branch | VARCHAR(50) | Branch name (8 branches) |
| City | VARCHAR(50) | City (10 cities) |

## Skills Demonstrated

`SELECT` · `WHERE` · `AND / OR` · `IN` · `ORDER BY` · `LIMIT` · Aggregate functions (`SUM`, `AVG`, `MAX`, `MIN`) · `GROUP BY` · `HAVING` · Column aliases · Recursive CTE (data generation)

## Questions and Solutions

### Q1. View all transactions 

**Business question:** Show every record in the table.

```sql
SELECT * FROM bank_transactions;
```

**Output**

* 1,000 rows returned. First 3 shown:*

| Transaction_ID | Customer_ID | Account_Type | Transaction_Type | Amount | Transaction_Date | Branch | City |
|---|---|---|---|---|---|---|---|
| 1 | 10007 | Savings | Deposit | 75,000 | 2025-01-01 | Main Branch | Mumbai |
| 2 | 10014 | Current | Withdrawal | 25,000 | 2025-01-02 | MG Road Branch | Pune |
| 3 | 10021 | Salary | Transfer | 50,000 | 2025-01-03 | Market Branch | Delhi |


**Insight:** The table holds 1,000 transactions across 4 account types, 5 transaction types, 8 branches and 10 cities.

---

### Q2. High-value transactions 

**Business question:** Which transactions are above ₹50,000?

```sql
SELECT *
FROM bank_transactions
WHERE Amount > 50000;
```

**Output**

* 400 rows returned. First 3 shown:*

| Transaction_ID | Customer_ID | Account_Type | Transaction_Type | Amount | Transaction_Date | Branch | City |
|---|---|---|---|---|---|---|---|
| 1 | 10007 | Savings | Deposit | 75,000 | 2025-01-01 | Main Branch | Mumbai |
| 5 | 10035 | Savings | Investment | 95,000 | 2025-01-05 | City Center Branch | Hyderabad |
| 8 | 10056 | Business | Transfer | 85,000 | 2025-01-08 | Camp Branch | Ahmedabad |


**Insight:** 400 transactions (40%) exceed ₹50,000, which is a large share and worth monitoring for risk or compliance checks.

---

### Q3. Large Savings account transactions 

**Business question:** Which Savings account transactions are above ₹30,000?

```sql
SELECT *
FROM bank_transactions
WHERE Account_Type = 'Savings'
  AND Amount > 30000;
```

**Output**

* 200 rows returned. First 3 shown:*

| Transaction_ID | Customer_ID | Account_Type | Transaction_Type | Amount | Transaction_Date | Branch | City |
|---|---|---|---|---|---|---|---|
| 1 | 10007 | Savings | Deposit | 75,000 | 2025-01-01 | Main Branch | Mumbai |
| 5 | 10035 | Savings | Investment | 95,000 | 2025-01-05 | City Center Branch | Hyderabad |
| 13 | 10091 | Savings | Transfer | 50,000 | 2025-01-13 | City Center Branch | Delhi |


**Insight:** 200 Savings transactions are above ₹30,000, which is 20% of all transactions and 80% of the 250 Savings transactions.

---

### Q4. Deposits and investments 

**Business question:** Show all Deposit or Investment transactions.

```sql
SELECT *
FROM bank_transactions
WHERE Transaction_Type IN ('Deposit', 'Investment');
```

**Output**

* 400 rows returned. First 3 shown:*

| Transaction_ID | Customer_ID | Account_Type | Transaction_Type | Amount | Transaction_Date | Branch | City |
|---|---|---|---|---|---|---|---|
| 1 | 10007 | Savings | Deposit | 75,000 | 2025-01-01 | Main Branch | Mumbai |
| 5 | 10035 | Savings | Investment | 95,000 | 2025-01-05 | City Center Branch | Hyderabad |
| 6 | 10042 | Current | Deposit | 15,000 | 2025-01-06 | Airport Branch | Chennai |


**Insight:** 400 transactions (40%) are money coming in or being invested, which shows how much activity is savings-oriented rather than spending.

---

### Q5. Transactions in three cities 

**Business question:** Show transactions from Mumbai, Pune or Delhi.

```sql
SELECT *
FROM bank_transactions
WHERE City IN ('Mumbai', 'Pune', 'Delhi');
```

**Output**

* 300 rows returned. First 3 shown:*

| Transaction_ID | Customer_ID | Account_Type | Transaction_Type | Amount | Transaction_Date | Branch | City |
|---|---|---|---|---|---|---|---|
| 1 | 10007 | Savings | Deposit | 75,000 | 2025-01-01 | Main Branch | Mumbai |
| 2 | 10014 | Current | Withdrawal | 25,000 | 2025-01-02 | MG Road Branch | Pune |
| 3 | 10021 | Salary | Transfer | 50,000 | 2025-01-03 | Market Branch | Delhi |


**Insight:** These three cities contribute 300 transactions (30%), 100 each.

---

### Q6. Top 10 highest transactions 

**Business question:** Which are the 10 highest-value transactions?

```sql
SELECT *
FROM bank_transactions
ORDER BY Amount DESC
LIMIT 10;
```

**Output**

| Transaction_ID | Transaction_Type | Amount | City |
|---|---|---|---|
| 5 | Investment | 95,000 | Hyderabad |
| 15 | Investment | 95,000 | Hyderabad |
| 25 | Investment | 95,000 | Hyderabad |
| 35 | Investment | 95,000 | Hyderabad |
| 45 | Investment | 95,000 | Hyderabad |
| 55 | Investment | 95,000 | Hyderabad |
| 65 | Investment | 95,000 | Hyderabad |
| 75 | Investment | 95,000 | Hyderabad |
| 85 | Investment | 95,000 | Hyderabad |
| 95 | Investment | 95,000 | Hyderabad |


**Insight:** The 10 largest transactions are all ₹95,000 Investment transactions in Hyderabad.

> **Note:** The top 10 rows all share the same value, so which 10 rows MySQL returns is arbitrary. Adding a tie-breaker (for example `ORDER BY Amount DESC, Transaction_ID`) makes the result repeatable.

---

### Q7. Overall transaction statistics 

**Business question:** What are the total, average, maximum and minimum transaction amounts?

```sql
SELECT SUM(Amount) AS Total_Transaction_Amount   FROM bank_transactions;
SELECT AVG(Amount) AS Avg_Transaction_Amount     FROM bank_transactions;
SELECT MAX(Amount) AS Maximum_Transaction_Amount FROM bank_transactions;
SELECT MIN(Amount) AS Minimum_Transaction_Amount FROM bank_transactions;
```

**Output**

| Total_Transaction_Amount | Avg_Transaction_Amount | Maximum_Transaction_Amount | Minimum_Transaction_Amount |
|---|---|---|---|
| 49,200,000 | 49,200 | 95,000 | 12,000 |


**Insight:** The bank handled ₹49.2 million across 1,000 transactions, an average of ₹49,200 per transaction, ranging from ₹12,000 to ₹95,000.

> **Note:** The four queries are combined into one result table here for readability.

---

### Q8. Total amount by account type 

**Business question:** How much money moved through each account type?

```sql
SELECT Account_Type, SUM(Amount) AS Total_Amount
FROM bank_transactions
GROUP BY Account_Type;
```

**Output**

| Account_Type | Total_Amount |
|---|---|
| Business | 9,850,000 |
| Current | 9,850,000 |
| Salary | 14,750,000 |
| Savings | 14,750,000 |


**Insight:** Savings and Salary accounts each handle ₹14.75 million, while Current and Business accounts handle ₹9.85 million each. Together, Savings and Salary carry 60% of the total value.

---

### Q9. Account types above ₹15,000,000 

**Business question:** Which account types moved more than ₹15 million?

```sql
SELECT Account_Type, SUM(Amount) AS Total_Transaction_Amount
FROM bank_transactions
GROUP BY Account_Type
HAVING SUM(Amount) > 15000000;
```

**Output**

| Account_Type | Total_Transaction_Amount |
|---|---|


**Insight:** No account type crosses ₹15 million. The closest are Savings and Salary at ₹14.75 million, just ₹250,000 short, so the query returns an empty result.

> **Note:** An empty result is a valid answer. Changing the threshold to 10,000,000 would return Savings and Salary.

---

### Q10. Top 5 transactions with key details 

**Business question:** Show the 5 highest transactions with ID, customer, type, amount, account type and city.

```sql
SELECT Transaction_ID, Customer_ID, Transaction_Type,
       Amount, Account_Type, City
FROM bank_transactions
ORDER BY Amount DESC
LIMIT 5;
```

**Output**

| Transaction_ID | Customer_ID | Transaction_Type | Amount | Account_Type | City |
|---|---|---|---|---|---|
| 5 | 10035 | Investment | 95,000 | Savings | Hyderabad |
| 15 | 10105 | Investment | 95,000 | Salary | Hyderabad |
| 25 | 10175 | Investment | 95,000 | Savings | Hyderabad |
| 35 | 10245 | Investment | 95,000 | Salary | Hyderabad |
| 45 | 10315 | Investment | 95,000 | Savings | Hyderabad |


**Insight:** The five biggest transactions are ₹95,000 Investments made from Savings and Salary accounts in Hyderabad.

> **Note:** The top 10 rows all share the same value, so which 10 rows MySQL returns is arbitrary. Adding a tie-breaker (for example `ORDER BY Amount DESC, Transaction_ID`) makes the result repeatable.

---

## Key Takeaways

- Total transaction value is ₹49.2 million with an average of ₹49,200 per transaction.
- Savings and Salary accounts carry 60% of total money moved.
- Investment transactions in Hyderabad make up the highest-value transactions.
- An empty `HAVING` result (Q9) shows that thresholds should be validated against Q8 totals first.

## Files

- [`finance.sql`](./finance.sql): table creation, data generation and all 10 queries

## Tools Used

MySQL 8 (MySQL Workbench)

[← Back to all case studies](../README.md)
