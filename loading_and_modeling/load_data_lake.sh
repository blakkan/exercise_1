#!/bin/bash

# Note: remove /user/w205/hospital_compare before running this;
# remove (hdfs dfs -rmr is not included here to avoid inadvertent
# deletions)
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


hdfs dfs -mkdir /user/w205/hospital_compare

hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir /user/w205/hospital_compare/Measures
hdfs dfs -put Measures.csv /user/w205/hospital_compare/Measures

hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses

# cleanup csv and zip files here; just want the files in distributed file sysstem

rm *.csv *.zip

# at this point, we have the five csv files in the distributed file system.
# we haven't yet put any database ddl or access capability around them, just
# put the files into HDFS
