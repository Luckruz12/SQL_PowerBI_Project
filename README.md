# Job Market Analysis
📊 This project explores the data job market trends, focusing on 🔥in-demand skills,💰 salary benchmarks, 📈 remote work trends, and 🎓 degree requirements for data analysis roles.

🔍SQL queries? Check them out here:[SQL_POWERBI_PROJECT](#SQL_POWERBI_PROJECT)

## Project Motivation/Backgroud
The rapid evolution of the industry has made it essential for job seekers, employers, and educators to stay updated on current market trends. This project was inspired by the need to understand which skills, qualifications, and roles are mostly valued inthe remote data analysis job market, and to provide actionable insights for career and curriculum development. 
## The Questions I Answered😕 
1. Which specific skills are most in demand for remote Data Analyst positions?
2. Which role and positions offers the highest average yearly compensation?
3. Do jobs that do not mention a degree requirement offer different average salaries compared to those that do?

## Tools Used⚒️🔧 
      - **SQL (Postregsql):** Data querying and analysis
      - **Power BI:** Interactive dashboards and visualizations
      - **VS Code:** Code editing and documentation
      - **Git & GitHub:** Version control and collaboration


## The Analysis 📊 


      


SELECT 
    sd.skills,
    sd.type AS skill_type,
    COUNT(sjd.job_id) AS demand_count,
    jf.job_work_from_home
FROM 
  skills_job_dim sjd
INNER JOIN 
  skills_dim sd ON sjd.job_id = sd.skill_id
INNER JOIN 
  job_postings_fact jf ON sjd.job_id = jf.job_id
WHERE 
   jf.job_work_from_home = 'Yes'
AND
   jf.job_title_short = 'Data Analyst'
GROUP BY 
    sd.skills, sd.type, jf.job_work_from_home
ORDER BY 
    demand_count DESC;
LIMIT 5;

      |  Skills   |  Skills Type  |  Demand Count  |
      |-----------|---------------|----------------|
      |  Sql      |  Programming  |  7291          |
      |  Excel    |  Analyst Tool |  4611          |
      |  Python   |  Programming  |  4330          |
      |  Tableau  |  Analyst Tool |  3745          |
      |  Power BI |  Analyst Tool |  2609          |