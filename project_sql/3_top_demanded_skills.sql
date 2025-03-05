WITH filtered_jobs AS (
    SELECT DISTINCT job_postings_fact.job_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Scientist'
    AND job_work_from_home IS TRUE
    AND job_title NOT LIKE '%Director%'
    AND job_title NOT LIKE '%Head%'
    AND job_title NOT LIKE '%Principal%'
    AND job_title NOT LIKE '%Chief%'
    AND job_title NOT LIKE '%President%'
    AND job_title NOT LIKE '%Manager%'
),
total_jobs AS (
    SELECT COUNT(*) AS total_jobs FROM filtered_jobs
)

SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(
        COUNT(DISTINCT skills_job_dim.job_id) * 1.0 / (SELECT total_jobs FROM total_jobs), 2
    ) AS perc_jobs
FROM filtered_jobs
INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;