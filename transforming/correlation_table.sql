---
-- Question 4
--
--  Create the correlation table (i.e. table from which correlations will be calculated
--
--  NOTE: we're making the (compute saving) assumption that hospital_score table hospital_score
-- already been created
DROP TABLE correlation_table;

CREATE TABLE correlation_table (hid INT,
                                average_of_scores FLOAT,
                                sd_of_scores FLOAT,
                                coefficient_of_variation_of_scores FLOAT,
                                total_survey_results FLOAT);

INSERT INTO correlation_table
SELECT hospital_score.hid,
       hospital_score.average_of_scores,
       hospital_score.sd_of_scores,
       hospital_score.sd_of_scores / hospital_score.average_of_scores,
       CAST (surveys_responses.hcahps_base_score + surveys_responses.hcahps_consistency AS FLOAT ) AS total_survey_result
FROM hospital_score JOIN surveys_responses
WHERE hospital_score.hid = CAST (surveys_responses.provider_number AS INT);
