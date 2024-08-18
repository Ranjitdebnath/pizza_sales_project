-- 1) Retrieve the total number of orders placed.

select count(order_id) as total_orders from orders;


-- 2) Calculate the total revenue generated from pizza sales.

select round(sum(order_details.quantity * pizzas.price) ,2) as total_sales from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id;

-- 3) Identify the highest-priced pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- 4) Identify the most common pizza size ordered.

SELECT 
    pizzas.size, COUNT(order_details.quantity) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;	


-- 4) List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name ,sum(order_details.quantity) as quantity from pizza_types 
join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on pizzas.pizza_id=order_details.pizza_id
group by pizza_types.name
order by quantity DESC LIMIT 5;


