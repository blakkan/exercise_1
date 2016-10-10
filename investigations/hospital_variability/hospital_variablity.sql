--
-- Find procedures with greatest coefficient of variability (i.e. between hospitals)
--
SELECT
  (procedure_score_sd / procedure_score_avg) AS cv,
  procedure_score_sd,
  procedure_score_avg,
  procedure_score_count,
  measure_name
FROM procedure_test_score_variablity JOIN measures ON procedure_test_score_variablity.procid = measures.measure_id
ORDER BY cv DESC LIMIT 10;
