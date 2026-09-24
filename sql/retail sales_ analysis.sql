create database retail_sales;
USE retail_sales;
create table retail_sale2;
SHOW DATABASES;
USE retail_sales;
SHOW TABLES;
SELECT COUNT(*) AS total_rows
FROM retail_sales_dataset;
SELECT *
FROM retail_sales_dataset
LIMIT 10;
DESCRIBE retail_sales_dataset;
# Now we start DATA PREPARATION
SELECT
    SUM(`Transaction ID` IS NULL) AS null_transaction_id,
    SUM(`Date` IS NULL) AS null_date,
    SUM(`Customer ID` IS NULL) AS null_customer_id,
    SUM(`Gender` IS NULL) AS null_gender,
    SUM(`Age` IS NULL) AS null_age,
    SUM(`Product Category` IS NULL) AS null_product_category,
    SUM(`Quantity` IS NULL) AS null_quantity,
    SUM(`Price per Unit` IS NULL) AS null_price_per_unit,
    SUM(`Total Amount` IS NULL) AS null_total_amount
FROM retail_sales_dataset;

# Check Duplicate Transactions
SELECT
    `Transaction ID`,
    COUNT(*) AS duplicate_count
FROM retail_sales_dataset
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;
# Check invalid values
SELECT *
FROM retail_sales_dataset
WHERE `Age` <= 0
   OR `Age` > 100
   OR `Quantity` <= 0
   OR `Price per Unit` <= 0
   OR `Total Amount` <= 0;
   # Check Amount Calculation
   
SELECT *
FROM retail_sales_dataset
WHERE `Quantity` * `Price per Unit` <> `Total Amount`;
 # Check the Date Values
 SELECT `Date`
FROM retail_sales_dataset
LIMIT 10;
# Check for Invalid Dates
SELECT *
FROM retail_sales_dataset
WHERE STR_TO_DATE(`Date`, '%m/%d/%Y') IS NULL;
# Check Gender Values
SELECT
    `Gender`,
    COUNT(*) AS total
FROM retail_sales_dataset
GROUP BY `Gender`;
# Product Category
SELECT
    `Product Category`,
    COUNT(*) AS total
FROM retail_sales_dataset
GROUP BY `Product Category`;
# Check the Transaction IDs
SELECT
    MIN(`Transaction ID`) AS minimum_id,
    MAX(`Transaction ID`) AS maximum_id,
    COUNT(DISTINCT `Transaction ID`) AS unique_ids,
    COUNT(*) AS total_rows
FROM retail_sales_dataset;
# Check Date Range
SELECT
    MIN(STR_TO_DATE(`Date`, '%m/%d/%Y')) AS earliest_date,
    MAX(STR_TO_DATE(`Date`, '%m/%d/%Y')) AS latest_date
FROM retail_sales_dataset;
# Check the number of records by Gender
SELECT
    `Gender`,
    COUNT(*) AS total_customers
FROM retail_sales_dataset
GROUP BY `Gender`
ORDER BY total_customers DESC;
# Check Age Distribution
SELECT
    MIN(`Age`) AS minimum_age,
    MAX(`Age`) AS maximum_age,
    ROUND(AVG(`Age`), 2) AS average_age
FROM retail_sales_dataset;
# Check Quantity Distribution
SELECT
    MIN(`Quantity`) AS minimum_quantity,
    MAX(`Quantity`) AS maximum_quantity,
    ROUND(AVG(`Quantity`), 2) AS average_quantity
FROM retail_sales_dataset;
# Check Price per Unit
SELECT
    MIN(`Price per Unit`) AS minimum_price,
    MAX(`Price per Unit`) AS maximum_price,
    ROUND(AVG(`Price per Unit`), 2) AS average_price
FROM retail_sales_dataset;
# Total Sales Amount check.
SELECT
    MIN(`Total Amount`) AS minimum_total_amount,
    MAX(`Total Amount`) AS maximum_total_amount,
    ROUND(AVG(`Total Amount`), 2) AS average_total_amount,
    SUM(`Total Amount`) AS total_sales_amount
FROM retail_sales_dataset;
# Final Data Quality Check
SELECT *
FROM retail_sales_dataset
WHERE TRIM(`Date`) = ''
   OR TRIM(`Customer ID`) = ''
   OR TRIM(`Gender`) = ''
   OR TRIM(`Product Category`) = '';
   
# SQL Data Analysis
# 1. Find the total revenue.
SELECT
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset;
# 2 Total number of transactions.
SELECT
    COUNT(*) AS total_transactions
FROM retail_sales_dataset;
# 3 Average Transaction Amount
SELECT
    ROUND(AVG(`Total Amount`), 2) AS average_transaction_amount
FROM retail_sales_dataset;
# 4 total Quantity Sold
SELECT
    SUM(`Quantity`) AS total_quantity_sold
FROM retail_sales_dataset;
#  CATEGORY ANALYSIS
# 5. Revenue by Product Category
SELECT
    `Product Category`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_revenue DESC;
# 6. Quantity Sold by Product Category
SELECT
    `Product Category`,
    SUM(`Quantity`) AS total_quantity
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_quantity DESC;

# 7. Number of Transactions by Product Category
SELECT
    `Product Category`,
    COUNT(*) AS total_transactions
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_transactions DESC;

# 8. Average Sales Amount by Category
SELECT
    `Product Category`,
    ROUND(AVG(`Total Amount`), 2) AS average_sales
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY average_sales DESC;
# GENDER ANALYSIS
# 9. Revenue by Gender
SELECT
    `Gender`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Gender`
ORDER BY total_revenue DESC;

# 10. Transactions by Gender
SELECT
    `Gender`,
    COUNT(*) AS total_transactions
FROM retail_sales_dataset
GROUP BY `Gender`
ORDER BY total_transactions DESC;

# 11. Average Transaction Amount by Gender
SELECT
    `Gender`,
    ROUND(AVG(`Total Amount`), 2) AS average_transaction_amount
FROM retail_sales_dataset
GROUP BY `Gender`
ORDER BY average_transaction_amount DESC;
# AGE ANALYSIS
# 12. Revenue by Age
SELECT
    `Age`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Age`
ORDER BY total_revenue DESC;

# This tells us which individual age generated the highest revenue.

# 13. Transactions by Age
SELECT
    `Age`,
    COUNT(*) AS total_transactions
FROM retail_sales_dataset
GROUP BY `Age`
ORDER BY total_transactions DESC;
# 14. Create Age Groups
SELECT
    CASE
        WHEN `Age` BETWEEN 18 AND 25 THEN '18-25'
        WHEN `Age` BETWEEN 26 AND 35 THEN '26-35'
        WHEN `Age` BETWEEN 36 AND 45 THEN '36-45'
        WHEN `Age` BETWEEN 46 AND 55 THEN '46-55'
        WHEN `Age` BETWEEN 56 AND 64 THEN '56-64'
    END AS age_group,
    COUNT(*) AS total_transactions,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY age_group
ORDER BY total_revenue DESC;

# This is useful for identifying the highest-revenue age group.

# MONTHLY SALES ANALYSIS

# Because your Date column is text, use STR_TO_DATE().

# 15. Monthly Revenue
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS month,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;

# This gives monthly sales from January 2023 to December 2023.

# 16. Monthly Transactions
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS month,
    COUNT(*) AS total_transactions
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;
# 17. Monthly Quantity Sold
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS month,
    SUM(`Quantity`) AS total_quantity
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;
# 18. Highest Revenue Month
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS month,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;
# CUSTOMER ANALYSIS
# 19. Number of Unique Customers
SELECT
    COUNT(DISTINCT `Customer ID`) AS unique_customers
FROM retail_sales_dataset;

# 20. Revenue by Customer
SELECT
    `Customer ID`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Customer ID`
ORDER BY total_revenue DESC;

# 21. Top 10 Customers by Revenue
SELECT
    `Customer ID`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Customer ID`
ORDER BY total_revenue DESC
LIMIT 10;

# TOP TRANSACTIONS
# 22. Top 10 Transactions by Sales Amount
SELECT
    `Transaction ID`,
    `Customer ID`,
    `Product Category`,
    `Quantity`,
    `Price per Unit`,
    `Total Amount`
FROM retail_sales_dataset
ORDER BY `Total Amount` DESC
LIMIT 10;

# PRODUCT ANALYSIS

# Your dataset has Product Category, but does not have an individual Product Name column.

# So we should not create a "top product" analysis that the dataset cannot support.

# 23. Highest Selling Category by Quantity
SELECT
    `Product Category`,
    SUM(`Quantity`) AS total_quantity
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_quantity DESC
LIMIT 1;

# 24. Highest Revenue Category
SELECT
    `Product Category`,
    SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_revenue DESC
LIMIT 1;

# DATE ANALYSIS
# 25. Daily Revenue
SELECT
    STR_TO_DATE(`Date`, '%m/%d/%Y') AS sale_date,
    SUM(`Total Amount`) AS daily_revenue
FROM retail_sales_dataset
GROUP BY sale_date
ORDER BY sale_date;

# 26. Highest Revenue Day
SELECT
    STR_TO_DATE(`Date`, '%m/%d/%Y') AS sale_date,
    SUM(`Total Amount`) AS daily_revenue
FROM retail_sales_dataset
GROUP BY sale_date
ORDER BY daily_revenue DESC
LIMIT 1;
# SUMMARY KPI QUERY

# Finally, you can get the main KPIs together:

# 27. Retail Sales KPI Summary
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT `Customer ID`) AS unique_customers,
    SUM(`Quantity`) AS total_quantity_sold,
    SUM(`Total Amount`) AS total_revenue,
    ROUND(AVG(`Total Amount`), 2) AS average_transaction_amount,
    MIN(`Total Amount`) AS minimum_transaction,
    MAX(`Total Amount`) AS maximum_transaction
FROM retail_sales_dataset;
SELECT *
FROM retail_sales_dataset;





