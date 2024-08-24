-- 1) Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;


-- 2) Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


-- 3) Identify the highest-priced pizza and its price

SELECT pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- 4) Identify the most common pizza size ordered.

SELECT pizzas.size, COUNT(order_details.quantity) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;	


-- 5) List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- 6) Find the total quantity of each pizza category ordered

SELECT pizza_types.category,SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;



-- 7) Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(orders.order_time) AS hours,
    COUNT(orders.order_id) order_count
FROM
    orders
GROUP BY hours;



-- 8) Find the category-wise distribution of pizzas

SELECT 
    category, COUNT(name) AS No_of_pizzas
FROM
    pizza_types
GROUP BY category;



-- 9) Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity), 0) AS Average_pizzas_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;



-- 10) Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_revenue DESC
LIMIT 3;

