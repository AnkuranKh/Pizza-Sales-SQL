
use pizzahut;
select * from pizzas;
select * from order_details;
select * from pizza_types;

-- calculate the percentage contribution of each pizza to total revenue

SELECT 
    pt.name,
    ROUND(SUM(p.price * od.quantity) / (SELECT 
                    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
                FROM
                    pizzas p
                        JOIN
                    order_details od ON p.pizza_id = od.pizza_id) * 100,
            2) AS percentage_contribution
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC;


-- Analyse the cumulative revenue generated over time
select * from orders;


select ov.order_date,
sum(ov.revenue) over (order by ov.order_date) as cum_revenue from               
(select date(o.order_date) as order_date,round(sum(od.quantity*p.price),2) as revenue from orders o
JOIN order_details od on o.order_id=od.order_id
JOIN pizzas p on od.pizza_id=p.pizza_id
group by 1 
order by 1) as ov;

-- determine the most ordered pizza types based on revenue for each pizza category



select category,name,revenue
from
(select category,name,revenue, 
rank() over(partition by category order by revenue desc) as rn        
from
(select pt.category,pt.name,sum(p.price*od.quantity) as revenue from pizza_types pt
JOIN pizzas p on pt.pizza_type_id=p.pizza_type_id
JOIN order_details od on p.pizza_id=od.pizza_id
group by 1,2) as p) as q
where rn<=3;





