#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
# accepting command line arguments
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo $targetDirectory
echo $destinationDirectory

# [TASK 3]
# get current timestamp
currentTS=$(date +%s)

# [TASK 4]
backupFileName=backup-$currentTS.tar.gz

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd $destinationDirectory
destDirAbsPath=$(pwd)

# [TASK 7]
cd ..
cd $targetDirectory

# [TASK 8]
yesterdayTS=$(date +%s -d '24 hour ago');

declare -a toBackup

# [TASK 9]
for file in $(ls) 
do
  # [TASK 10]
  # get file last modified date
  file_last_modified_date=$(date -r $file +%s)
  if [[ $file_last_modified_date > $yesterdayTS ]]
  then
    # [TASK 11]
    # add file to backup
    toBackup+=($file)
  fi
done

# [TASK 12]
# archive the file
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13]
# move the archive file to destination folder
mv $backupFileName "$destDirAbsPath"

# Congratulations! You completed the final project for this course!
