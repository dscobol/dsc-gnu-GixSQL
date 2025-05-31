#!/bin/bash

# Program to run
PGM=TSQL001A

# GixSQL Libraries
GIXSQL_HOME="/opt/gixsql"
LOADLIB="$GIXSQL_HOME/lib"
export PATH=$PATH:$GIXSQL_HOME/bin

# Copy Libraries
COBCOPY="../cpy"
SQLCOPY="$GIXSQL_HOME/share/gixsql/copy"

# Remove old versions
rm ../tcbl/$PGM.cbl
rm ../bin/$PGM

# GixSQL Prep and Bind
gixpp -e -S -I $SQLCOPY -I $COBCOPY -i ../cbl/$PGM.sqb -o ../tcbl/$PGM.cbl

# Pause to check the results
read -p "Press any key to resume"

# Compile the program
cobc -x ../tcbl/$PGM.cbl \
  -I $SQLCOPY \
  -I $COBCOPY \
  -L $LOADLIB \
  -l gixsql \
  -o ../bin/$PGM

# Check return code
if [ "$?" -eq 0 ]; then
  echo "SUCCESS: Compile Return code is ZERO."
else
  echo "FAIL: Compile Return code is NOT ZERO."
fi
