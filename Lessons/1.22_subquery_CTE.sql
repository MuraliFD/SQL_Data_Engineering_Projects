-- write a query to display the difference between the median salary 
--of remote jobs and onsite jobs for each job title
WITH title_median AS (
SELECT 
    job_title_short,
    job_work_from_home,
    MEDIAN(salary_year_avg)::INT AS median_salary
FROM job_postings_fact
WHERE job_country = 'United States'
GROUP BY 
    job_title_short,
    job_work_from_home
)
SELECT 
    t.job_title_short,
    t.median_salary AS remote_median_salary,
    m.median_salary AS onsite_median_salary,
    (t.median_salary-  m.median_salary) AS remote_premium
FROM title_median t
INNER JOIN title_median m
ON 
    t.job_title_short = m.job_title_short
WHERE t.job_work_from_home = TRUE
AND 
    m.job_work_from_home = FALSE
ORDER BY 
    remote_premium DESC;
