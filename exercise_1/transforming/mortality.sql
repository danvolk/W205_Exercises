/*
The mortality data is separated from the complications data to keep the analysis clean. Measures are expressed in rates. Lower mortality rates are always better.

- provider_id - foreign key to be used for joining
- measure_id - identifier unique at the measure level
- denominator - sample size used to record the score
- score - metric that will be analyzed

*/

DROP my_mortality;

CREATE TABLE my_mortality AS 
SELECT 
    provider_id,
    measure_id,
    CAST(denominator AS INT) denominator,
    CAST(score as FLOAT) score
FROM readmissions
WHERE measure_id LIKE '%MORT%'
;
    