#!/bin/bash

# Note:   remove /user/w205/hospital_compare before running this;
# remove (hdfs dfs -rmr is not included here to avoid inadvertent
# deletions)
#
# get the url and unzip it (just unzipping the files needed)
#

rm *.csv *.zip

echo "*****completed removing old files"

wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

echo "*****completed the wget"
ls -l Hospital_Revised_Flatfiles.zip

unzip Hospital_Revised_Flatfiles.zip \
 'Hospital General Information.csv' \
 'Timely and Effective Care - Hospital.csv' \
 'Readmissions and Deaths - Hospital.csv' \
 'Measure Dates.csv' \
 'hvbp_hcahps_05_28_2015.csv'

echo "*****completed the unzip"
#
# rename and remove header lines
#

# No loop here, for only 5 files will do it hamfistedly

tail -n +2 'Hospital General Information.csv' > hospitals.csv
tail -n +2 'Timely and Effective Care - Hospital.csv' > effective_care.csv
tail -n +2 'Readmissions and Deaths - Hospital.csv' > readmissions.csv
tail -n +2 'Measure Dates.csv' > Measures.csv
tail -n +2 'hvbp_hcahps_05_28_2015.csv' > surveys_responses.csv

echo "*****completed the removal of the header line and copying into shorter-named csvs"
ls *.csv

# Drop the renamed (and header trimmed) files into hdfs

hdfs dfs -rm -r /user/w205/hospital_compare  # out with the old

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

echo "*****completed purging old hdfs files an adding new ones"

# cleanup csv and files here; just want the files in distributed file sysstem

rm *.csv *.zip

echo "*****completed removal of local non hdfs csv and zip files"

# at this point, we have the five csv files in the distributed file system.
# we haven't yet put any database ddl or access capability around them, just
# put the files into HDFS
