# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**:Retail Sales Analysis

**Database**:'sql_retail_sales_project_db'

Retail Sales Analysis is a SQL project that demonstrates data cleaning, exploratory analysis, and business insights from retail transaction data. It involves setting up a database, querying sales patterns, customer demographics, and product performance to support decision-making.

## Objectives:
- **Data Cleaning**: Identify and remove null and duplicate values.
- **Exploratory Data Analysis**: Perform basic exploratory data analysis to understand dataset.
- **Business Analysis**: Using SQL to answer specific business questions and derive the insights.

## Project Structure
### Data Cleaning:
```sql
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    transaction_id IS NULL;
```

```sql
SELECT 
  *
FROM
    sql_retail_sales
WHERE
    transaction_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

```

### Data Exploration
1.**No of customers (result : 155)**:
```sql
SELECT 
    COUNT(DISTINCT customer_id) AS nos_customers
FROM
    sql_retail_sales;
```

2.**Total Sales (result : 1987)**:
```sql
SELECT 
    COUNT(total_sale) AS total_sales
FROM
    sql_retail_sales;
```

3.**No of categories**:
```sql
SELECT 
    COUNT(DISTINCT category) AS nos_category
FROM
    sql_retail_sales;
```

4.**Customer Age**:
```sql
SELECT DISTINCT
    age
FROM
    sql_retail_sales;
```

5.**Category Types**:
```sql
SELECT DISTINCT
    category
FROM
    sql_retail_sales;
```

6.**Sum of Sales**:
```sql
SELECT 
    SUM(total_sale) AS total_sales
FROM
    sql_retail_sales;
```

### Data Analysis
The following SQL Queries were developed to answer specific business question

1.**Write a SQL query to retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    sale_date = '2022-11-05';
```

2.**Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    category = 'Clothing' AND quantiy >= 4
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

3.**Write a SQL query to calculate the total sales (total_sale) for each category**:
```sql
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(transaction_id) AS total_orders
FROM
    sql_retail_sales
GROUP BY category;
```

4.**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**:
```sql
SELECT 
    category, ROUND(AVG(age), 2) AS avg_age
FROM
    sql_retail_sales
WHERE
    category = 'Beauty';

```

5.**Write a SQL query to find all transactions where the total_sale is greater than 1000**:
```sql
SELECT 
    transaction_id, total_sale
FROM
    sql_retail_sales
WHERE
    total_sale > 1000
ORDER BY total_sale DESC;
```

6.**Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**:
```sql
SELECT 
    category, gender, COUNT(transaction_id) AS nos_transactions
FROM
    sql_retail_sales
GROUP BY category , gender
ORDER BY 1;
```

7.**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale), 1) AS average_sales,
    RANK() OVER (PARTITION BY YEAR(sale_date) order by ROUND(AVG(total_sale), 1) DESC) As Ranking
FROM
    sql_retail_sales
GROUP BY year , month; 
```

8.**Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    sql_retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

9.**Write a SQL query to find the number of unique customers who purchased items from each category**:
```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS uniques_id
FROM
    sql_retail_sales
GROUP BY category;
```

10.**Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(sale_time) >= 17 THEN 'Evening'
    END AS Shift,
    COUNT(transaction_id) AS total_transactions
FROM
    sql_retail_sales
GROUP BY shift; 
```

## Finding
- **Customer Demographics**: Sales data covers a wide range of customer ages, concentrated in product categories such as Clothing and Beauty.
- **High-Value Transactions**: Transactions over 1000 in sales amount reveal significant premium spending.
- **Sales Trends**: Sales data by month exhibits changes, enabling identification of seasonal peaks.
- **Customer Insights**: Key findings highlight top customers by expenditure and the most favored product categories.


