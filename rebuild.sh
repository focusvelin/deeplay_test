#!/bin/bash

dataDir="mongodb_data"

echo "### Deleting containers ###"
docker-compose down --volume

if [ $? -ne 0 ]
then
  echo "### Error while stopping containers ###"
  exit 1
fi

#Removing data in dataDir
rm -rf $dataDir/*

echo "### Starting containers ###"
docker-compose up -d

if [ $? -ne 0 ]
then
  echo "### Error while starting containers ###"
  exit 1
fi

echo "### Mongodb rebuild has been successfuly completed ###"