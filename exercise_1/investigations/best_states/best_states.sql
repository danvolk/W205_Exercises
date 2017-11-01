SELECT 
    state,
    CAST(100*AVG(state_rank) AS DECIMAL(5,1)) avg_perc,
    CAST(100*STDDEV(state_rank) AS DECIMAL(5,1)) st_dev,
    COUNT(DISTINCT measure_id) measure_count,
    CAST(100*SUM(CASE WHEN state_rank>0.5 THEN 1 ELSE 0 END)/COUNT(DISTINCT measure_id) AS DECIMAL(4,1)) above_50,
    CAST(100*SUM(CASE WHEN state_rank>0.75 THEN 1 ELSE 0 END)/COUNT(DISTINCT measure_id) AS DECIMAL(4,1)) above_75
FROM ( 
    SELECT 
        state,
        measure_id,
        1 - (PERCENT_RANK() OVER (PARTITION BY measure_id ORDER BY avg_score)) state_rank
    FROM (
        SELECT 
            state,
            measure_id,
            AVG(score) avg_score,
            COUNT(DISTINCT p.provider_id) proc_count
        FROM my_procedures p
        LEFT JOIN my_hospitals h
        ON h.provider_id = p.provider_id
        WHERE score IS NOT NULL
        GROUP BY state, measure_id
        HAVING proc_count > 10
    ) A
) B
GROUP BY state
HAVING above_75 > 30
AND measure_count > 20
ORDER BY avg_perc DESC
LIMIT 10;