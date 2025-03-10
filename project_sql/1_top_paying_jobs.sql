/*
- Identify the top 10 highest paying Data Analyst roles that arfe available remotely
- Focus on job posting with specified salaries
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employees
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    --AND job_location = 'Anywhere' 
    AND job_title NOT LIKE '%Director%'
    AND job_title NOT LIKE '%Head%' 
    AND job_title NOT LIKE '%Principal%'
    AND job_title NOT LIKE '%Chief%'
    AND job_title NOT LIKE '%President%'
    AND job_title NOT LIKE '%Manager%'
ORDER BY
    salary_year_avg DESC
LIMIT 10;

