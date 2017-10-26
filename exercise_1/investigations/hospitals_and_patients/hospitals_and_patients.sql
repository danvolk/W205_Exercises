SELECT
    CORR(avg_proc_percentile, overall_rating)
FROM ( 
    SELECT 
        provider_id,
        CAST(AVG(provider_rank)*100 AS DECIMAL(4,1)) avg_proc_percentile
    FROM ( 
        SELECT 
            provider_id,
            measure_id,
            score,
            1 - (PERCENT_RANK() OVER (PARTITION BY measure_id ORDER BY score)) provider_rank
        FROM my_procedures
        WHERE score IS NOT NULL
    ) A
    GROUP BY provider_id
) procs
LEFT JOIN my_survey_responses surv
ON procs.provider_id = surv.provider_id
LIMIT 20;