select * from menu_items;
select * from order_details;


/*View the menu_items table and write a query to find the number of items on the menu*/
select count(*) as total_menu_items from menu_items;

/*What are the least and most expensive items on the menu?*/
/*What are the least and most expensive items on the menu?*/

WITH most_expensive AS (
    SELECT *, 'Most Expensive' AS price_category 
    FROM menu_items
    ORDER BY price DESC LIMIT 1
),
least_expensive AS (
    SELECT *, 'Least Expensive' AS price_category 
    FROM menu_items
    ORDER BY price LIMIT 1
)
SELECT * FROM most_expensive
UNION ALL
SELECT * FROM least_expensive;


/*How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?*/

select count(*) as total_italian_foods from menu_items 
where category = 'italian';

with italian_foods as (
select * from menu_items 
where category = 'italian'
),
most_expensive as (
	select *,'most_expensive' as price_category from italian_foods order by price desc limit 1
),
least_expensive as (
	select * ,'least_expensive' as price_category  from  italian_foods order by price limit 1
)

select * from most_expensive 
union all
select * from least_expensive;

/*How many dishes are in each category? What is the average dish price within each category?*/

select category,count(*) as total_dishes from menu_items group by category;

select category, AVG(price) as avg_dish_price
from menu_items
group by category;


/*View the order_details table. What is the date range of the table?*/
select min(order_date)as earliest_date, max(order_date) as latest_date 
from order_details;

/* How many items were ordered within this date range? cte version*/
with remove_dups as (
	select distinct order_id from order_details
),
	count_total_orders as (
		select count(order_id) as total from remove_dups
    )
    select * from count_total_orders;
    
/* How many items were ordered within this date range?*/
select count(distinct order_id) from order_details;


/*Which orders had the most number of items*/

select order_id, count(item_id) as total_items 
from order_details 
group by order_id order by total_items desc limit 1;

/*How many orders had more than 12 items?*/
select order_id, count(item_id) as total_items 
from order_details 
group by order_id
having total_items > 12;

/*Combine the menu_items and order_details tables into a single table*/
select * from order_details as od
left join menu_items as mi
on  od.item_id = mi.menu_item_id;

/*What were the least and most ordered items? What categories were they in?*/
select item_name,category, count(order_details) as num
from order_details as od
left join menu_items as mi
on  od.item_id = mi.menu_item_id;
