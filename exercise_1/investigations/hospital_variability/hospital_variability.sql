SELECT 
    proc.measure_id,
    CAST(AVG(score) AS DECIMAL(8,2)) avg_score,
    CAST(STD(score) AS DECIMAL(8,2)) std_score,
    CAST(VARIANCE(adjusted_score) AS DECIMAL(8,2)) proc_var
FROM (
    SELECT 
        measure_id,
        score,
        score/AVG(score) OVER (PARTITION BY measure_id) adjusted_score
    FROM my_procedures
) proc
LEFT JOIN my_measures meas
ON proc.measure_id = meas.measure_id
GROUP BY proc.measure_id, measure_name
ORDER BY proc_var DESC
LIMIT 10;