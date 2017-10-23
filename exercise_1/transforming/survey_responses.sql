/*
Only the essential information is brought in from the survey data. The provider_id is brought in for joining. Only the performance_rate metrics are included for the purposes of this analysis. 
*/

DROP TABLE my_survey_results;

CREATE TABLE my_survey_responses AS
SELECT 
    provider_id,
    CAST(communication_with_nurses_performance_rate AS FLOAT) nurse_comm,
    CAST(communication_with_doctors_performance_rate AS FLOAT) doc_comm,
    CAST(responsiveness_of_hospital_staff_performance_rate AS FLOAT) responsiveness,
    CAST(pain_management_performance_rate AS FLOAT) pain_management,
    CAST(communication_about_medicines_performance_rate AS FLOAT) medicine_comm,
    CAST(cleanliness_and_quietness_of_hospital_environment_performance_rate AS FLOAT) cleanliness,
    CAST(discharge_information_performance_rate AS FLOAT) discharge_info,
    CAST(overall_rating_of_hospital_performance_rate AS FLOAT) overall_rating
FROM survey_responses
;