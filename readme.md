GOAL
- To be able to launch a local docker version of SQL server
- To be able to introduce some basic Stored Database Procedures
- TO be able to test those Stored Database Procedures

# Suggested Pre-requisite
Install SQL Server Management Studio or alternate SQL client

# 1. Setup Production and Test Code Examples
Clone the .env.example file to create a .env file. Edit the file to include your SQL Server sa password.
Run "docker-compose up" 
Connect to the SQL Server database using the configuration in the docker-compose.yml file 

NOTE: There are three files, one to restore the database, one to allow for security and one to install tSQLt.
The tSQLt.class.sql was downloaded from https://tsqlt.org/

## 1.1 Stored Procedure
Run the stored procedure using 
```sql
USE [AdventureWorksLT2022]
GO

EXECUTE [dbo].[NorthAmericaBikeCustomers] 
GO
```
## 1.2 Confirm tSQL installation
```sql
USE [AdventureWorksLT2022]
GO

EXEC tSQLt.RunAll
GO
```

# 2. Tests that validate the stored procedure 
Coming next

# Troubleshooting
- For each SQL file there is a corresponding text file with the console output.
- If the installation fails, it may be easier to perform a docker-compose rm, then troubleshoot each SQL execution individually.