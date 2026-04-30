CREATE DATABASE superstore;
USE superstore;
SELECT * FROM superstore LIMIT 20;
DESCRIBE superstore;
SELECT COUNT(*) FROM superstore;

-- checking null values

SELECT * 
FROM superstore
WHERE Sales is NULL
OR Profit is NULL;

-- checking duplicates
SELECT `Order ID`, COUNT(*)
FROM superstore
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

-- Fix date format
UPDATE superstore
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

UPDATE superstore
SET `Ship Date`= STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

-- change datatype
ALTER TABLE superstore
MODIFY `Order Date` DATE,
MODIFY `Ship Date` DATE;

-- Extract Year
ALTER TABLE superstore ADD Order_Year INT;
UPDATE superstore
SET Order_Year = Year(`Order Date`);

-- Extract Month
ALTER TABLE superstore ADD Order_Month INT;
UPDATE superstore
SET Order_Month = Month(`Order Date`);

-- Profit Margin
ALTER TABLE superstore ADD Profit_Margin FLOAT;
UPDATE superstore
SET Profit_Margin = Profit / Sales;

-- Total sales and profit
SELECT 
ROUND(SUM(Sales),2) AS Total_Sales,
ROUND(SUM(Profit),2)AS Total_Profit
FROM superstore;

-- sales by category
SELECT
Category,
ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Category
ORDER BY Sales DESC;

-- profit by category
SELECT
Category,
ROUND(SUM(Profit),2) as Profit
FROM superstore
GROUP BY Category
ORDER BY Profit DESC;

-- sales by region
SELECT 
Region,
ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Region
ORDER BY Sales DESC;

-- top 10 products
SELECT 
`Product Name`,
ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY `Product Name`
ORDER BY Sales DESC
LIMIT 10;

-- Loss making products
SELECT
`Product Name`,
ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY `Product Name`
HAVING Profit < 0
ORDER BY Profit; 

-- Top customers
SELECT 
`Customer Name`,
ROUND(SUM(Sales),2) AS Total_Spent
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Spent DESC
LIMIT 10;

-- Monthly sales trend
SELECT
Order_Year,Order_Month,
ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;


-- Create views
-- Monthly sales
CREATE VIEW Monthly_Sales AS
SELECT 
Order_Year,
Order_Month,
ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

-- Category performance
CREATE VIEW Category_Performance AS 
SELECT 
Category,
ROUND(SUM(Sales),2) AS Sales,
ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY Category;

-- Top Customers
CREATE VIEW Top_Customers AS 
SELECT
`Customer Name`,
ROUND(SUM(Sales),2) AS Total_Spent
FROM superstore
GROUP BY `Customer Name`;












