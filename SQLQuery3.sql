Create database Sql_project_2 
Use Sql_project_2
Select * From Retail_sales

---Clean Data

Select * From Retail_sales
Where transactions_id is Null
or
Sale_date is Null
or
 Sale_time is Null
or
 Customer_id is Null
or
 gender is Null
or
 age is Null
or
 category is Null
or
 quantity is Null
or
 Price_per_unit is Null
or
 cogs is Null
or
 total_sale is Null

 delete From Retail_sales
Where transactions_id is Null
or
Sale_date is Null
or
 Sale_time is Null
or
 Customer_id is Null
or
 gender is Null
or
 age is Null
or
 category is Null
or
 quantity is Null
or
 Price_per_unit is Null
or
 cogs is Null
or
 total_sale is Null

 Select * From Retail_sales

 ----Data Exploratin
 --1) How many sales we have?
 Select Count(*) As Total_sale From Retail_sales ----1987


 --1) How many Unique Customer we have? 

 Select Count(Distinct Customer_id) From Retail_sales------155

 ---Data Analysis & Business key problem & Answer

 -- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT Total_Sale, Sale_Date
FROM Retail_Sales
WHERE Sale_Date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01'
  AND Quantity >= 3;

 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT
    Category,
    SUM(Total_Sale) AS Category_Sale
FROM Retail_Sales
GROUP BY Category
ORDER BY Category_Sale DESC;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select 
      Avg(Age) as AVG_AGE
From Retail_sales
Where
     Category = 'Beauty'------40

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000
Select * From Retail_sales
Where Total_sale >= 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
    Category,
    Gender,
    count(Transactions_ID) AS Total_Tran
FROM Retail_Sales
GROUP BY
    Category,
    Gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
    Sale_Year,
    Sale_Month,
    Average_Sale
FROM
(
    SELECT
        YEAR(Sale_Date) AS Sale_Year,
        MONTH(Sale_Date) AS Sale_Month,
        AVG(Total_Sale) AS Average_Sale,
        RANK() OVER
        (
            PARTITION BY YEAR(Sale_Date)
            ORDER BY AVG(Total_Sale) DESC
        ) AS Sale_Rank
    FROM Retail_Sales
    GROUP BY
        YEAR(Sale_Date),
        MONTH(Sale_Date)
) AS Monthly_Sales
WHERE Sale_Rank = 1
ORDER BY Sale_Year;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
Select top 5 Customer_id,
       SUM(Total_sale) as Total_Sales
from Retail_sales
Group by Customer_id
order by total_sales desc

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
      category,
      Count(Distinct customer_id)
From Retail_sales
Group by Category
Select * From Retail_sales
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
    Shift,
    COUNT(Transactions_ID) AS No_Orders
FROM
(
    SELECT
        Transactions_ID,
        CASE
            WHEN DATEPART(HOUR, Sale_Time) < 12
                THEN 'Morning'
            WHEN DATEPART(HOUR, Sale_Time) BETWEEN 12 AND 17
                THEN 'Afternoon'
            ELSE 'Evening'
        END AS Shift
    FROM Retail_Sales
) AS B
GROUP BY
    Shift;

