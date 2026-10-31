-- Arrays example

-- Build a flat skill table for co-workers to access job_titles, salary_info
-- and skills in one table.
CREATE OR REPLACE TEMP TABLE skill_flat AS
SELECT 
    jpf.job_id,
    jpf.job_title_short, 
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) as skill_array
FROM job_postings_fact  AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
GROUP BY 
    jpf.job_id,
    jpf.job_title_short, 
    jpf.salary_year_avg; 


select * from skill_flat
ORDER BY job_id
limit 20;

