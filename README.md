# Job Market Analysis
📊 This project explores the data job market trends, focusing on 🔥in-demand skills,💰 salary benchmarks, 📈 remote work trends, and 🎓 degree requirements for data analysis roles.

🔍SQL queries? Check them out here: [SQL_POWERBI_PROJECT](/sql_queries/)

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
1. [In-demand Skills for Remote Data Analyst Roles](#1-in-demand-skills-for-remote-data-analyst-roles-)
2. [Average Yearly Salary By Role And Country](#2-average-yearly-salary-by-role-and-country-)
3. [Top Romote Employers by Year](#3-top-remote-employers-by-year-)
4. [Degree Requirement for Remote Data Analysts](#4-degree-requirement-for-remote-data-analysts-)

## 1. In-demand Skills for Remote Data Analyst Roles 🚀 

**What it does:**
- Joins job postings with their reqiured skills.
- Filters for job that are remote(`job_work_from_home = 'Yes'`) and have the exact title  `Data Analyst`.
- Counts the number of times each skill is mentioned in the job postings.
- Filters for the top 5 skills that are in demand for remote Data Analyst roles.( e.g `Python`, `SQL`, `Excel`).

**Insight**
 -Identiffy which skills are most in demand for remote Data Analyst roles (SQL, Python, and Excel).
 - Understand wheather technical or analytical are more valued in the remote data analysis job market.
 - Spolt trends in remote work and the skills associated witn these opportunities.

 **Use Cases**
 - **Job Seekers:** Focus on acquiring or highlighting the top_listed skills in your resume and interviews for renmote Data Analyst roles.
 - **Employers:** Highlight the top skills in the job descriptions and job requirements to attract candidates with the necessary skills.
- **Educators:** Use the insights to develop curricula and teaching materials that emphasize the most in-demand skills for remote Data Analyst roles.
- **Data Analysts:** Use the insights to prioritize learning and development efforts in the skills that are most in demand for remote Data Analyst roles.

**SQL Queries**
```sql
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
```

|  Skills   |  Skills Type  |  Demand Count  |
|-----------|---------------|----------------|
|  Sql      |  Programming  |  7291          |
|  Excel    |  Analyst Tool |  4611          |
|  Python   |  Programming  |  4330          |
|  Tableau  |  Analyst Tool |  3745          |
|  Power BI |  Analyst Tool |  2609          |

*Table of the demand for the top 5 skills in remote Data Analyst in job postings.*

## [<small>back to top</small>](#the-analysis-)


## 2. Average Yearly Salary by Role and Country 💶🌍 

**What it does:**
- Aggregate the job postings by job title and county.
- Calculate the average salary for each group, rounding uo to the nearest integer.
- Filters out postings where the yearly is missing.
- Orders the results by the hieghest average yearly salary.

**Insights:**
- See which job titles and countries offers the highest average yearly salary.
- Indentify geographic or roles-based trends in the average yearly salary.

**Use Cases:**
- **Job Seekers:** Target the roles and locations with higher average yearly salaries.
- **Employers:** Bernchmark your yearly salary offerings against market averages.
- **Educators/Trainers:** Advice students on lucrative carrer paths and locations.

**Noted:**
- The query only considers postings with a specified yearly salary. (`salary_year_avg IS NOT NULL`).

**SQL query:**
```sql

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
```

## [<small>back to top</small>](#the-analysis-)

## 3. Top Remote Employers by Year 🌏

**What it does:**
- Joins job postings with company information.
- Filters for jobs that are remote (`job_work_from_home = TRUE`).
- Groups results by company name and the year the job was posted.
- Counts the number of remote jobs posted by each company per year.
- Order the results to show companies with the most remote jobs at the top.

**Insights:**
- See which companies are leading in offering remote jobs opportunities.
- Track how remote job postings by company change over time.

**Use Cases:**
- **Job Seekers:** Identify companies with the most remote work cultures to target in your job search.
- **Employers:** Benchmaerk your remote  hiring activities against competitors.
- **Educators/Trainers:** Analyze the growth  and distribution of remote work opportunities by company and year.

**Noted:**
- The query only considers jobs explicitly marked as remote (`job_work_from_home = TRUE`).
- Companies with hydrid or flexible work arrangements not mark as remote may be underrepresented.

**SQL query:**
```sql

SELECT
 cd.name AS Company_Name,
 COUNT(jpf.company_id) AS remote_job_count,
 EXTRACT(year FROM job_posted_date) AS job_year
FROM 
  job_postings_fact jpf
  LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
  WHERE job_work_from_home = 'yes'
GROUP BY
    Company_Name, job_posted_date
ORDER BY
    remote_job_count DESC;
```

## [<small>back to top</small>](#the-analysis-)

## 4. Degree Requirement for Remote Data Analysts 🎓💶 

**What it does:**
- Goups job postings based on whether a degree is mentioned as a requirement (`job_no_degree_mention`).
- Calculates the average yearly salary for each group, considering only postings with a non-null yearly salary.
- Counts the number of job postings in each group.

**Insights**

- See if jobs that do not require a degreee tend to offer higher or lower average salaries.
- Understand how common it is for jobs to omit degree requirements and how that relates to compensation.

**Use Cases:**
- **Job Seekers:** Assess whether pursuing roles that to not reqiure a degree impacts potential earnings.
- **Employers:** Benchmark your job requirement and salary offerings against market trends.
- **Educators/Trainers:** advice students on the value of a degree in relation to salary expectations.

**Noted:**
- The analysis only includes jobs with a specified yearly salary (`salary_year_avg IS NOT NULL`).

**SQL query:**

```sql

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
  ```

## [<small>back to top</small>](#the-analysis-)

## What I Learnt 📚✨ 

- **Skill Demand Patterns:**
Gained insights into which technical skills are most valued for remote Data Analyst roles, helping to understand current industry expectations.

- **Salary Benchmarks:**
Learned how compensation varies by job title and country, and identified regions and roles with the highest earning potential.

- **Remote Work Trends:**
Discovered which companies are leading in remote hiring and how opportunities have evolved over time.

- **Degree Requirements Impact:**
Understand the relationship between degree requirements and salary, and how omitting degree reqiurements can affect job availibility and compensation.

- **Data Analysis & Visualization:**
Enhanced my ability to use SQL for complex data analysis and power BI for creating interactive, insighful dashboards.

- **Practical Application:**
Developed actionable recommendations for job seekers, employers, and educators based on real-world data.

## Conclution 🏁 

THis project provide a comprehensive analysis of the data job market, revealing key treands in skill demand, salary benchmarks, remote work opportunities, and the impact of degree reqiurements. BY leveraging SQL for data extraction and Power BI for visualization, I was able to generate actionable insights for job seekers, employers, and educators. These findings can guide career development, hiring strategies, and curriculum design, ensuring aligment with current industry needs and future workforce.

## Contact / Feedback ✉️
If you have any questions or feedback, feel free to reach out to me at [https://github.com/Luckruz12](#https://github.com/Luckruz12) or [https://www.linkedin.com/in/luckruz12/](#https://www.linkedin.com/in/luckruz12/) you can also email me at **lijemhen@gmail.com.**
