#!/bin/bash

for sqlFile in /sql/tests/*.sql;
      do 
      /opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P ${SA_PASSWORD} -d AdventureWorksLT2022 -i $sqlFile -o $sqlFile.log;
      done 

exec "$@"





