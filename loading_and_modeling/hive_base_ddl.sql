--
-- hospitals   table
--
DROP TABLE hospitals;
CREATE EXTERNAL TABLE hospitals (
	provider_id INT,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	hospital_type STRING,
	hospital_ownership STRING,
	emergency_services STRING )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

--
-- effective_care table
--
DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care (
	provider_id INT,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	condition STRING,
	measure_id STRING,
	measure_name STRING,
	score STRING,
	sample STRING,
	footnote STRING,
	measure_start_date DATE,
	measure_end_date DATE )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

--
-- readmissions table
--
DROP TABLE readmissions;
CREATE EXTERNAL TABLE readmissions (
	provider_id INT,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	phone_number STRING,
	measure_name STRING,
	measure_id STRING,
	compared_to_national STRING,
	denominator INT,
	score FLOAT,
	lower_estimate FLOAT,
	higher_estimate FLOAT,
	footnote STRING,
	measure_start_date DATE,
	measure_end_date DATE )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

--
-- Measures table
--
DROP TABLE Measures;
CREATE EXTERNAL TABLE measures (
	measure_name STRING,
	measure_id STRING,
	measure_start_quarter STRING,
	measure_start_date DATE,
	measure_end_quarter STRING,
	measure_end_date DATE )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/Measures';

--
-- surveys_responses table
--   (note: provider id is provider_number in this table)
--   (note: keeping overall ratings as strings, not ints)
--
DROP TABLE surveys_responses;
CREATE EXTERNAL TABLE surveys_responses (
	provider_number INT,
	hospital_name STRING,
	address STRING,
	city STRING,
	state STRING,
	zip_code STRING,
	county_name STRING,
	communication_with_nurses_achievement_points STRING,
	communication_with_nurses_improvement_points STRING,
	communication_with_nurses_dimension_score STRING,
	communication_with_doctors_achievement_points STRING,
	communication_with_doctors_improvement_points STRING,
	communication_with_doctors_dimension_score STRING,
	responsiveness_of_hospital_staff_achievement_points STRING,
	responsiveness_of_hospital_staff_improvement_points STRING,
	responsiveness_of_hospital_staff_dimension_score STRING,
	pain_management_achievement_points STRING,
	pain_management_improvement_points STRING,
	pain_management_dimension_score STRING,
	communication_about_medicines_achievement_points STRING,
	communication_about_medicines_improvement_points STRING,
	communication_about_medicines_dimension_score STRING,
	cleanliness_and_quietness_of_hospital_environment_achievement_points STRING,
	cleanliness_and_quietness_of_hospital_environment_improvement_points STRING,
	cleanliness_and_quietness_of_hospital_environment_dimension_score STRING,
	discharge_information_achievement_points STRING,
	discharge_information_improvement_points STRING,
	discharge_information_dimension_score STRING,
	overall_rating_of_hospital_achievement_points STRING,
	overall_rating_of_hospital_improvement_points STRING,
	overall_rating_of_hospital_dimension_score STRING,
	hcahps_base_score STRING,    --keeping as string, since there may be not-availables
	hcahps_consistency STRING )  --keeping as string, since there may be not-availables
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/surveys_responses';

