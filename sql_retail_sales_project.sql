alter table `sql - retail sales analysis_utf` rename to sql_retail_sales ;
alter table sql_retail_sales rename column ï»¿transactions_id to transaction_id;

-- Data Cleaning checking null 
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    transaction_id IS NULL;

-- checking null for all the columns in single where query
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
    
-- 1.Nos of customers (result : 155)
SELECT 
    COUNT(DISTINCT customer_id) AS nos_customers
FROM
    sql_retail_sales;

-- 2.total sales (result : 1987)
SELECT 
    COUNT(total_sale) AS total_sales
FROM
    sql_retail_sales;

-- 3.Nos of categories 
SELECT 
    COUNT(DISTINCT category) AS nos_category
FROM
    sql_retail_sales;

-- 4.Customer Age
SELECT DISTINCT
    age
FROM
    sql_retail_sales;

-- 5.category types
SELECT DISTINCT
    category
FROM
    sql_retail_sales;

-- 6.sum of sales
SELECT 
    SUM(total_sale) AS total_sales
FROM
    sql_retail_sales;

# DATA ANAYSIS
-- 7.Category and customer id wise total sales
SELECT 
    category, customer_id, SUM(total_sale) AS total_sales
FROM
    sql_retail_sales
GROUP BY category , customer_id
ORDER BY total_sales DESC;

#Questions frm 1-10
-- Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than 4 in the month of Nov-2022
SELECT 
    *
FROM
    sql_retail_sales
WHERE
    category = 'Clothing' AND quantiy >= 4
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q3: Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(transaction_id) AS total_orders
FROM
    sql_retail_sales
GROUP BY category;

-- Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    category, ROUND(AVG(age), 2) AS avg_age
FROM
    sql_retail_sales
WHERE
    category = 'Beauty';

-- Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
    transaction_id, total_sale
FROM
    sql_retail_sales
WHERE
    total_sale > 1000
ORDER BY total_sale DESC;

-- Q6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category, gender, COUNT(transaction_id) AS nos_transactions
FROM
    sql_retail_sales
GROUP BY category , gender
ORDER BY 1;

-- Q7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale), 1) AS average_sales,
    RANK() OVER (PARTITION BY YEAR(sale_date) order by ROUND(AVG(total_sale), 1) DESC) As Ranking
FROM
    sql_retail_sales
GROUP BY year , month; 

-- Q8: Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    sql_retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS uniques_id
FROM
    sql_retail_sales
GROUP BY category;

-- Q10:Write a SQL query to create each shift and 
-- number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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


