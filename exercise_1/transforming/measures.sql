DROP TABLE my_measures;

CREATE TABLE my_measures AS 
SELECT
    measure_id,
    measure_name,
    measure_start_date,
    measure_end_date
FROM measures
;