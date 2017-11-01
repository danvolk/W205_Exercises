SELECT 
    A.provider_id,
    B.hospital_name,
    B.state,
    B.rating,
    CAST(AVG(provider_rank)*100 AS DECIMAL(4,1)) avg_percentile,
    COUNT(DISTINCT measure_id) proc_count,
    CAST(100*SUM(CASE WHEN provider_rank>0.5 THEN 1 ELSE 0 END)/COUNT(DISTINCT measure_id) AS DECIMAL(4,1)) above_50,
    CAST(100*SUM(CASE WHEN provider_rank>0.8 THEN 1 ELSE 0 END)/COUNT(DISTINCT measure_id) AS DECIMAL(4,1)) above_80
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
HAVING proc_count > 15
AND above_80 > 50
ORDER BY avg_proc_percentile DESC
LIMIT 10;
