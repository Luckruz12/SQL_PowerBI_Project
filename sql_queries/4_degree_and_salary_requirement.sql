-- Active: 1750961550573@@localhost@5432@sql_course
/*
What it does:

  - Groups job postings based on whether a degree is mentioned as a requirement (`job_no_degree_mention`).
  - Calculates the average yearly salary for each group, considering only postings with a non-null yearly salary.
  - Counts the number of job postings in each group.
*/
SELECT
  job_no_degree_mention AS no_degree_mention,
  ROUND(AVG(salary_year_avg)) AS salary_avg,
  COUNT(*) AS job_count
 FROM 
  job_postings_fact
WHERE
  salary_year_avg IS NOT NULL
GROUP BY
  no_degree_mention;