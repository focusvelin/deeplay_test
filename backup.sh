#!/bin/bash

#Checking if .env file exists
if [ ! -f .env ]
then
  echo "### .env file doesn't exist!!! You need to create one in order to pass credentials to the script ###"
  exit 1
fi

#Exporting env variables
export $(cat .env)

#Defining variables
CONTAINER_NAME="mongodb"
BACKUP_DIR="./backup"
USER=${MONGO_USER}
PASSWORD=${MONGO_PASSWORD}

#Checking if container exists and running
if [ -z `docker-compose ps -q ${CONTAINER_NAME}` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q ${CONTAINER_NAME})` ]
then
  echo "### Mongodb container is not running ###"
  exit 1
fi

#Create backup directory if doesn't exist
mkdir -p ${BACKUP_DIR}

echo "### Starting backup ###"
docker exec ${CONTAINER_NAME} mongodump --username ${USER} --password ${PASSWORD} --archive > ${BACKUP_DIR}/data_$(date +%Y%m%d)_$(date +%H%M).gz

if [ $? -ne 0 ]
then
  echo "### Error while backup ###"
  exit 1
fi

echo "### Mongodb backup has been successfuly completed ###"
