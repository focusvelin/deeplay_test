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
BACKUP_FILE=$1
USER=${MONGO_USER}
PASSWORD=${MONGO_PASSWORD}

#Checking if a backup file is provided
if [ -z "${BACKUP_FILE}" ]
then
  echo "### No backup file path was provided!!! ###"
  exit 1
fi

#Checking if backup file exists
if [ ! -f "${BACKUP_FILE}" ]
then
  echo "### Provided backup file doesn't exists!!! ###"
fi

#Checking if container exists and running
if [ -z `docker-compose ps -q ${CONTAINER_NAME}` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q ${CONTAINER_NAME})` ]
then
  echo "### Mongodb container is not running!!! ###"
  exit 1
fi

echo "### Starting data restore ###"
docker exec -i ${CONTAINER_NAME} mongorestore --username ${USER} --password ${PASSWORD} --archive < ${BACKUP_FILE}

if [ $? -ne 0 ]
then
  echo "### Error while restoring!!! ###"
  exit 1
fi

echo "### Mongodb backup has been successfuly completed!!! ###"
