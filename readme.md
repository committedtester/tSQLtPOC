GOAL
- To be able to launch a local docker version of SQL server
- To be able to introduce some basic Stored Database Procedures
- TO be able to test those Stored Database Procedures

# Suggested Pre-requisite
Install SQL Server Management Studio or alternate SQL client

# GETTING STARTED
Clone the .env.example file to create a .env file. Edit the file to include your SQL Server sa password.
Run "docker-compose up" 
Connect to the SQL Server database using the configuration in the docker-compose.yml file 

Run the stored procedure using 
```sql
USE [AdventureWorksLT2022]
GO

EXECUTE [dbo].[NorthAmericaBikeCustomers] 
GO
```

# NEXT STEPS
Include https://tsqlt.org/ within code