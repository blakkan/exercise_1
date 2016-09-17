#!/bin/bash

#
# get the url and unzip it (just unzipping the files needed)
#

rm *.csv *.zip

wget http://medicare.gov/download/HospitalCompare/2015/July/HOSArchive_Revised_FlatFiles_20150716.zip

unzip HOSArchive_Revised_FlatFiles_20150716.zip \
 'Hospital General Information.csv' \
 'Timely and Effective Care - Hospital.csv' \
 'Readmissions and Deaths - Hospital.csv' \
 'Measure Dates.csv' \
 'hvbp_hcahps_05_28_2015.csv'

rm *.zip

#
# rename and remove header lines
#

# No loop here, for only 5 files will do it hamfistedly

tail -n +2 'Hospital General Information.csv' > hospitals.csv
tail -n +2 'Timely and Effective Care - Hospital.csv' > effective_care.csv
tail -n +2 'Readmissions and Deaths - Hospital.csv' > readmissions.csv
tail -n +2 'Measure Dates.csv' > Measures.csv
tail -n +2 'hvbp_hcahps_05_28_2015.csv' > surveys_responses.csv

# Drop the renamed (and header trimmed) files into hdfs

#hdfs dfs -put hospitals.csv /user/w205/hospital_compare
#hdfs dfs -put effective_care.csv /user/w205/hospital_compare
#hdfs dfs -put readmissions.csv /user/w205/hospital_compare
#hdfs dfs -put Measures.csv /user/w205/hospital_compare
#hdfs dfs -put survey_responses.csv /user/w205/hospital_compare

