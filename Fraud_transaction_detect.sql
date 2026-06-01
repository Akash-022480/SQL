create database  Fraud_transaction;
show databases;
use fraud_transaction;




show tables;
select * from transactions;

describe transactions;
alter table Transactions
modify column Transaction_date date;

update Transactions
set Transaction_date = str_to_date(Transaction_date,'%Y-%m-%d');

/* Q1. Total Transaction Count */
select count(*) as total_transaction from transactions;


/* Q2. Total Fraud Transactions */
select count(*) as Total_fraud
 from transactions where fraud_flag=1;
 
 
/* Q3. Total Genuine Transactions */
select count(*) as Total_genuine
 from transactions where fraud_flag=0;
 
 
/* Q4. Total Transaction Amount */
select round(sum(amount),2) as total_amount 
from transactions;


/* Q5. Average Transaction Amount */
select round(avg(amount)) as avg_amount
from transactions;

/* Q6. Highest Transaction Amount */
select max(amount) as Highest_amount from transactions;


/* Q7. Lowest Transaction Amount */
select min(amount) as Highest_amount from transactions;

/* Q8. Transactions above 1 lakh */
select amount from transactions where amount>100000;


/* Q9. Fraud Transactions above 50K */
select * from transactions where fraud_flag=1 and amount > 50000;


/* Q10. Distinct Payment Methods */
select distinct payment_method from transactions;


/* Q11. Fraud Rate Percentage */
select round(sum(fraud_flag)*100.0/ count(*),2)
as fraud_rate_percentage from transactions;


/* Q12. Fraud Count by Payment Method */
select payment_method, 
count(*) as fraud_count 
from transactions 
where fraud_flag = 1
group by payment_method;



/* Q13. Fraud Amount by City/Location */
select location, sum(amount) as fraud_location
from transactions
where fraud_flag = 1
group by location
order by fraud_location desc;


/* Q14. Top 10 Customers by Transaction Amount */
select customer_id, sum(amount) as total_spent
from transactions group by customer_id
order by total_spent desc limit 10;


/* Q15. Customers With Multiple Fraud Transactions */
select customer_id, count(*) as fraud_count
from transactions where fraud_flag = 1
group by customer_id having count(*)>3;


/* Q16. Daily Fraud Transactions */
select date(transaction_date) as trans_date,
count(*) as fraud_count
from transactions where fraud_flag=1
group by date(transaction_date)
order by trans_date;


/* Q17. Monthly Fraud Trend */
select month(transaction_date) as trans_month,
count(*) as fraud_count
from transactions where fraud_flag=1
group by month(transaction_date)
order by trans_month;


/* Q18. Fraud Transactions by Device Type  */
select device_type, count(*) as fraud_count
from transactions where fraud_flag=1
group by device_type;


/* Q19. Average Fraud Amount */
select round(avg(amount),2) as fraud_amount
from transactions
where fraud_flag=1;


/* Q20. Transactions Failed Due to Fraud */
select *from transactions
where fraud_flag=1 and status="Failed";


/* Q21. Top Fraudulent Merchants */
select merchant_name, count(*) as fraud_cases
from transactions where fraud_flag = 1
group by merchant_name
order by fraud_cases desc limit 10;


/* Q22. Fraud Amount VS Genuine Amount  */
select fraud_flag, sum(amount) as total
from transactions group by fraud_flag;


/* Q23. Customers Using Multiple Devices*/
select customer_id, 
count(distinct device_type) as device_count
from transactions
group by customer_id
having count(distinct device_type)>2;


/* Q24. Same IP Used by Multiple Customers */
select ip_address,
count(distinct customer_id) as customer_count
from transactions group by ip_address
having count(distinct customer_id)>3;


/* Q25. Top 5 Locations With Highest Fraud */
select location, count(*) as high_fraud
from transactions where fraud_flag=1
group by location
order by high_fraud desc limit 5;

/* Q26. Fraud Transactions During Night */
select *  from transactions
where hour(transaction_date) between 0 and 5
and fraud_flag=1;


/* Q27. Card Type Wise Fraud Analysis */
select card_type, count(*) as total_fraud
from transactions where fraud_flag=1
group by card_type
order by total_fraud desc;


/* Q28. Detect Sudden High Transations */
select * from transactions 
where amount > (select avg(amount)*3
from transactions);


/* Q29. Customers With Low Balance But High Transactions */
select * from transactions
where amount > account_balance;


/* Q30. Fraud Transactions by Weekday */
select dayname(transaction_date) as day_name,
count(*) as fraud_cases
from transactions where fraud_flag=1
group by dayname(transaction_date);


/* Q31. Running Total Of Transactions */
select transaction_id, customer_id, amount,
sum(amount) over(partition by customer_id order by transaction_date) as running_total
from transactions;


/* Q32. Rank Customers by Fraud Amount */
select customer_id, sum(amount) as fraud_amount,
rank() over(order by sum(amount) desc)
as fraud_rank
from transactions
where fraud_flag=1
group by customer_id;


/* Q33. Detect Consecutive Fraud Transaction*/
select customer_id, transaction_date,
fraud_flag, lag(fraud_flag) over(partition by customer_id order by transaction_date) as previous_flag
from transactions;


/* Q34. First Fraud Transaction Per Customer */
select customer_id, min(transaction_date) as first_fraud
from transactions where fraud_flag=1
group by customer_id;


/* Q35. Last Transaction Before Fraud */
select customer_id,
max(transaction_date) as last_transaction_date
from transactions
where fraud_flag=1
group  by customer_id;


/* Q36. Categorize Transactions Risk */
select transaction_id, amount, 
		case
			when amount>100000 then 'High Risk'
            when amount between 50000 and 100000 then 'Medium Risk'
            else 'Low Risk'
		end as risk_level
	from transactions;
    
    
/* Q37. Fraud Labeling */
select transaction_id,
		case 
			when fraud_flag = 1 then 'Fraud'
            else 'Genuine'
            end as transaction_status
	from transactions;
    
    
/* Q38. Customers Above Average Fraud Amount */
select customer_id, sum(amount) as total_fraud
from transactions where fraud_flag=1
group by customer_id
having sum(amount)> (select avg(amount) as avg_fraud
						from transactions
                        where fraud_flag=1);
                        
                        
/* Q39. Top Fraud Day */
select date(transaction_date) as fraud_day,
		count(*) as fraud_count
	from transactions
    where fraud_flag=1
    group by Date(transaction_date)
    order by fraud_count desc
    limit 1;
    
    
/* Q40. Find Duplicate Transactions */
select customer_id, amount, transaction_date,
	count(*) as duplicate_count
    from transactions
    group by customer_id, amount, transaction_date
    having count(*)>1;
    
    
/* Q41. Fraud Percentage by Merchant */
select merchant_name, round(sum(fraud_flag)*100.0/ count(*),2)
				as fraud_percentage
                from transactions
                group by merchant_name
                order by fraud_percentage desc;
				
/* Q42. Hourly Fraud Trend */
select hour(transaction_date) as Hour_no,
		count(*) as fraud_cases
        from transactions
        where fraud_flag=1
        group by hour(transaction_date)
        order by hour_no;
        
        
/* Q43. Customers With Transactions in Multiple Cities Same Day */
select customer_id, 
		date(transaction_date) as Trans_day,
        count(distinct location) as city_count
	from transactions
    group by customer_id, date(transaction_date)
    having count(distinct location)>1;
    
    
/* Q44. Fraud Detection By Payment Method and Devices */
select payment_method,
		device_type,
        count(*) as fraud_cases
	from transactions
    where fraud_flag=1
    group by payment_method, device_type;
    
    
/* Q45. Average Time Between Transactions */
select customer_id, avg(timestampdiff(
							minute, 
                            LAG(transaction_date) over(partition by customer_id
																order by transaction_date),
						transactions_date)) as avgerage_minute_gap
                        from transactions
                        group by customer_id;
                        
                        
/* Q46. Detect Brust Transactions */
select customer_id,
		count(*) as transaction_count
        from transactions 
        where transaction_date >= now() - interval 1 hour
        group by customer_id
        having count(*) >10;
        
        
/* Q47. Fraud to Genuine Ratio */
select 
	(select count(*) from transactions 
    where fraud_flag=1)/(select count(*)
    from transactions where fraud_flag=0)
    as fraud_genuine_ratio;
    
    
/* Q48. High Frequency Small Amount Fraud */
select customer_id,
		count(*) as small_transactions
        from transactions
        where fraud_flag=1 and
        amount < 100
        group by customer_id
        having count(*) > 20;
        
        
/* Q49. Most Common Fraud Amounts */
select amount, count(*) as frequency
		from transactions
        where fraud_flag=1
        group by amount
        order by frequency desc limit 10;
        
        
/* Q50. Complete Fraud Summary Dashboard Query */
select count(*) as total_transactions,
		sum(case when fraud_flag=1  then 1 else 0 end) as fraud_transactions,
        sum(case when fraud_flag=0 then 1 else 0  end) as genuine_transactions,
        round(
				sum(fraud_flag) * 100.0 / count(*),2)
                as fraud_percentage,
                sum(amount) as total_amount,
                avg(amount) as average_transaction_amount
		from transactions;



