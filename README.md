# MongoDB with AdminMongo

This project sets up a MongoDB database container and an AdminMongo container for database administration. It also includes scripts for backing up, restoring, and rebuilding the MongoDB database.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Scripts](#scripts)
  - [Backup](#backup)
  - [Restore](#restore)
  - [Rebuild](#rebuild)
- [Configuration](#configuration)
- [Project Structure](#project-structure)

## Features

- MongoDB container for database storage.
- AdminMongo container for database management.
- Backup, restore, and rebuild scripts for database maintenance.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Docker](https://docs.docker.com/get-docker/) installed on your machine.
- [Docker Compose](https://docs.docker.com/compose/install/) installed on your machine.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/focusvelin/deeplay_test.git
   cd deeplay_test
   ```
2. Adjust environment variables in '.env' file or leave it to default values.

## Usage

1. Start the containers:
   ```
   docker-compose up -d
   ```
2. Access AdminMongo at
   `http://localhost:1234` (or the port you have configured). If you're starting containers in VM then you need to specify its ip address in URL
3. To stop the containers:
   ```
   docker-compose down
   ```

## Scripts
### Backup
The backup script creates a backup of the MongoDB database.
   ```
   ./backup.sh
   ```
### Restore
The restore script restores the MongoDB database from a backup.
   ```
   ./restore.sh /path/to/backup
   ```
### Rebuild
The rebuild script stops the containers, removes them, and then rebuilds and starts them again.

## Configuration
The main configuration file is 'docker-compose.yml'. You can adjust the settings  for each service, including port mappings, environment variables, and volumes.
### Environment variables
You can configure environment variables in the '.env' file. Here are variables:
- `MONGO_CONTAINER_NAME`
- `MONGO_DATABASE_NAME`
- `MONGO_USER`
- `MONGO_PASSWORD`
- `MONGO_PORT`
- `ADMIN_CONTAINER_NAME`
- `ADMINMONGO_PORT`

## Project structure
```
deeplay_test/
│
├── backup.sh
├── restore.sh
├── rebuild.sh
├── backup/
│   └── ... (MongoDB backup files)
├── .env
├── docker-compose.yml
└── README.md
```
