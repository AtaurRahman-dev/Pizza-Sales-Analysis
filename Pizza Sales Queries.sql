USE [Pizza DB]

SELECT *
FROM pizza_sales

-- 1. Total Revenue

SELECT CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales

-- 2. Average Order Value

SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Average_Order_Value
FROM pizza_sales 

-- 3. Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales

-- 4. Total Numbers of Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

-- 5. Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Average_Pizzas_Per_Order
FROM pizza_sales

-- Daily Trends for Total Orders

SELECT DATENAME(DW, order_date) as Order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trends for Orders

SELECT DATEPART(HOUR, order_time) as Order_hours, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Order_hours

-- % of Sales by Pizza Category

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

-- Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- Top 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity_Sold DESC

-- Bottom 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity_Sold ASC