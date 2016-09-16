#!/bin/bash

#########################
#
# rename and remove header lines
#
#########################

# No loop here, for only 5 files will do it hamfistedly

tail -n +2 'Hospital General Information.csv' > hospitals.csv
tail -n +2 'Timely and Effective Care - Hospital.csv' > effective_care.csv
tail -n +2 'Readmissions and Deaths - Hospital.csv' > readmissions.csv
tail -n +2 'Measure Dates.csv' > Measures.csv
tail -n +2 'hvbp_hcahps_06_08_2016.csv' > surveys_responses.csv
