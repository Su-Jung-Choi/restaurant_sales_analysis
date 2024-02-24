-- Pizza Place Sales Data Analysis
-- by Sujung Choi

-- before creating a view, drop the view if it exists already
drop view if exists OrderDetailsView;
-- create a view for orders and order_details
CREATE VIEW OrderDetailsView AS
SELECT orders.order_id,
       orders.date,
       orders.time,
       order_details.quantity,
       order_details.pizza_id
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id;

-- before creating a view, drop the view if it exists already
drop view if exists PizzaDetailsView;
-- Create a view for pizzas and pizza_types
CREATE VIEW PizzaDetailsView AS
SELECT pizzas.pizza_id,
       pizzas.pizza_type_id,
       pizzas.size,
       pizzas.price,
       pizza_types.name AS pizza_name,
       pizza_types.category,
       pizza_types.ingredients
FROM pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id;

-- before creating a view, drop the view if it exists already
drop view if exists JoinedOrderView;
-- join the views to create the JoinedOrderView view
CREATE VIEW JoinedOrderView AS
SELECT od.order_id,
       od.date,
       od.time,
       od.quantity,
       pd.pizza_id,
       pd.pizza_type_id,
       pd.size,
       pd.price,
       pd.pizza_name,
       pd.category,
       pd.ingredients
FROM OrderDetailsView od
JOIN PizzaDetailsView pd ON od.pizza_id = pd.pizza_id;

-- to look at the view with first 10 rows
SELECT *
FROM JoinedOrderView
ORDER BY date
LIMIT 5;

-- total number of orders per day
SELECT date, COUNT(DISTINCT order_id) AS num_orders
FROM JoinedOrderView
GROUP BY date
ORDER BY date;

-- Number of pizzas ordered per order to see how many pizzas customers tend to order at once
SELECT order_id, COUNT(*) AS num_pizzas_ordered
FROM JoinedOrderView
GROUP BY order_id
ORDER BY num_pizzas_ordered DESC;

-- find orders that included more than 5 pizzas
-- result: 5780 
-- these orders likely indicate the pizzas were ordered to serve larger groups or gatherings.
SELECT SUM(num_pizzas_ordered) AS total_pizzas_greater_than_5
FROM (SELECT order_id, COUNT(*) AS num_pizzas_ordered
	  FROM JoinedOrderView
      GROUP BY order_id
      HAVING COUNT(*) > 5) AS pizzas_per_order;

-- find orders that included less than or equal to 5 pizzas
-- result: 42840
-- the majority of orders fall into this category, suggesting that many customers are ordering for individuals or small groups of people.
-- (compared to the previous result)
-- I roughly assumed the threshold as 5 pizzas in this case to distinguish between larger and smaller orders.
SELECT SUM(num_pizzas_ordered) AS total_pizzas_less_or_equal_5
FROM (SELECT order_id, COUNT(*) AS num_pizzas_ordered
	  FROM JoinedOrderView
	  GROUP BY order_id
	  HAVING COUNT(*) <= 5) AS pizzas_per_order;

-- Average number of pizzas ordered across all orders
-- result: the average number of pizzas per order is about 2.28
SELECT AVG(num_pizzas_ordered) AS avg_pizzas_per_order
FROM (SELECT order_id, COUNT(*) AS num_pizzas_ordered
	  FROM JoinedOrderView
      GROUP BY order_id
	  ) AS pizzas_per_order;
      
-- to find peak hours
-- result: the peak hours are in the range of 12-13 (lunch time), followed by 17-18 (dinner time)
SELECT EXTRACT(hour FROM time) AS hour_of_day, COUNT(*) AS total_orders
FROM JoinedOrderView
GROUP BY hour_of_day
ORDER BY total_orders DESC;

-- total number of pizzas sold per date
SELECT date, COUNT(order_id) AS num_pizza_sold
FROM JoinedOrderView
GROUP BY date
ORDER BY date;

-- to find on which day of the week people buy pizzas the most
-- it is sold the most on Friday (8106), followed by Saturday (7355)
-- On Sunday, people buy the least number of pizzas (5917)
-- based on this information, the restaurant can consider running promotions, discounts, or special offers on Friday and Saturday
-- also, for the slower days like Sundays, the restaurant could consider offering loyalty bonuses to encourage customers for frequent purchases 
SELECT DATE_FORMAT(date, '%a') AS day_of_week, COUNT(*) AS num_pizzas_sold
FROM JoinedOrderView
GROUP BY day_of_week
ORDER BY num_pizzas_sold DESC;

-- find the bestseller pizza out of 32 different pizza types in terms of quantity (i.e., number of pizzas sold)
-- result: Classic Deluxe Pizza is the no. 1 (2416 pizzas were sold), followed by Barbecue Chicken Pizza (2372)
SELECT pizza_name, COUNT(pizza_name) AS num_pizza_sold
FROM JoinedOrderView
GROUP BY pizza_name
ORDER BY num_pizza_sold DESC
LIMIT 5;

-- find total sales and quantity sold for each pizza type
-- identify the most and least sold pizzas in terms of sales and quantity 
-- the most profitable pizza is Thai Chicken Pizza ($42332.25).
-- the least sold pizza in terms of both sales and quantity is Brie Carre Pizza (about $ 11352 and 490 pizzas) which is significantly lower than any other pizzas
-- therefore, if the restaurant consider to reduce the types of pizzas on the menu,
--  they may consider removing the Brie Carre Pizza.
SELECT pizza_name, SUM(price) AS total_sales, SUM(quantity) AS total_quantity
FROM JoinedOrderView
GROUP BY pizza_name
ORDER BY total_sales DESC;

-- what is the sales for this year 2015?
-- result: about $ 801944.70
SELECT EXTRACT(year FROM date) AS extracted_year, SUM(price) AS total_sales
FROM JoinedOrderView
GROUP BY extracted_year
ORDER BY extracted_year;

-- find monthly sales
-- result: July is the peak which has the highest sales, but in general, it is not significantly affected by the seasonality.
SELECT EXTRACT(month FROM date) AS extracted_month,
		SUM(price)*100 AS total_sales
FROM JoinedOrderView
GROUP BY extracted_month
ORDER BY extracted_month;

-- pizza sales per category to see which styles are more popular
-- result: customers buy Classic pizzas the most, and Chicken pizzas the least
SELECT category, COUNT(*) AS number_pizzas
FROM JoinedOrderView
GROUP BY category
ORDER BY number_pizzas DESC;

