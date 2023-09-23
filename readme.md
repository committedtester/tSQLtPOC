GOAL
- To be able to launch a local docker version of SQL server
- To be able to introduce some basic Stored Database Procedures
- TO be able to test those Stored Database Procedures with tSQLt

# Suggested Pre-requisite
Install SQL Server Management Studio or alternate SQL client

# 1. Setup Production and Test Code Examples
- Clone the .env.example file to create a .env file. Edit the file to include your SQL Server sa password.
- Run "docker-compose up" 
- Connect to the SQL Server database using the configuration in the docker-compose.yml file 

NOTE: There are three files, one to restore the database, one to allow for security and one to install tSQLt. \
The tSQLt.class.sql was downloaded from https://tsqlt.org/

## 1.1 Stored Procedure
Run the stored procedure using 
```sql
USE [AdventureWorksLT2022]
GO

EXECUTE [dbo].[NorthAmericaBikeCustomers] 
GO
```
## 1.2 Confirm tSQLt installation
```sql
USE [AdventureWorksLT2022]
GO

EXEC tSQLt.RunAll
GO
```
You will see a test being executed against the stored procedure


# 2. tSQLt Tests that validate the stored procedures 
These exist within the sql/tests directory and are within the database as stored procedures.
The NorthAmericaBikeCustomers is a report, so I have used the AssertEqualsTable assertion. 


# Next Steps
Simplify the Test SQL Import so that it can be extended easily with more tests


# Troubleshooting
- For each SQL file there is a corresponding text file with the console output.
- If the installation fails, it may be easier to perform a docker-compose rm, then troubleshoot each SQL execution individually.