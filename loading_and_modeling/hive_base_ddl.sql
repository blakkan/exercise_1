DROP TABLE hospitals;
CREATE EXTERNAL TABLE hospitals (
	Provider_ID INT,
	Hospital_Name STRING,
	Address STRING,
	City STRING,
	State STRING,
	ZIP_Code STRING,
	County_Name STRING,
	Phone_Number STRING,
	Hospital_Type STRING,
	Hospital_Ownership STRING,
	Emergency_services STRING,
	Meets_criteria_for_meaningful_use_of_EHRs STRING,
	Hospital_overall_rating INT,
	Hospital_overall_rating_footnote STRING,
	Mortality_national_comparison STRING,
	Mortality_national_comparison_footnote STRING,
	Safety_of_care_national_comparison STRING,
	Safety_of_care_national_comparision_footnote STRING,
	Readmission_national_comparision STRING,
	Readmission_national_comparision_footnote STRING,
	Patient_experience_national_comparision STRING,
	Patient_experience_national_comparision_footnote STRING,
	Effectiveness_of_care_national_comparision STRING,
	Effectiveness_of_care_national_comparision_footnote STRING,
	Timeliness_of_care_national_comparision STRING,
	Timeliness_of_care_national_comparision_footnote STRING,
	Efficient_use_of_medical_imaging_national_comparision STRING,
	Efficient_use_of_medical_imaging_national_comparison_footnote STRING )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care (
	Provider_ID INT,
	Hospital_Name STRING,
	Address STRING,
	City STRING,
	State STRING,
	ZIP_Code STRING,
	County_Name STRING,
	Phone_Number STRING,
	Condition STRING,
	Measure_ID STRING,
	Measure_Name STRING,
	Score STRING,
	Sample STRING,
	Footnote STRING,
	Measure_Start_Date DATE,
	Measure_End_Date DATE )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';


