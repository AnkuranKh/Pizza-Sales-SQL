use pizzahut;
select * from pizzas;
select * from pizza_types;
select * from order_details;
select * from orders;
-- alter table orders 
-- change column date order_date date;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category AS category,
    COUNT(od.quantity) AS total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of orders by hour of the day

select hour(orders.time) as hours,count(order_id) as orders from orders
group by 1
order by 2 desc;

-- category-wise distribution of pizzas
SELECT 
    pt.category, COUNT(pt.pizza_type_id) AS count_of_pizzas
FROM
    pizza_types pt
GROUP BY 1
ORDER BY 2 DESC;


-- group the orders by date and calculate average number of pizzas per day

SELECT 
    ROUND(AVG(q.total_quantity), 2) AS average_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS total_quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 1
    ORDER BY 2 DESC) AS q;
    
-- top 3 most ordered pizzas based on revenue

SELECT 
    pt.name, SUM(p.price * od.quantity) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3


