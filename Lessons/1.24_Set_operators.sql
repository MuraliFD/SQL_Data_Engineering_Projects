Set Operators
/*1. Union
2. Union All
3. Intersect 
4. Intersect All
5. Except
6. Except All
*/

-- create 2 tables from job_posting_fact where one table should consists data of 2023 job listings
-- and another table for 2024

CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT 
    'jobs_2023' AS table_name,
    COUNT(*) 
FROM jobs_2023
UNION 
SELECT 
    'jobs_2024',
    COUNT(*) 
FROM jobs_2024
ORDER BY table_name;


-- Which unique job_postings appeared in either 2023 or 2024?

SELECT * FROM jobs_2023
UNION
SELECT * FROM jobs_2024;
-- output: 1.08 million

-- which job posting appeared accross both years, counting the duplicates?

SELECT * FROM jobs_2023
UNION ALL
SELECT * FROM jobs_2024;
-- OUTPUT: 1.27 MILLION

-- Which job postings appeared both in 2023 and 2024?

SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;
-- OUTPUT: 18761 

-- Which 