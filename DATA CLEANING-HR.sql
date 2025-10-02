--CREATE DATABASE Project; 

--USE Project;

--SELECT * FROM HR;

--Exec SP_RENAME 'HR.id', 'emp_id', 'Column';

--SELECT COLUMN_NAME, DATA_TYPE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME = 'HR';

--ALTER TABLE HR ADD 
--termdatetime DATETIME;

--UPDATE HR
--SET termdatetime = 
--CASE
--   WHEN termdate IS NOT NULL
--   THEN CAST(LEFT(termdate, 16) AS datetime)
--   ELSE NULL 
--END;


--SELECT termdatetime FROM HR

--ALTER TABLE HR
--DROP COLUMN termdate;

--Exec SP_RENAME 'HR.termdatetime', 'termdate', 'Column';

 --UPDATE HR
 --SET termdate = CAST(termdate AS DATE)
 --WHERE termdate IS NOT NULL;

 --ALTER TABLE HR
 --ALTER COLUMN termdate DATE;
 

--ALTER TABLE HR ADD 
--age TINYINT;

--UPDATE HR
--SET age = DATEDIFF(YEAR, birthdate, GETDATE());


--How many employees are there by gender?

--SELECT gender, count(gender) AS GCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL 
--GROUP BY gender; 

--How many employees by race are there?
--SELECT race, count(race) AS RaceCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL
--GROUP BY race;

--How many employees are there in each department?
--SELECT department, gender,
--count(department) AS DeptCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL
--GROUP BY department, gender
--ORDER BY department;

--How many employees by location?
--SELECT location, count(location) AS LocationCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL
--GROUP BY location;

--What is the distribution of employees by city and state?
--SELECT location_city, count(location_city) AS CityCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL
--GROUP BY location_city
--ORDER BY CityCount DESC;

--SELECT location_state, count(location_state) AS StateCount
--FROM HR
--WHERE age >= 18 AND termdate IS NULL
--GROUP BY location_state
--ORDER BY StateCount DESC;

--What is the age distribution of employees?
--SELECT 
--  MIN(age) AS youngest,
--  MAX(age) AS oldest
--FROM HR
--WHERE age >= 18 AND termdate IS NULL;

--WITH AgeGroups AS (
--SELECT
-- CASE 
--   WHEN age >= 18 AND age <= 25 THEN '18-25'
--   WHEN age >= 26 AND age <= 35 THEN '26-35'
--   WHEN age >= 36 AND age <= 45 THEN '36-45'
--   WHEN age >= 46 AND age <= 55 THEN '46-55'
--   WHEN age >= 56 AND age <= 65 THEN '56-65'
--   ELSE '66+'
-- END AS age_group
--FROM HR
--WHERE age >= 18 AND termdate IS NULL 
--)
--SELECT age_group, count(*) AS Count
--FROM AgeGroups
--GROUP BY age_group
--ORDER BY age_group DESC;

--Distributions of job titles in the company
--SELECT jobtitle, count(jobtitle) AS Total
--FROM HR
--GROUP BY jobtitle
--ORDER BY jobtitle;

--What was the length of employment for those terminated?
--SELECT last_name,
-- DATEDIFF(year, hire_date, termdate) AS emp_length
--FROM HR
--WHERE termdate IS NOT NULL;

--What is the turnover rate by department?
--SELECT department, empl_total, terminations,
-- round(CAST(terminations AS FLOAT)/NULLIF(empl_total, 0), 3) AS termination_rate
--FROM (
--SELECT department,
-- count(*) AS empl_total,
-- sum(CASE WHEN termdate IS NOT NULL AND year(termdate) = 2024 THEN 1 ELSE 0 END) AS terminations
-- FROM HR
--GROUP BY department
--) AS subquery
--ORDER BY termination_rate desc;

--What are the total hires and fires over time?
--WITH Hires AS (
-- SELECT year(hire_date) AS Year,
--   count(*) AS total_hires
--  FROM HR
--  WHERE YEAR(hire_date) <= 2020
--  GROUP BY year(hire_date)
--),
--Terminations AS (
-- SELECT year(termdate) AS Year,
--   count(*) AS total_terminations
--  FROM HR
--  WHERE termdate IS NOT NULL AND YEAR(termdate) <= 2020
--  GROUP BY year(termdate)
--)
--SELECT 
-- COALESCE(H.year, T.year) AS Year,
-- ISNULL(H.total_hires, 0) AS total_hires,
-- ISNULL(T.total_terminations, 0) AS total_terminations
-- FROM Hires H
-- FULL OUTER JOIN Terminations T ON H.Year = T.Year
-- ORDER BY Year;

--What is the tenure distribution for each department?
--SELECT department, avg(DATEDIFF(DAY, hire_date, termdate)/365) AS avg_tenure
--FROM HR
--WHERE termdate <= '2020-12-31' AND termdate IS NOT NULL AND age >= 18
--GROUP BY department;