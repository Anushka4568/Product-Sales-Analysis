/*
==============================================================

                PRODUCT SALES ANALYSIS

Objective:
Analyze the Global Superstore dataset to identify sales,
profitability, customer behaviour and regional performance
using PostgreSQL.

Dataset:
Global Superstore Dataset

Tools Used:
- Microsoft Excel
- PostgreSQL
- Power BI

Author:
Anushka Jaiswal

==============================================================
*/

-- ==========================================================
-- QUESTION 1
-- What is the company's total revenue?
-- ==========================================================

SELECT
    SUM(sales) AS total_sales
FROM superstore;

-- Result:
-- The company generated a total revenue of 12,642,905.

-- ==========================================================
-- QUESTION 2
-- What is the company's total profit?
-- ==========================================================

SELECT
SUM(profit) AS total_profit
FROM superstore;

-- Result:
-- The company earned a total profit of 1,469,034.09.

-- ==========================================================
-- QUESTION 3
-- How many unique orders were placed?
-- ==========================================================

SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

-- Result:
-- A total of 25,035 unique orders were placed.

-- ==========================================================
-- QUESTION 4
-- What is the average order value?
-- ==========================================================

SELECT
    ROUND(AVG(sales),2) AS average_order_value
FROM superstore;

-- Result:
-- The average order value was 246.50. 

-- ==========================================================
-- QUESTION 5
-- Which product category generates the highest sales?
-- ==========================================================

SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Result:
-- Technology generated the highest sales, followed by Furniture and Office Supplies

-- ==========================================================
-- QUESTION 6
-- Which product category generates the highest profit?
-- ==========================================================

SELECT
    category,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- Result:
-- Technology was the most profitable category, followed by Office Supplies and Furniture.

-- ==========================================================
-- QUESTION 7
-- Which sub-category is the most profitable?
-- ==========================================================

SELECT
    sub_category,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- Result:
-- Copiers was the most profitable sub-category.

-- ==========================================================
-- QUESTION 8
-- Which sub-category is the least profitable?
-- ==========================================================

SELECT
    sub_category,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit ASC;

-- Result:
-- Tables was the least profitable sub-category.

-- ==========================================================
-- QUESTION 9
-- Which market generates the highest sales?
-- ==========================================================

SELECT
    market,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY market
ORDER BY total_sales DESC;

-- Result:
-- The APAC market generated the highest total sales.

-- ==========================================================
-- QUESTION 10
-- Which region generates the highest profit?
-- ==========================================================

SELECT
    region,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

-- Result:
-- The Central region generated the highest total profit.

-- ==========================================================
-- QUESTION 11
-- Which country generates the highest sales?
-- ==========================================================

SELECT
    country,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY country
ORDER BY total_sales DESC
LIMIT 10;

-- Result:
-- The United States generated the highest total sales among all countries.


-- ==========================================================
-- QUESTION 12
-- Who are the Top 10 customers by sales?
-- ==========================================================

SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Result:
-- The top 10 customers by sales were:
-- Tom Ashbrook
-- Tamara Chand
-- Greg Tran
-- Christopher Conant
-- Sean Miller
-- Bart Watters
-- Natalie Fritzler
-- Fred Hopkins
-- Jane Waco
-- Hunter Lopez

-- ==========================================================
-- QUESTION 13
-- Who are the Top 10 customers by profit?
-- ==========================================================

SELECT
    customer_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Result:
-- The top 10 customers by profit were:
-- Tamara Chand
-- Raymond Buch
-- Sanjit Chand
-- Hunter Lopez
-- Bill Eplett
-- Harry Marie
-- Susan Pistek
-- Mike Gockenbach
-- Adrian Barton
-- Tom Ashbrook

-- ==========================================================
-- QUESTION 14
-- Which products are sold the most?
-- ==========================================================

SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold
FROM superstore
GROUP BY product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Result:
--Staples was the highest-selling product based on total quantity sold.

-- ==========================================================
-- QUESTION 15
-- Does offering higher discounts reduce profit?
-- ==========================================================


SELECT
    product_name,
    discount,
    ROUND(AVG(profit),2) AS average_profit
FROM superstore
GROUP BY product_name, discount
ORDER BY discount DESC, average_profit ASC;

-- Result:
-- Products with higher discounts generally showed lower average profits.
-- However, the relationship was not consistent across every product, indicating
-- that factors such as sales volume, product type, and shipping cost also influence profitability.

-- ==========================================================
-- QUESTION 16
-- How have sales and profit trended year over year?
-- ==========================================================

SELECT
    year,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY year
ORDER BY year ASC;
-- Result:
-- Sales nearly doubled from 2.2M in 2011 to 4.3M in 2014, with profit growing
-- consistently in parallel, indicating healthy and sustainable business growth
-- over the four year period.

-- ==========================================================
-- QUESTION 17
-- What is the profit margin by category?
-- ==========================================================

SELECT
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY profit_margin_pct DESC;

-- Result:
-- Despite being the second highest revenue generating category, Furniture has a
-- profit margin of only 6.98%, less than half of Technology and Office Supplies,
-- suggesting significant inefficiency likely driven by heavy discounting or high
-- shipping costs on bulky items.


-- ==========================================================
-- QUESTION 18
-- Which sub-categories have high sales but negative profit?
-- ==========================================================

SELECT
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_sales DESC;

-- Result:
-- Tables is the only sub-category generating negative profit despite 757K in
-- sales, representing a critical loss making segment that requires immediate
-- pricing or discount strategy review.