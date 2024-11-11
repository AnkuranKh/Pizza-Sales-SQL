use pizzahut;
-- drop table orders;

-- select * from orders
-- limit 5;

-- alter table orders
-- modify date date;

-- alter table orders
-- modify time time;
-- select * from order_details;

-- alter table order_details
-- add constraint add_nkey
-- primary key(order_details_id);

-- select * from pizzas;

-- alter table orders
-- add constraint add_nky
-- primary key(order_id);

-- alter table order_details
-- add constraint add_nkey
-- foreign key(order_id)
-- references orders(order_id);

select* from orders;
select * from pizzas;
select * from pizza_types;
select * from order_details;


-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) as total_orders
FROM
    orders;


-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS total_revenue_generated
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id;
    
--     Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
select p.size, count(od.quantity) as quanity_ordered from pizzas p
JOIN order_details od on 
p.pizza_id=od.pizza_id
group by 1
order by 2 desc ;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name, COUNT(od.quantity) quantities_ordered
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
    
