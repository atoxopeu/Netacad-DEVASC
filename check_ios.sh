#!/bin/bash
# Before running this script it is necessary to create a subfolder with running config files
# Task: this script to use output from  "show version"
echo "START DEVICE IOS VERSION  CHECK"
REQUIRED_IOS='16.9b'
VERSION_SEARCH_TEXT='version'
OUTPUT_FILE=./check_ios.rep

echo $(date +"%F") >> $OUTPUT_FILE

echo >> $OUTPUT_FILE
echo "STARTING IOS CHECK" >> $OUTPUT_FILE

for f in ios_configs/* 
do 
  #echo "BEGIN -- Processing file $f" >> $OUTPUT_FILE
  cat $f | grep hostname >> $OUTPUT_FILE  
  IOS_VERSION=$(cat $f | grep $VERSION_SEARCH_TEXT | cut -d' ' -f2)
  echo "Current IOS Version: $IOS_VERSION" >> $OUTPUT_FILE
  if [ $REQUIRED_IOS != $IOS_VERSION ]; then
    echo "Upgrade ios version to: $REQUIRED_IOS" >> $OUTPUT_FILE 
  else
    echo "No Upgrade needed"
  fi
  echo >> $OUTPUT_FILE
done
echo "ENDING IOS CHECK" >> $OUTPUT_FILE
