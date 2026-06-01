create database Zomato;
show databases;
use Zomato;
show tables;

select * from food;

describe food;




-- Q1. Total Orders
select count(*) as Total_orders from food;


-- Q2. Total Customers
select count(distinct customer_id) as Total_customers
		from food;
        
        
-- Q3. List all Cities
select distinct City from food;


-- Q4. Total Revenue
select sum(order_amount) as Total_revenue from food;


-- Q5. Average Order value
select avg(order_amount) as average_amount from food;


-- Q6. Highest Order Amount
select max(order_amount) as Highest_amount from food;


-- Q7. Lowest Order Amount
select min(order_amount) as Lowest_amount from food;


-- Q8. Total Orders By City
select city, count(*) as Total_orders from food
group by city;


-- Q91. Total Orders By Food Type
select food_type, count(*) as Total_orders from food
group by food_type;


-- Q10. Total Revenue By City
select city, sum(order_amount) as Total_revenue
from food group by city
order by Total_revenue desc;

-- Q11. Average Delivery Time
select avg(delivery_time_minutes) as average_time
from food;


-- Q12. Average Customer Rating
select avg(customer_rating) as average_customer_rating
from food;


-- Q13. Count orders by payment method
select payment_method, count(*) as Total_orders
from food
group by payment_method;


-- Q14. Delivered Orders Count
select count(*) as Total_delivered_orders
from food where delivery_status='Delivered';


-- Q15. Cancelled Orders Count
select count(*) as Total_cancel_orders
from food where delivery_status='Cancelled';


-- Q16. Top 5 Resturants By Revenue
select restaurant_name, sum(order_amount) as total_revenue
from food group by restaurant_name
order by total_revenue desc limit 10;


-- Q17. Top 5 Customers By Spending
select customer_id, sum(order_amount) as total_spent
from food
group by customer_id
order by total_spent desc limit 5;


-- Q18. Resturant Wise Average Rating
select restaurant_name, avg(customer_rating) as average_rating
from food
group by restaurant_name order by average_rating desc;


-- Q19. City With Highest Revenue
select city, sum(order_amount) as high_amount
from food
group by city
order by high_amount desc;


-- Q20. Most Popular Food Type
select food_type, count(*) as Total_orders
from food
group by food_type
order by total_orders desc;


-- Q21. Average Order Value By City
select city, avg(order_amount) as average_order_value
from food group by city
order by average_order_value desc;


-- Q22. Orders With Delivery Time Above Average
select *
from food where delivery_time_minutes>(
					select avg(delivery_time_minutes) as average_delivery_time
                    from food);
                    
                    
-- Q23. Revenue By Payment Method
select payment_method, sum(order_amount) as revenue
from food
group by payment_method
order by revenue desc;


-- Q24. Daily Orders
select order_date, count(*) as total_orders
from food group by order_date
order by order_date asc;


-- Q25. Daily Revenue
select order_date, 
     sum(order_amount) as revenue
     from food group by order_date
     order by order_date asc;
     
     
-- Q26. Delivery Success Rate
select round(count(
					case when delivery_status ='delivered' then 1 end)*100.0/
					count(*),2)
					as delivery_success_rate
			from food;
            
            
-- Q27. Average Delivery Time By City
select city, avg(delivery_time_minutes) as average_delivery
from food
group by city;


-- Q28. Resturant With Maximum Orders
select restaurant_name, count(*) as total_orders
from food 
group by restaurant_name 
order by total_orders desc;


-- Q29. Revenue By Food Type
select food_type, sum(order_amount) as revenue
from food
group by food_type;


-- Q30. Customers With More Than 5 Orders
select customer_id, count(*) as Total_orders
from food
group by customer_id
having count(*) > 5;


-- Q31. Top Rated Resturants
select restaurant_name, avg(customer_rating) as total_rating
from food
group by restaurant_name
order by total_rating desc;


-- Q32. Revenue From Delivered Orders
select delivery_status, sum(order_amount) as revenue
			from food
            where delivery_status = 'Delivered';
            
            
-- Q33. Average Order Value By Food Type
select food_type, 	
		avg(order_amount) as Average_order_value
        from food group by food_type;
        
        
-- Q34. Orders Per Month
select month(order_date) as month_no, count(*) as total_orders
		from food
        group by month_no
        order by month(total_orders) desc;
        
        
-- Q35. Monthly Revenue
select month(order_date) as month_no,
		sum(order_amount) as revenue
        from food
        group by month_no
        order by revenue desc;
        
        
-- Q36. Rank Resturants By Revenue
select restaurant_name, sum(order_amount) as revenue,
		rank() over(order by sum(order_amount) desc) as revenue_rank
        from food
        group by restaurant_name;
        
        
-- Q37. Running Revenue
select order_date, sum(order_amount) as revenue,
					sum(sum(order_amount))
                    over(order by order_date) as running_revenue
                    from food
			group by order_date;
            
            
-- Q38. Top 3 Resturants In Each City
select * from (
		select city, restaurant_name, sum(order_amount) as revenue,
        dense_rank() over(partition by city
						order by sum(order_amount) desc) as rnk
		from food
        group by city, restaurant_name) t 
				where rnk<=3;
                
                
-- Q39. Customer Lifetime Value (CLV)
select customer_id,
		sum(order_amount) as liftime_value
        from food
        group by customer_id;
        
        
-- Q40. Repeated Customers
select customer_id from food
group by customer_id
having count(*)>1;


-- Q41. Revenue Contibution %
select restaurant_name,
		round(sum(order_amount)*100/
        (select sum(order_amount) from food),2)
        as contribution_percent
	from food
    group by restaurant_name;
    
    
-- Q42. Highest Revenue Resturants Per City
with cte as
(select city, restaurant_name,
		sum(order_amount) as revenue,
        rank() over( partition by city
        order by sum(order_amount) desc) as rnk
	from food
    group by city, restaurant_name)
    select * from cte where rnk=1;
    
    
-- Q43. Month Over Month Revenue Growth
with Monthly_revenue as 
( select month(order_date) as month_no,
	sum(order_amount) as revenue
    from food
    group by month(order_date))
select month_no, revenue, 
		lag(revenue) over (order by month_no) as prev_month,
						revenue - 
					lag(revenue) over(order by month_no) as growth
		from monthly_revenue;
        
        
-- Q44. Fastes Delivering Resturants
select restaurant_name, 
		avg(delivery_time_minutes) as avgerage_time
        from food
        group by restaurant_name
        order by avgerage_time  limit 1;
        
        
-- Q45. Slowest Delivering Resturants
select restaurant_name, 
		avg(delivery_time_minutes) as avgerage_time
        from food
        group by restaurant_name
        order by avgerage_time desc limit 1;
        
        
-- Q46. Revenue Lost Due to Cancellations
select sum(order_amount) as lost_revenue
from food
where delivery_status = 'cancelled';


-- Q47. Rating VS Delivery Time Analysis
select
	case
		when delivery_time_minutes <= 30 then 'Fast'
        when delivery_time_minutes <=45 then 'medium'
        else 'Slow'
        end as delivery_speed,
        avg(customer_rating) as average_rating
        from food
        group by delivery_speed;
        
        
-- Q48. Top Food Type In Each City
with cte as
(
select city, food_type,
		count(*) as total_orders,
        rank() over(partition by city order by count(*) desc) as rnk
        from food
        group by city, food_type)
	select * from cte where rnk=1;
    
    
-- Q49. Customer Retention Analysis
select customer_id, count(*) as total_orders,
min(order_date) as first_order,
max(order_date) as last_order
from food
group by customer_id;


-- Q50. Pareto Analysis (Top 20% Customers Revenue)
with customer_sales as 
(
select customer_id, sum(order_amount) as revenue
from food
group by customer_id)
select * from customer_sales
order by revenue desc;