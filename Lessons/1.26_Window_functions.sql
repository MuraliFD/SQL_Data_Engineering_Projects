-- Window Functions

-- calculate running average
SELECT 
    job_title_short,
    job_posted_date,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER(PARTITION BY job_title_short 
                              ORDER BY job_posted_date) AS running_avg
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
AND job_title_short = 'Data Engineer'
ORDER BY 
    job_title_short,
    job_posted_date
LIMIT 20;


-- Value functions

-- LAG() & LEAD()
DESCRIBE
SELECT * FROM job_postings_fact
LIMIT 20;
-- Get the previous salary of the job posting for each company and sequentially
SELECT 
    job_posted_date,
    company_id,
    job_title,
    job_title_short,
    salary_year_avg,
    LAG(salary_year_avg) OVER(PARTITION BY company_id 
    ORDER BY job_posted_date) AS previous_salry_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY 
    company_id,
    job_posted_date
LIMIT 30;
