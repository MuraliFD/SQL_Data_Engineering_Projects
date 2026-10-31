-- Date functions
-- Extract

SELECT 
    EXTRACT(YEAR FROM job_posted_date) job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY 
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date) 
ORDER BY 
    job_posted_year,
    job_posted_month;
