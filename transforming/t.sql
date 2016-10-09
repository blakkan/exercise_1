--
-- t.sql
--
--   This file is for reference only; it was run on postgres to verify aggregate functions.
-- It will be used as a guide for the hive/sql (or spark) transforms and queries.
--
-- 

drop table hospital;
drop table procedure;
drop table survey_results;

drop table procedure_average;
drop table procedure_range;


create table hospital (hid int, name varchar, state varchar);
insert into hospital (hid, name, state) values
  (1, 'UCLA', 'CA'),
  (2, 'Stanford', 'CA'),
  (3, 'Cedars Sinai', 'CA'),
  (4, 'Mayo Clinic', 'MN'),
  (5, 'Mass General', 'MA');

create table procedure ( hid int, procid varchar, score float );
insert into procedure (hid, procid, score) values
  (1, 'stroke', 5.0),
  (1, 'surgery', 7.0),
  (1, 'imm', 8.0),
  (2, 'stroke', 4.0),
  (2, 'surgery', 4.0),
  (2, 'imm', 3.0),
  (3, 'stroke', 5.0),
  (3, 'surgery', 7.0),
  (3, 'imm', 8.0),
  (4, 'stroke', 5.0),
  (4, 'surgery', 8.0),
  (4, 'imm', 8.0),
  (5, 'stroke', 1.0),
  (5, 'surgery', 3.0);


create table survey_results ( hid int, first_score int, second_score int, total_survey_score float);
insert into survey_results (hid, first_score, second_score) values
  (1, 80, 20),
  (2, 70, 10),
  (3, 75, 15),
  (4, 88, 9),
  (5, 89, 9);

-- question 1, by hospital
-- will use this table later, so keep a copy
drop table hospital_score;
create table hospital_score (hid int, average_score float);
insert into hospital_score (hid, average_score) select hid, AVG(score)
  from procedure group by hid;

error 'COMMENT: this is table hospital_score, maps hospital to avg score';
select hospital.hid, name, state, average_score from hospital_score join hospital
  on hospital_score.hid = hospital.hid
  order by average_score DESC limit 10;

-- question 2, by state
-- do not need this table later so don't save it
drop table state_score;
create table state_score (state varchar(2), average_score float);
INSERT into state_score ( state, average_score) select state, AVG(score)
  FROM procedure inner join hospital on procedure.hid = hospital.hid group by state;

error 'COMMENT: this is table state_score';
select * from state_score order by average_score DESC limit 10;



-- question 3, which procedures vary the most between hospitals
-- do not need this table for later questions so don't save it
drop table procedure_test_score_range;
create table procedure_test_score_range (procid varchar, range float);
INSERT into procedure_test_score_range ( procid, range )
-- SELECT procid, (MAX(score) - MIN(score)) as range  --simple range
SELECT procid, stddev_pop(score) as range     -- IQR might be better
FROM procedure group by procid;

error 'COMMENT: this is table procedure_test_score_range';
select procid, range as delta from procedure_test_score_range
order by range DESC limit 10;

-- question 4, create corrleation table
drop table hospital_test_score_range;
create table hospital_test_score_range (hid int, score_range float);
INSERT into hospital_test_score_range ( hid, score_range)
--SELECT hid, percentile(score, 0.75) - percentile(score, 0.25) as score_range
--SELECT hid, (MAX(score) - MIN(score)) as score_range
SELECT hid, stddev_pop(score) as score_range
FROM procedure group by hid;

error 'COMMENT: this is table hospital_test_score_range';
select hid, score_range from hospital_test_score_range
order by score_range DESC limit 10;



-- Now make a correlation table from which pyspark will
-- compute the pearson R

drop table correlation_table;
create table correlation_table (hid int,
                                average_score float,
                                test_score_range float,
                                total_survey_result float );
insert into correlation_table (hid, average_score, test_score_range, total_survey_result)
select hospital_score.hid,
       hospital_score.average_score,
       hospital_test_score_range.score_range,
       (survey_results.first_score + survey_results.second_score) as total_survey_result
  from hospital_score, hospital_test_score_range, survey_results
  where hospital_score.hid = hospital_test_score_range.hid and
    hospital_score.hid = survey_results.hid;

error 'COMMET: this is the correlation table';
select hid, average_score, test_score_range, total_survey_result from correlation_table
order by hid ASC limit 10;

error 'COMMENT: correlation of average score and survey results';
SELECT corr(average_score, total_survey_result) from correlation_table;
error 'COMMENT: correlation of score sd and survey results';
SELECT corr(test_score_range, total_survey_result) from correlation_table;
