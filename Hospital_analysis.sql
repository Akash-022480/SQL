show databases;
use hospital;

select * from hsm;
describe hsm;



-- Q1. Show all records
select * from hsm;


-- Q2. Show patient names only
select patient_name from hsm;


-- Q3. Show unique departments
select distinct department from hsm;

-- Q4. Find all male patients
select * from hsm where gender = "male";


-- Q5. Find all female patients
select * from hsm where gender = "female";


-- Q6. Find patients older than 50
select * from hsm where age>50;


-- Q7. Find patients from Delhi
select * from hsm where city = 'Delhi';

-- Q8. Sort patients by age ascending
select * from hsm order by age asc;

-- Q9. Sort patients by treatment cost descending
select * from hsm order by treatment_cost desc;


-- Q10. Show top 5 expensive treatments
select * from hsm order by treatment_cost desc limit 5;


-- Q11. Find total number of patients
select count(*) as total_patients from hsm;


-- Q12. Find average treatment cost
select avg(treatment_cost) as average_treatment_cost from hsm;


-- Q13. Find maximum treatment cost
select max(treatment_cost) as maximum_treatment_cost from hsm;


-- Q14. Find minimum treatment cost
select min(treatment_cost) as minimum_treatment_cost from hsm;


-- Q15. Find patients admitted after 2026-01-01
select * from hsm where admission_date>"2026-01-01";

-- Q16. Find patients discharged before 2026-03-01
select * from hsm where discharge_date>"2026-03-01";


-- Q17. Find patients whose name starts with A
select * from hsm where patient_name like "A%";

-- Q18. Find diagnosis containing Heart
select * from hsm where diagnosis like "%Heart%";


-- Q19. Count patients department-wise
select department, count(patient_name) as total_patients from hsm
group by department;


-- Q20. Find total treatment cost city-wise
select city, sum(treatment_cost) as Total_amount
from hsm group by city order by Total_amount desc;


-- Q21. Find average age department-wise
select avg(age) as average_age, department from hsm
group by department order by average_age desc;


-- Q22. Find payment mode-wise patient count
select count(*) as total_patients, payment_mode	
from hsm group by payment_mode;


-- Q23. Find highest treatment cost in Cardiology
select max(treatment_cost) as maximum_treatment
from hsm where department = "Cardiology";


-- Q24. Find patients admitted between two dates
select * from hsm
where admission_date between "2026-01-01" and "2026-03-01";


-- Q25. Find patients with treatment cost greater than average cost
select *
from hsm where treatment_cost > (select avg(treatment_cost) as average_treatment 
from hsm);


-- Q26. Find total patients city-wise
select count(Patient_id) as Total_patients, city from hsm
group by city;


-- Q27. Find patients whose room number is between 100 and 200
select * from hsm
where room_number between 100 and 200;


-- Q28. Find departments having more than 5 patients
select count(*) as total_patients, department from hsm
group by department having count(*)>5;


-- Q29. Find doctors handling more than 3 patients
select doctor_name, count(*) as total_patients
from hsm group by doctor_name having count(*)>3;


-- Q30. Show second highest treatment cost
select * from hsm
order by treatment_cost desc
limit 1 offset 1;


-- Q31. Show third highest treatment cost
select * from hsm
order by treatment_cost desc
limit 1 offset 2;


-- Q32. Find duplicate patient names
select patient_name, count(*) from hsm
group by patient_name having count(*)>1;


-- Q33. Find patients admitted in January
select * from hsm
where month(admission_date)=1;


-- Q34. Find patients discharged in February
select * from hsm
where month(discharge_date)=2;


-- Q35. Find length of hospital stay
select patient_name,
datediff(discharge_date,admission_date) as stay_days
 from hsm;
 
 
-- Q36. Find top 3 cities by patient count
select city, count(patient_name) as total_patients
from hsm
group by city
order by total_patients desc limit 3;


-- Q37. Find top 5 doctors by treatment revenue
select doctor_name, sum(treatment_cost) as total_revenue
from hsm
group by doctor_name
order by total_revenue desc limit 5;


-- Q38. Find average treatment cost by gender
select gender, avg(treatment_cost) as average_cost
from hsm
group by gender order by average_cost desc;


-- Q39. Find patient count for each diagnosis
select diagnosis, count(*) as total from hsm
group by diagnosis;


-- Q40. Find oldest patient
select * from hsm
order by age desc limit 1;


-- Q41. Find youngest patient
select * from hsm
order by age asc limit 1;


-- Q42. Find patients whose treatment cost is in top 10
select * from hsm
order by treatment_cost desc limit 10;


-- Q43. Find city having maximum treatment revenue
select city, sum(treatment_cost) as revenue
from hsm group by city order by revenue desc limit 1;


-- Q44. Find average stay days
select patient_name, 
avg(datediff(discharge_date,admission_date)) as avg_stay_day
 from hsm
 group by patient_name;
 
 
-- Q45. Find patients paying through UPI
select payment_mode, count(*) as total from hsm
where payment_mode="UPI"
group by payment_mode;


-- Q46. Find departments where average treatment cost is above 50000
select department,
avg(treatment_cost) as average_cost from hsm
group by department
having (average_cost)>50000; 


-- Q47. Find doctor with highest number of patients
select count(*) as total, doctor_name from hsm
group by doctor_name
order by total desc limit 1;


-- Q48. Rank patients by treatment cost
select patient_name, treatment_cost,
rank() over(order by treatment_cost desc) as ranking from hsm;


-- Q49. Find cumulative treatment cost
select patient_name, treatment_cost,
sum(treatment_cost) over(order by patient_id) as cummulative_cost from hsm;


-- Q50. Find department-wise highest treatment cost
select department, sum(treatment_cost) as high_cost
from hsm
group by department
order by high_cost desc;
