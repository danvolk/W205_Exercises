DROP TABLE my_procedures;

CREATE TABLE my_procedures AS 
SELECT 
    provider_id,
    measure_id,
    CAST(sample AS INT) sample,
    CASE
        WHEN measure_id IN ('IMM_2', 'IMM_3_OP_27_FAC_ADHPCT', 'OP_4', 'OP_23', 'OP_29', 'OP_30', 'STK_4', 'VTE_5') THEN 100-score
        ELSE CAST(score AS DECIMAL(10,4))
    END AS score
FROM effective_care
WHERE measure_id NOT IN ('EDV', 'OP_1', 'OP_2', 'OP_31')
AND score <> 'Not Available'

UNION ALL

SELECT 
    provider_id,
    measure_id,
    CAST(denominator AS INT) sample,
    CAST(score AS DECIMAL(10,4)) score
FROM readmissions
WHERE measure_id NOT IN ('PSI_8_POST_HIP')
AND score <> 'Not Available'

ORDER BY provider_id, measure_id
;
