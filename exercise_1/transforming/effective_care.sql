/*
Effectiveness data is sepearated from timeliness to get an overall effective care composite metric later on. For some measures, a low score is good while for others a high score is good. The case statement inverts the measures where lower rates are better to make analysis easier later on.

- provider_id - foreign key to be used for joining
- measure_id - identifier unique at the measure level
- sample - sample size used to record the score
- score - metric that will be analyzed

*/

DROP TABLE my_effective_care;

CREATE TABLE my_effective_care AS
SELECT 
    provider_id,
    measure_id,
    CAST(sample AS INT) sample,
    CASE 
        WHEN measure_id IN ('OP_22', 'PC_1', 'VTE_6') THEN 100-score
        ELSE CAST(score AS INT)
    END AS score
FROM effective_care
WHERE measure_id IN ('IMM_2', 'IMM_3_OP_27_FAC_ADHPCT', 'OP_4', 'OP_22', 'OP_23', 'OP_29', 'OP_30', 'PC_1', 'STK_4', 'VTE_6')
;