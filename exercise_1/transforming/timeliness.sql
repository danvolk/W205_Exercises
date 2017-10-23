DROP TABLE my_timeliness;

CREATE TABLE my_timeliness AS 
SELECT 
    provider_id,
    measure_id,
    CAST(sample AS INT) sample,
    CAST(score AS INT) score
FROM effective_care
WHERE measure_id IN ('ED_1b', 'ED_2b', 'OP_5', 'OP_18b', 'OP_20', 'OP_21', 'OP_3b')
;