DROP TABLE my_hospitals;

CREATE TABLE my_hospitals AS 
SELECT 
    provider_id,
    hospital_name,
    state,
    hospital_overall_rating AS rating
FROM hospitals
;