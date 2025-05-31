#!/bin/bash

# Program to run
PGM=TSQL001A

# GixSQL Load Libraries
LD_LIBRARY_PATH="/opt/gixsql/lib"


# Export the environment variables in the .env file
export $(grep -v '^#' ../.env | xargs)

# Run it
../bin/$PGM