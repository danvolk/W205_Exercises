DROP TABLE my_complications;

CREATE TABLE my_complications AS 
SELECT 
    provider_id,
    measure_id,
    CAST(denominator AS INT) denominator,
    CAST(score as FLOAT) score
FROM readmissions
WHERE measure_id NOT LIKE '%MORT%'
AND measure_id <> 'PSI_8_POST_HIP'
;