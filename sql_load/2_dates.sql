SELECT 
    COUNT(job_id) job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_posted_count DESC;
