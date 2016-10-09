-- question 1, by hospital
-- will use this table later, so keep a copy
DROP TABLE hospital_score;

CREATE TABLE hospital_score (hid int, average_of_scores float, sd_of_scores float, number_of_scores int);

INSERT INTO hospital_score
SELECT t.hid, t.average_of_scores, t.sd_of_scores, t.number_of_scores FROM (
  SELECT provider_id AS hid,
  AVG( CAST(score AS float)) AS average_of_scores,
  STDDEV_POP( CAST(score AS float)) as sd_of_scores,
  COUNT( CAST(score AS float)) AS number_of_scores
  FROM effective_care
  -- Drop all non-numeric entries, and the emergency room items which are not on a 100 scale
  WHERE (
    (measure_id NOT LIKE 'ED%')
      AND
    (measure_id <> 'OP_18b')
  )
  GROUP BY provider_id
)
AS t
WHERE t.number_of_scores > 15;
