-- Want state with the best average hospitals score
-- (Unweighted average of averages... May not be entirely fair, since
-- hospitals differ in size.  Further analysis might be done to weight
-- the hospital scores in each state by the relative number of admissions
-- to each hospital, but that is not done here.)
-- Recall hospital_score only includes average scores for those hospitals
-- reporting on > 15 metrics.

select hospitals.state, AVG(hospital_score.average_of_scores) as state_score, COUNT(hospital_score.average_of_scores)
  FROM hospital_score inner join hospitals on hospital_score.hid = hospitals.provider_id group by hospitals.state
  ORDER by state_score DESC limit 10;
