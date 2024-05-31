create database HR_Analysis;
use hr_analysis;
select * from hrdata;

---- 1.Total Employees
select count(EmployeeNumber) as "Total Employees" 
       from hrdata;
       
---- 2.Attrition Count
select round(count( case when attrition = "yes" then 1 end) ,0) as AttritionCount
       from hrdata;
   
---- 3.Active Employees
select (count(EmployeeNumber) - 
        count(case when attrition = "yes" then 1 end)) as ActiveEmployees
        from hrdata;

---- 3.TOTAL ATTRITION RATE
select concat(
              round( 
                     (count(case when attrition = "yes" then 1 end)/sum(employeecount))  * 100,2),"%") as AttritionRate 
                      from hrdata;

---- 4.Average attrition rate of all department
select department,
       concat(round((count(case when attrition = "yes" then 1 end)/count(employeecount)) * 100,2), " % ") as AttritionRate
       from hrdata 
       group by Department order by AttritionRate desc;
       
---- 5.Average Hourly rate of Male HR VS Female HR
select gender,
       department,
       round(avg(hourlyrate),2) as "Avg. Hourly Rate" from hrdata
       where Department = "Human Resources"
       group by Gender;
       
---- 6.Attrition rate Vs Monthly income Department wise
select Department,
	   Round(avg(monthlyincome), 2) as MonthlyIncome,
       concat(round((count(case	when attrition = "Yes" then 1 end)/count(employeecount) *100) ,2) ," % ")as AttritionRate,
       round(avg(jobsatisfaction), 2) as JobSatisfaction
       from hrdata
       group by Department order by monthlyincome desc;
       
---- 7.Job Role Vs Work life balance 
select jobrole,
       round(sum(worklifebalance), 0) as WorkLifeBalance
       from hrdata
       group by jobrole;
       
---- 8.Average working years for each Department 
select department,
       round(avg(worklifebalance), 2) as "Avg. WorkLifeBalance"
       from hrdata 
       group by Department;
       
---- 10.Attritiom Rate vs Year since last promotion by job role 
select jobrole,
       concat(
              round(
                    (count(case 
						   when attrition = "yes" then 1 end)/count(employeenumber) *100) ,2) ," % ") 
                           as AttritionRate,
	   sum(YearsSinceLastPromotion) as Yearsincelastpromotion
	   from hrdata
	   group by jobrole;
       
