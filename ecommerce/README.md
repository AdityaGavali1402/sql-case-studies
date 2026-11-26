# E-Commerce Sales Analysis

> Order, category and city analysis of 1,000 online electronics orders using core SQL.

## Business Problem

An online electronics store wants to understand which orders are high-value, which categories and cities drive volume, and where the biggest sales sit, using only its order table.

## Dataset

Table: `ecommerce_sales` (1,000 rows, generated with a recursive CTE so the whole project is reproducible).

| Column | Type | Description |
|---|---|---|
| Order_ID | INT (PK) | Unique order number |
| Customer_ID | INT | Customer who placed the order |
| Product | VARCHAR(100) | Product name (10 products) |
| Category | VARCHAR(50) | Product category (5 categories) |
| Quantity | INT | Units ordered (1 to 10) |
| Price | DECIMAL(10,2) | Price in INR |
| Order_Date | DATE | Order date during 2025 |
| City | VARCHAR(50) | Delivery city (10 cities) |

## Skills Demonstrated

`SELECT` · `WHERE` · `AND / OR` · `IN` · `ORDER BY` · `LIMIT` · Aggregate functions (`SUM`, `AVG`, `MAX`, `MIN`) · `GROUP BY` · `HAVING` · Column aliases · Recursive CTE (data generation)

## Questions and Solutions

### Q1. View all orders 

**Business question:** Show every record in the table.

```sql
SELECT * FROM ecommerce_sales;
```

**Output**

* 1,000 rows returned. First 3 shown:*

| Order_ID | Customer_ID | Product | Category | Quantity | Price | Order_Date | City |
|---|---|---|---|---|---|---|---|
| 1 | 1007 | Laptop | Electronics | 4 | 55,000 | 2025-01-01 | Mumbai |
| 2 | 1014 | Smartphone | Computers | 7 | 35,000 | 2025-01-02 | Pune |
| 3 | 1021 | Headphones | Accessories | 10 | 2500 | 2025-01-03 | Delhi |


**Insight:** The table holds 1,000 orders, 10 products and 10 cities, with orders spread across the whole of 2025.

---

### Q2. High-priced orders 

**Business question:** Which orders have a price above ₹20,000?

```sql
SELECT *
FROM ecommerce_sales
WHERE Price > 20000;
```

**Output**

* 500 rows returned. First 3 shown:*

| Order_ID | Customer_ID | Product | Category | Quantity | Price | Order_Date | City |
|---|---|---|---|---|---|---|---|
| 1 | 1007 | Laptop | Electronics | 4 | 55,000 | 2025-01-01 | Mumbai |
| 2 | 1014 | Smartphone | Computers | 7 | 35,000 | 2025-01-02 | Pune |
| 6 | 1042 | Monitor | Electronics | 9 | 22,000 | 2025-01-06 | Chennai |


**Insight:** Exactly half of all orders (500 of 1,000) are high-ticket, because 5 of the 10 products are priced above ₹20,000.

---

### Q3. Premium electronics 

**Business question:** Which Electronics orders are priced above ₹30,000?

```sql
SELECT *
FROM ecommerce_sales
WHERE Category = 'Electronics'
  AND Price > 30000;
```

**Output**

*100 rows returned. First 3 shown:*

| Order_ID | Customer_ID | Product | Category | Quantity | Price | Order_Date | City |
|---|---|---|---|---|---|---|---|
| 1 | 1007 | Laptop | Electronics | 4 | 55,000 | 2025-01-01 | Mumbai |
| 11 | 1077 | Laptop | Electronics | 4 | 55,000 | 2025-01-11 | Mumbai |
| 21 | 1147 | Laptop | Electronics | 4 | 55,000 | 2025-01-21 | Mumbai |


**Insight:** Only 100 orders (10%) qualify, and all of them are Laptop orders at ₹55,000.

---

### Q4. Orders from Mumbai or Pune 

**Business question:** How many orders come from Mumbai or Pune?

```sql
SELECT *
FROM ecommerce_sales
WHERE City IN ('Mumbai', 'Pune');
```

**Output**

* 200 rows returned. First 3 shown:*

| Order_ID | Customer_ID | Product | Category | Quantity | Price | Order_Date | City |
|---|---|---|---|---|---|---|---|
| 1 | 1007 | Laptop | Electronics | 4 | 55,000 | 2025-01-01 | Mumbai |
| 2 | 1014 | Smartphone | Computers | 7 | 35,000 | 2025-01-02 | Pune |
| 11 | 1077 | Laptop | Electronics | 4 | 55,000 | 2025-01-11 | Mumbai |


**Insight:** These two cities account for 200 orders (20%), 100 each, so demand is evenly split across cities.

---

### Q5. Selected categories 

**Business question:** Show orders in Electronics, Computers or Mobile.

```sql
SELECT *
FROM ecommerce_sales
WHERE Category IN ('Electronics', 'Computers', 'Mobile');
```

**Output**

* 600 rows returned. First 3 shown:*

| Order_ID | Customer_ID | Product | Category | Quantity | Price | Order_Date | City |
|---|---|---|---|---|---|---|---|
| 1 | 1007 | Laptop | Electronics | 4 | 55,000 | 2025-01-01 | Mumbai |
| 2 | 1014 | Smartphone | Computers | 7 | 35,000 | 2025-01-02 | Pune |
| 4 | 1028 | Keyboard | Mobile | 3 | 4500 | 2025-01-04 | Bangalore |


**Insight:** These three categories make up 600 orders (60%) of the business.

---

### Q6. Top 10 most expensive orders 

**Business question:** Which are the 10 most expensive orders?

```sql
SELECT *
FROM ecommerce_sales
ORDER BY Price DESC
LIMIT 10;
```

**Output**

| Order_ID | Product | Price | City |
|---|---|---|---|
| 1 | Laptop | 55,000 | Mumbai |
| 11 | Laptop | 55,000 | Mumbai |
| 21 | Laptop | 55,000 | Mumbai |
| 31 | Laptop | 55,000 | Mumbai |
| 41 | Laptop | 55,000 | Mumbai |
| 51 | Laptop | 55,000 | Mumbai |
| 61 | Laptop | 55,000 | Mumbai |
| 71 | Laptop | 55,000 | Mumbai |
| 81 | Laptop | 55,000 | Mumbai |
| 91 | Laptop | 55,000 | Mumbai |


**Insight:** All 10 rows are Laptop orders at ₹55,000, which is the highest price in the catalogue.

> **Note:** The top 10 rows all share the same value, so which 10 rows MySQL returns is arbitrary. Adding a tie-breaker (for example `ORDER BY Price DESC, Order_ID`) makes the result repeatable.

---

### Q7. Overall sales statistics 

**Business question:** What are the total quantity, average, maximum and minimum price?

```sql
SELECT SUM(Quantity) AS Total_Quantity FROM ecommerce_sales;
SELECT AVG(Price)    AS Average_Price  FROM ecommerce_sales;
SELECT MAX(Price)    AS Maximum_Price  FROM ecommerce_sales;
SELECT MIN(Price)    AS Minimum_Price  FROM ecommerce_sales;
```

**Output**

| Total_Quantity | Average_Price | Maximum_Price | Minimum_Price |
|---|---|---|---|
| 5500 | 22,080 | 55,000 | 1800 |


**Insight:** 5,500 units were sold at an average price of ₹22,080. The most expensive item costs about 30 times the cheapest (₹55,000 vs ₹1,800), so the catalogue spans a very wide price range.

> **Note:** The four queries are combined into one result table here for readability.

---

### Q8. Quantity sold by category 

**Business question:** How many units were sold in each category?

```sql
SELECT Category, SUM(Quantity) AS Total_Quantity
FROM ecommerce_sales
GROUP BY Category;
```

**Output**

| Category | Total_Quantity |
|---|---|
| Accessories | 1500 |
| Computers | 900 |
| Electronics | 1300 |
| Home Office | 700 |
| Mobile | 1100 |


**Insight:** Accessories leads with 1,500 units, while Home Office is lowest at 700, less than half of the leader.

---

### Q9. Categories above 1,000 units 

**Business question:** Which categories sold more than 1,000 units?

```sql
SELECT Category, SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_sales
GROUP BY Category
HAVING SUM(Quantity) > 1000;
```

**Output**

| Category | Total_Quantity_Sold |
|---|---|
| Accessories | 1500 |
| Electronics | 1300 |
| Mobile | 1100 |


**Insight:** Three categories pass the 1,000-unit mark: Accessories (1,500), Electronics (1,300) and Mobile (1,100). Computers (900) and Home Office (700) fall short. `HAVING` filters after grouping, which `WHERE` cannot do.

---

### Q10. Top 5 orders with key details 

**Business question:** Show the 5 highest-priced orders with ID, product, category, price and city.

```sql
SELECT Order_ID, Product, Category, Price, City
FROM ecommerce_sales
ORDER BY Price DESC
LIMIT 5;
```

**Output**

| Order_ID | Product | Category | Price | City |
|---|---|---|---|---|
| 1 | Laptop | Electronics | 55,000 | Mumbai |
| 11 | Laptop | Electronics | 55,000 | Mumbai |
| 21 | Laptop | Electronics | 55,000 | Mumbai |
| 31 | Laptop | Electronics | 55,000 | Mumbai |
| 41 | Laptop | Electronics | 55,000 | Mumbai |


**Insight:** The five highest-value orders are all Laptops shipped to Mumbai at ₹55,000, so the biggest tickets are concentrated in one product and one city.

> **Note:** The top 10 rows all share the same value, so which 10 rows MySQL returns is arbitrary. Adding a tie-breaker (for example `ORDER BY Price DESC, Order_ID`) makes the result repeatable.

---

## Key Takeaways

- Demand is balanced: every city has 100 orders and every product has 100 orders.
- Accessories is the volume leader (1,500 units); Home Office is the weakest category (700 units).
- Laptops are the highest-value product at ₹55,000 and dominate every top-price result.
- `HAVING` was needed to filter on aggregated quantity (`SUM`), while `WHERE` handled row-level filters.

## Files

- [`ecommerce.sql`](./ecommerce.sql): table creation, data generation and all 10 queries

## Tools Used

MySQL 8 (MySQL Workbench)

[← Back to all case studies](../README.md)
