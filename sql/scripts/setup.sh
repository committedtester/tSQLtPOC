/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P ${SA_PASSWORD} -d master -i /sql/setup/restore.sql -o /sql/setup/restore.log;
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P ${SA_PASSWORD} -d master -i /sql/setup/security.sql -o /sql/setup/security.log;
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P ${SA_PASSWORD} -d AdventureWorksLT2022 -i /sql/setup/tSQLt.class.sql -o /sql/setup/tSQLt.class.log;