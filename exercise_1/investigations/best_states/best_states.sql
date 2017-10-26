SELECT 
    B.state,
    CAST(AVG(provider_rank)*100 AS DECIMAL(4,1)) avg_proc_percentile,
    COUNT(measure_id) proc_count,
    CAST(100*SUM(CASE WHEN provider_rank>0.5 THEN 1 ELSE 0 END)/COUNT(measure_id) AS DECIMAL(4,1)) perc_above_50,
    CAST(100*SUM(CASE WHEN provider_rank>0.80 THEN 1 ELSE 0 END)/COUNT(measure_id) AS DECIMAL(4,1)) perc_above_80
FROM ( 
    SELECT 
        provider_id,
        measure_id,
        score,
        1 - (PERCENT_RANK() OVER (PARTITION BY measure_id ORDER BY score)) provider_rank
    FROM my_procedures
    WHERE score IS NOT NULL
) A
LEFT JOIN my_hospitals B
ON A.provider_id = B.provider_id
GROUP BY B.state
ORDER BY avg_proc_percentile DESC
LIMIT 10;
