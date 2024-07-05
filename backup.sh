#!/bin/bash

backupPath="backup/"
dataPath="mongodb_data/"

#Checking mongo data existence, if not then nothing to backup
if [[ ! -d $dataPath ]]
then
  echo "### No data to backup!!! ###"
  exit 1
fi

#Checking backup directory existence, if not then create one
if [[ ! -d $backupPath ]]
then
  mkdir $backupPath
fi

echo "### Stopping containers ###"
docker-compose stop

echo "### Starting backup ###"
tar -czvf ${backupPath}data_$(date +%Y%m%d)_$(date +%H%M).tar.gz ${dataPath}

if [ $? -ne 0 ]
then
  echo "### Error while backup ###"
  exit 1
fi

echo "### Starting containers ###"
docker-compose start

if [ $? -ne 0 ]
then
  echo "### Error while starting containers ###"
  exit 1
fi

echo "### Mongodb backup has been successfuly completed ###"