/*
The my_hospitals table will contain only the columns needed for analysis
- provider_id - Primary key to identify the hospital
- hospital_name - Used to provide metadata about the hospital
- state - Used for aggregations at the state level
- rating - Used as a benchmark for high performing hospitals
*/

DROP TABLE my_hospitals;

CREATE TABLE my_hospitals AS 
SELECT 
    provider_id,
    hospital_name,
    state,
    hospital_overall_rating AS rating
FROM hospitals
;