#!/bin/bash

echo "### Starting rebuild!!! ###"
docker-compose down --volumes
docker-compose up -d

if [ $? -ne 0 ]
then
  echo "### Error while starting containers!!! ###"
  exit 1
fi

echo "### Mongodb rebuild has been successfuly completed!!! ###"
