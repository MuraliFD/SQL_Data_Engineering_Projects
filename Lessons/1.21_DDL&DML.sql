-- Create database: jobs_mart

CREATE DATABASE IF NOT EXISTS jobs_mart;

-- create schema



-- CREATE SCHEMA: staging

CREATE SCHEMA IF NOT EXISTS jobs_mart.staging;


SHOW SCHEMAS;

DESCRIBE
SELECT * 
FROM INFORMATION_SCHEMA;

USE jobs_mart;

-- CREATE TABLE: priority_roles

CREATE TABLE IF NOT EXISTS staging.priority_job_roles
(
    job_id INTEGER PRIMARY KEY,
    job_name VARCHAR 
);

SELECT * 
FROM staging.priority_job_roles;

SELECT * 
FROM INFORMATION_SCHEMA.TABLES;


--------------------------------------------------------------------------------
-- CTAS: CREATE TABLE AS SELECT
CREATE TABLE IF NOT EXISTS staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
   
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;


SELECT 
    table_name,
    table_catalog,
    table_schema
FROM INFORMATION_SCHEMA.TABLES;

SELECT COUNT(*)
FROM staging.job_postings_flat;