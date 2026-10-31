-- Text Functions
/* 
LEFT
RIGHT
SUBSTRING
LENGTH
TRIM
REPLACE
CONCAT
*/

WITH CTE_lower AS (

    SELECT job_title,
        LOWER(TRIM(job_title)) AS job_title_clean

    FROM job_postings_fact
)

SELECT 
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END
FROM CTE_lower
ORDER BY RANDOM()
LIMIT 20;