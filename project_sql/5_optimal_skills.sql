SELECT 
    skills_dim.skill_id,
    skills_dim.skills AS skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Scientist'
    AND job_work_from_home IS TRUE
    AND job_title NOT LIKE '%Director%'
    AND job_title NOT LIKE '%Head%'
    AND job_title NOT LIKE '%Principal%'
    AND job_title NOT LIKE '%Chief%'
    AND job_title NOT LIKE '%President%'
    AND job_title NOT LIKE '%Manager%'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 20
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;