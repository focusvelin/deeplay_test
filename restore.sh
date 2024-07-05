#!/bin/bash
backupDir="backup"
dataDir="mongodb_data"

Checking if passed backup file exists
if [ ! -f $1 ]
then
  echo "### There is no such backup file. Check if passed argument is correct ###"
  exit 1
fi

echo "### Stopping containers ###"
docker-compose stop

if [ $? -ne 0 ]
then
  echo "### Error while stopping containers ###"
  exit 1
fi

echo "### Starting restore ###"

#Removing data in dataDir
rm -rf $dataDir/*

#Unarchive backup to dataDir
tar -xzvf $1 -C $dataDir

if [ $? -ne 0 ]
then
  echo "### Error while restoring ###"
  exit 1
fi

echo "### Starting containers ###"
docker-compose start

if [ $? -ne 0 ]
then
  echo "### Error while starting containers ###"
  exit 1
fi

echo "### Mongodb restore has been successfuly completed ###"