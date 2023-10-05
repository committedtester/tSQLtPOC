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
You will see tests being executed


# 2. tSQLt Tests that validate the stored procedures 
These exist within the sql/tests directory and are within the database as stored procedures.
The NorthAmericaBikeCustomers is a report, so I have used the AssertEqualsTable assertion. 


# 3. tSQLt limitation - https://github.com/tSQLt-org/tSQLt/issues/17
Within the database there is a Stored Procedure called 'Discontinue Bikes'.
This will update any Product that has a description that contains a bike. 
To see these records, run this SQL

```sql
SELECT P.*,PD.*
  FROM [AdventureWorksLT2022].[SalesLT].[Product] as P
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductModel as PM
  ON P.ProductModelID = PM.ProductModelID
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductModelProductDescription as PMD
  ON PM.ProductModelID = PMD.ProductModelID
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductDescription as PD
  ON PD.ProductDescriptionID = PMD.ProductDescriptionID
  WHERE PD.Description like ('%bike%')
    AND P.DiscontinuedDate is null
```

The difficulty is that there are dependencies on the SalesLT.Product table which will prevent the renaming of the original tables.

You will need to run
```sql
DROP TRIGGER [SalesLT].[iduSalesOrderDetail]
DROP VIEW [SalesLT].[vProductAndDescription 
```
And then rerun
```sql
USE [AdventureWorksLT2022]
GO

EXEC tSQLt.RunAll
GO
```

# Troubleshooting
- For each SQL file there is a corresponding text file with the console output.
- If the installation fails, it may be easier to perform a docker-compose rm, then troubleshoot each SQL execution individually.
- Each test is a stored procedure. After the schema, the test must have a prefix of 'test' to be picked up by the test runner
- Each test needs to be invoked in a transaction if you wish to use the fakeTable procedure. YOu cannot run the test stored procedure in isolation if you want those tables to be reverted back. You have to run them via the RunAll function