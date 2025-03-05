WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere' 
    AND job_title NOT LIKE '%Director%'
    AND job_title NOT LIKE '%Head%' 
    AND job_title NOT LIKE '%Principal%'
    AND job_title NOT LIKE '%Chief%'
    AND job_title NOT LIKE '%President%'
    AND job_title NOT LIKE '%Manager%'
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    skills_dim.skills,
    COUNT(*) AS skills_count,
    ROUND(AVG(top_paying_jobs.salary_year_avg), 0) AS avg_salary
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY
    skills_count DESC
LIMIT 10
