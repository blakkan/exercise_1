Exercise 1    W205     Fall 2016    John Blakkan




# General notes on approach

I chose to use hive, rather than Spark, for this exercise.  Spark would likely
show better performance, but maximum performance was not a key goal in this
particular implementation.  (For performance, a column-oriented database might
also be a better choice, since many of the operations involve column averages,
counts, and standard deviations.  Likewise, no indices were added to the
tables.)

# Loading and modeling section

Go into the **loading_and_modeling** directory, view the Entity-Relationship
diagram (the .png file).  The ER diagram is very simple, with only 1-1
relations.  In general, my approach was to have the transforming section of
the assignment do most of the work.  The joins and aggregate functions are
mostly completed during transforming, leaving tables of largely completed
operations for the "investigations" section.   This was a deliberate design
choice; to pre-compute as much of the result, so the final "investigations"
could be done as quickly as possible.

To run the loading and modeling section:

    cd loading_and_modeling
    ./load_data_lake.sh
    hive -f hive_base_ddl.sql

This takes several minutes to run on an M3 medium instance.  When complete,
`cd` back up to the main assignment directory.

This leaves five tables in HDFS (The original five suggested by the
assignment.)  All five were requested by the assignment.  Note that the main
key (also used as a foreign key) will be the provider_id (i.e. the Hospital ID.)
As a foreign key, it will typically be shortened to "hid" (Hospital ID) and is
an integer.  measure_id will also be used as a foreign key, it is a string.

# Transforming section

This has the largest amount of SQL; as mentioned earlier, the approach was to
do relatively more work in the "transforming" section, and less in the
"investigations" section.

Run the transformations with these steps.  Note there is an ordering dependency:
the **correlation_table** table must be built after the **hospital_score**
table.   This is intentional, and lets the **correlation_table** be built from
**hospital_score**, reducing the amount of work.

To run the transforming section:

  cd transforming
  hive -f hospital_score.sql
  hive -f procedure_test_score_variablity.sql
  hive -f correlation_table.sql

This builds three new tables.  Note that these tables compute a variety of
summary statistics, including averages, population standard deviations,
coefficient of variance (i.e. sd/mean), and counts.  The assignment speaks
generally about "variation."   For some of the questions, population sd could
be used.  For others, coefficient of variation might be (for example, where
there were scores of "wait times" rather than a 0-10 scale).  I typically
included several descriptive statistics in the transformed tables, to allow
choice when running the final results.  Note: for some of these metrics, a
case could be made that IQR (Interquartile range) might be used, especially if
there are large outliers.  These could be available using arithmetic on
percentile aggregate functions, but I did not do this in my analysis.

Note on hospital_score table:   I chose to omit Emergency Department metrics
(including OP_18b), as inspection of the data showed they were not on the same
scale as the other metrics.   I also omitted metrics for hospitals which
reported very few scores (< 16, my arbitrary choice after inspecting a sample
of the data).  This was because: (1) metrics could be strongly influenced by
just a few scores, and (2) I decided that any hospital reporting such few scores
was generally "suspect" in terms of data gathering

Note on the procedure_test_score_variablity table:  There's a division
operation in creating this table.   I add a very small epsilon to the
denominator, as a "poor man's divide by zero avoider."  Based on the scales of
the data, the epsilon will not significantly impact the analysis.

Final note on NULLs:  Per the SQL documentation, the aggregate functions
generally do the right thing with NULLs, so there isn't a lot of selecting-out
nulls.

# Investigations section

These all run from the "investigations" directory.

## Question 1: Best hospitals

    cd investigations/best_hospitals
    hive -f best_hospitals.sql

Results are in investigations/best_hospitals/best_hospitals.txt
(More details in this file, report.md)

## Question 2: Best states

    cd investigations/best_states
    hive -f best_states.sql

Results are in investigations/best_states/best_states.txt
(More details in this file, report.md)

## Question 3: Most variablity of procedure scores

    cd investigations/hospital_variablity
    hive -f hospital_variability.sql

Results are in investigation/hospital_variability/hospital_variability.txt
(More details in this file, report.md)

## Question 4:  Correlate procedure scores/variation with surveys

    cd investigations/hospitals_and_patients
    hive -f hospitals_and_patients.sql

Results are in investigation/hospitals_and_patients/hospitals_and_patients.txt
(More details in this file, report.md)
