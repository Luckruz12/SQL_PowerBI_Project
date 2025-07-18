/*
What it does:
  - Aggregates job postings by job title and country.
  - Calculates the average yearly salary for each group, rounding up to the nearest integer.
  - Filters out postings where the yearly salary is missing.
  - Orders the results by the highest average yearly salary.
*/

SELECT
  job_title,
  job_country,
  CEILING(AVG(salary_year_avg)) AS Average_Salary_Year
FROM 
  job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title, job_country
ORDER BY AVG(salary_year_avg) DESC
LIMIT 10; 