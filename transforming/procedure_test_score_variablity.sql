-- question 3, which procedures vary the most between hospitals
-- Calculate the table here for faster queries later
-- (Will be a relatively small table, as there are not many procid's)
DROP TABLE procedure_test_score_variability;

CREATE TABLE procedure_test_score_variability (procid STRING,
                                               procedure_score_sd FLOAT,
                                               procedure_score_avg FLOAT,
                                               procedure_score_coefficient_of_variation FLOAT,
                                               procedure_score_count INT
);

-- Will save average, SD, coefficient of variation, and count, in case we Want
-- them later
INSERT INTO procedure_test_score_variability
SELECT measure_id AS procid,
       STDDEV_POP(score) AS procedure_score_sd,
       AVG(score) AS procedure_score_avg,
       -- Our data doesn't have any divide by zero problem, but here's a
       -- way around it (the 0.001).   Given our data measures, this doesn't
       -- have any meaningful effect on coefficient of variation
       (STDDEV_POP(score) / (AVG(score) + 0.000001 ) ) AS procedure_score_coefficient_of_variation,
       COUNT(score) AS procedure_score_count
FROM effective_care
GROUP BY measure_id;
