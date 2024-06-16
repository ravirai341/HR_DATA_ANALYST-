create database HR_DATA;
use hr_data;
select * from hr_1;
select * from hr_2;


-- Total employee
SELECT 
COUNT(*) AS EmployeeCount
FROM 
hr_1;
-- WHERE 
-- Attrition = 'no';


  -- Male and female count --  
SELECT 
gender, 
COUNT(*) AS EmployeeCount
FROM hr_1
GROUP BY 
gender;


-- Active Employees
select count(attrition) - (select count(attrition) from hr_1  where attrition='Yes') from hr_1;



-- ---- average attrition rate for all department----

SELECT 
    department,
    AVG(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)*100 AS attrition_rate
FROM 
    hr_1
GROUP BY 
    department;

-- total attrition Rate

select
round (((select count(attrition) from hr_1 where attrition='Yes')/ 
count(attrition)) * 100,2)
from hr_1;


-- Average Hourly rate of Male Research Scientist

SELECT jobrole , AVG(hourlyrate) AS average_hourly_rate
FROM HR_1
WHERE gender = 'Male' and jobrole = 'research scientist'
GROUP BY jobrole;

-- Average working years for each Department

SELECT e.department, AVG(w.TotalWorkingYears) AS avg_working_years
FROM hr_1 as e
JOIN hr_2 as w ON e.EmployeeNumber = w.`Employee ID`
GROUP BY e.department;

-- job role vs ave working life balance---
SELECT e.JobRole,
       AVG(w.WorkLifeBalance) AS avg_work_life_balance
FROM hr_1 e
join hr_2 w ON e.EmployeeNumber = w.`Employee ID`
GROUP BY JobRole;


-- Attrition rate Vs Year since last promotion relation

SELECT
    CASE 
        WHEN e.attrition = 'Yes' THEN 'Attrition'ELSE 'No Attrition' END AS attrition_status,
    AVG(w.YearsSinceLastPromotion) AS average_years_since_last_promotion
FROM
    hr_1 e
join hr_2 w ON e.EmployeeNumber = w.`Employee ID`     
GROUP BY
    e.attrition;
    
    
    
SELECT
    e.attrition,
    CASE 
        WHEN w.YearsSinceLastPromotion < 1 THEN '0-1 years'
        WHEN w.YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 years'
        WHEN w.YearsSinceLastPromotion BETWEEN 2 AND 3 THEN '2-3 years'
        WHEN w.YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 years'
        ELSE '5+ years'
    END AS promotion_bin,
    COUNT(*) AS EmployeeCount
FROM
    hr_1 e
    join hr_2 w ON e.EmployeeNumber = w.`Employee ID`
GROUP BY
    e.attrition,
    promotion_bin
ORDER BY
    e.attrition,
    promotion_bin;    
    

--- Attrition rate Vs Monthly income stats

SELECT
     CASE 
     WHEN e.attrition = 'Yes' THEN 'Attrition'
     ELSE 'No Attrition'
     END AS attrition_status,
    AVG(w.MonthlyIncome) AS average_monthly_income,
    MIN(w.MonthlyIncome) AS minimum_monthly_income,
    MAX(w.MonthlyIncome) AS maximum_monthly_income
FROM
    hr_1 e
JOIN
    hr_2 w ON e.EmployeeNumber = w.`Employee ID`
GROUP BY
    e.attrition;
    



