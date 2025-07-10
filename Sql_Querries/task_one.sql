SELECT 
    sd.skills,
    sd.type AS skill_type,
    COUNT(sjd.job_id) AS demand_count,
    jf.job_work_from_home
FROM 
  skills_job_dim sjd
  INNER JOIN 
  skills_dim sd ON sjd.skill_id = sd.skill_id
  INNER JOIN 
  job_postings_fact jf ON sjd.job_id = jf.job_id
WHERE 
   jf.job_work_from_home = 'Yes'
   AND
   jf.job_title_short = 'Data Analyst'
GROUP BY 
    sd.skills, sd.type, jf.job_work_from_home
ORDER BY 
  demand_count DESC
LIMIT 5;



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