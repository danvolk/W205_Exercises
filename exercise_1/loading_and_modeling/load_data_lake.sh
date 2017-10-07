#! /bin/bash

# save my current directory
MY_CWD=$(pwd)

# create staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging directory
cd ~/staging/exercise_1

# create our hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare

# get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/4a66c672-a92a-4ced-82a2-033c28581a90?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$MY_URL" -O medicare_data.zip

# unzip the medicare data
unzip medicare_data.zip

# 1 remove the first line of first file, rename and copy
OLD_FILE="Hospital General Information.csv"
NEW_FILE="hospitals.csv"
tail -n +2 "$OLD_FILE" >$NEW_FILE
hdfs dfs -put $NEW_FILE /user/w205/hospital_compare

# 2 remove the first line of second file, rename and copy
OLD_FILE="Timely and Effective Care - Hospital.csv"
NEW_FILE="effective_care.csv"
tail -n +2 "$OLD_FILE" >$NEW_FILE
hdfs dfs -put $NEW_FILE /user/w205/hospital_compare

# 3 remove the first line of third file, rename and copy
OLD_FILE="Complications and Deaths - Hospital.csv"
NEW_FILE="readmissions.csv"
tail -n +2 "$OLD_FILE" >$NEW_FILE
hdfs dfs -put $NEW_FILE /user/w205/hospital_compare

# 4 remove the first line of fourth file, rename and copy
OLD_FILE="Measure Dates.csv"
NEW_FILE="Measures.csv"
tail -n +2 "$OLD_FILE" >$NEW_FILE
hdfs dfs -put $NEW_FILE /user/w205/hospital_compare

# 5 remove the first line of fifth file, rename and copy
OLD_FILE="hvbp_hcahps_11_10_2016.csv"
NEW_FILE="surveys_responses.csv"
tail -n +2 "$OLD_FILE" >$NEW_FILE
hdfs dfs -put $NEW_FILE /user/w205/hospital_compare

# change directory back to original
cd $MY_CWD

# clean exit
exit
