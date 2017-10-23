DROP TABLE my_mortality;

CREATE TABLE my_mortality AS 
SELECT 
    provider_id,
    measure_id,
    CAST(denominator AS INT) denominator,
    CAST(score as FLOAT) score
FROM readmissions
WHERE measure_id LIKE '%MORT%'
;
    