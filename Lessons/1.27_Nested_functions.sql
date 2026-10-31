-- Array: Ordered collection of values of same type, indexed.

SELECT ['sql', 'python','r'];

WITH skills AS (
SELECT 'python' AS skill
UNION ALL
SELECT 'sql'
UNION ALL
SELECT 'r'
), skills_ordered AS (
SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
FROM skills
)
SELECT skills[1]
FROM skills_ordered;


-- Struct: key value pairs

SELECT {skill:'python', type: 'programming'};


WITH skills_struct AS (
SELECT 'python' as skills, 'programming' as types
UNION ALL
SELECT 'sql','query language'
UNION ALL
SELECT 'r','program_language'
), struct_pack AS (
    SELECT STRUCT_PACK(
        skill:= skills,
        type:= types
        ) AS skill_pack
    FROM skills_struct
)

SELECT skill_pack.skill,
        skill_pack.type
FROM struct_pack;


-- ARRAY OF STRUCTS

WITH skills_struct AS (
SELECT 'python' as skills, 'programming' as types
UNION ALL
SELECT 'sql','query language'
UNION ALL
SELECT 'r','program_language'
), struct_pack AS (
    SELECT ARRAY_AGG(
            STRUCT_PACK(
            skill:= skills,
            type:= types
        ) ORDER BY skills
     ) AS skill_array
    FROM skills_struct
)

SELECT skill_array[1].skill,
        skill_array[2].type,
        skill_array[3]
FROM struct_pack;

-- JSON: javascript object notation

SELECT '{"skill":"python", "type":"programming"}' as json_object;


WITH raw_json AS (
SELECT
'[
    {"skill":"python", "type":"programming"},
    {"skill":"sql", "type":"query language"},
    {"skill":"r", "type":"program language"}
]' :: JSON AS skills_json
)
SELECT 
    ARRAY_AGG(
        STRUCT_PACK(
            skill := json_extract_string(e.value, '$.skill'),
            type := json_extract_string(e.value, '$.type')
        ) ORDER BY  json_extract_string(e.value, '$.skill')
    )
FROM raw_json, json_each(skills_json) as e;
