Create database if Not exists Pizzas ;
use Pizzas ;

-- >>GOTO DATABASE NAME >> RIGHT CLICK >> SELECT TABLE DATA IMPORT WIZARD(5TH OPTION)
-- >> BROWSE AND SELECT FILE >> START UPLOADING AS PER INSTRUCTIONS

SELECT * FROM PIZZA_TYPES;
SELECT * FROM PIZZAS;
SELECT * FROM ORDER_DETAILS;
SELECT * FROM ORDERS;

-- Basic:
-- 1. Retrieve the total number of orders placed.
Select distinct count(order_id) as Totals_orders from ORDERS;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT concat("$ " ,(round(sum(OD.QUANTITY * P.PRICE),2))) AS TOTAL_REVENUE 
FROM ORDER_DETAILS OD
JOIN PIZZAS P ON OD.PIZZA_ID = P.PIZZA_ID;

-- 3. Identify the highest-priced pizza.
select Pt.name , p.price from PIZZAS p 
join PIZZA_TYPES pt on p.pizza_type_id = pt.pizza_type_id 
order by p.price desc
limit 1 ;
-- 4. Identify the most common pizza size ordered.
Select p.size , count(od.quantity) as total from ORDER_DETAILS od
join PIZZAS p on p.pizza_id = od.pizza_id group by size order by total desc limit 1 ;

-- 5. List the top 5 most ordered pizza types along with their quantities.
select pt.name, sum(od.quantity) as total_quantity from  ORDER_DETAILS od 
join pizzas p on od.pizza_id = p.pizza_id 
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id 
group by pt.name
order by total_quantity  desc 
limit 5 ;

-- Intermediate:
-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category , sum(od.quantity) AS TOTAL_COUNT from ORDER_DETAILS od  
join pizzas p on od.pizza_id = p.pizza_id 
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id 
group by pt.category
ORDER BY TOTAL_COUNT desc ;

-- 7. Determine the distribution of orders by hour of the day.

-- in order case 
SELECT HOUR(time) AS order_hour,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- in qantity case
select hour(time) as order_hour , sum(od.quantity) from ORDER_DETAILS od 
join orders o on od.order_id = o.order_id 
group by order_hour 
order by order_hour ;

-- 8. Join relevant tables to find the category-wise distribution of pizzas.
SELECT pt.category,
COUNT(p.pizza_id) AS total_pizzas
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;


-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

with avg_pizzas_orderd as (
Select o.date, sum(od.quantity)as sum_pizzas from ORDER_DETAILS od
join orders o on od.order_id = o.order_id 
group by o.date)
select avg(sum_pizzas) as avg_per_day from avg_pizzas_orderd ;

-- 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(od.quantity * p.price) AS totoal_revenue
FROM
    ORDER_DETAILS od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY totoal_revenue DESC
LIMIT 3;

-- Advanced:
-- 11. Calculate the percentage contribution of each pizza type c

WITH percentage_contribution_cte AS (
    SELECT pt.name AS name1,
           SUM(od.quantity * p.price) AS total_revenue_each_pizzas
    FROM order_details od 
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id 
    JOIN pizza_types pt 
        ON p.pizza_type_id = pt.pizza_type_id 
    GROUP BY pt.name
)
SELECT name1,
       total_revenue_each_pizzas,
       (total_revenue_each_pizzas * 100.0 /
        (SELECT SUM(total_revenue_each_pizzas) 
         FROM percentage_contribution_cte)
       ) AS percentage_contribution
FROM percentage_contribution_cte
ORDER BY percentage_contribution DESC;

-- 12. Analyze the cumulative revenue generated over time.

Select ord.date, sum(p.price *od.quantity) as daily_revenue ,
SUM(SUM(p.price *od.quantity)) OVER (ORDER BY ord.date) AS cumulative_revenue
from pizzas p
join order_details od on p.pizza_id = od.pizza_id 
join orders ord on od.order_id =ord.order_id 
group by ord.date
order by ord.date ;

-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT category, name, revenue
FROM (
    SELECT 
        pt.category,
        pt.name,
        SUM(od.quantity * p.price) AS revenue,
        RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rnk
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name 
) t
WHERE rnk <= 3;

-- 14 Determine the top 5 days with the highest revenue
Select  ord.date , round(sum(quantity * Price),2) as revenue from pizzas p 
join order_details od on p.pizza_id = od.pizza_id 
join orders ord on od.order_id = ord.order_id 
group by ord.date
order by revenue desc 
limit 5 ;

-- 15 Find the busiest day of the week based on number of orders
SELECT 
DAYNAME(date) AS day_name,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_name
ORDER BY total_orders DESC;

-- 16 Rank pizzas based on total quantity sold
SELECT 
pt.name,
SUM(od.quantity) AS total_quantity,
RANK() OVER (ORDER BY SUM(od.quantity) DESC) AS pizza_rank
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;

-- 17 Calculate revenue growth compared to previous day
select emp_id, emp_name, dept, month, sales,
lag(sales) over(
partition by emp_id
order by month desc
)as previous_sales
from emp;

Select ord.date , round(sum(od.quantity * p.Price),2) as revenue ,
lag(round(sum(od.quantity * p.price),2)) over(
order by ord.date)as previous_sales
from pizzas p join 
order_details od on p.pizza_id = od.pizza_id 
join orders ord on od.order_id = ord.order_id 
group by ord.date;






