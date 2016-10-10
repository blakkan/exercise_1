-- Question 4
--   Correlation results.
--   Just the calculation and output is done here, since
--   The tables were set up during the transform phase

SELECT corr(average_of_scores, total_survey_results) from correlation_table;
SELECT corr(sd_of_scores, total_survey_results) from correlation_table;
SELECT corr(sd_of_scores, total_survey_results) from correlation_table;
