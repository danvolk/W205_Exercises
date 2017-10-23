SELECT 
    A.provider_id,
    -- B.hospital_name,
    B.state,
    B.rating,
    CAST(AVG(provider_rank) AS DECIMAL(3,2)) avg_proc_percentile,
    COUNT(DISTINCT measure_id) proc_count,
    SUM(CASE WHEN provider_rank>0.5 THEN 1 ELSE 0 END) above_50,
    SUM(CASE WHEN provider_rank>0.75 THEN 1 ELSE 0 END) above_75
    --VARIANCE(provider_rank) var_proc
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
GROUP BY A.provider_id, B.hospital_name, B.state, B.rating
HAVING proc_count > 17
ORDER BY avg_proc_percentile DESC
LIMIT 25;
