/*
The complications data is separated from the mortality data to keep the analysis clean. Measures are expressed in rates. Lower complication rates are always better.

- provider_id - foreign key to be used for joining
- measure_id - identifier unique at the measure level
- denominator - sample size used to record the score
- score - metric that will be analyzed

The post hip surgery numbers are removed because there is no variation in that metric.

*/

DROP my_complications;

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
    