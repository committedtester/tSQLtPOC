USE [AdventureWorksLT2022]
GO

EXEC tSQLt.NewTestClass 'testNorthAmericaBikeCustomers';
GO

CREATE PROCEDURE testNorthAmericaBikeCustomers.[NorthAmericBikeCustomers - Returns a Bike Store With a North America Address]
AS
BEGIN
	IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;


	DECLARE @companyName nvarchar(128); SET @companyName ='Bobs Bikes';
	DECLARE @customerId INT; SET @customerId=1;
	DECLARE @phoneNumber varchar(25); SET @phoneNumber = '123';

------Fake Table
    EXEC tSQLt.FakeTable 'SalesLT', 'Customer';
    INSERT [SalesLT].[Customer] ([CustomerID], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [CompanyName], [SalesPerson], [EmailAddress], [Phone], [PasswordHash], [PasswordSalt], [rowguid], [ModifiedDate]) VALUES (@customerId, 0, N'Mr.', N'Orlando', N'N.', N'Gee', NULL, @companyName, N'adventure-works\pamela0', N'orlando0@adventure-works.com', @phoneNumber, N'L/Rlwxzp4w7RWmEgXX+/A7cXaePEPcp+KwQhl2fJL7w=', N'1KjXYs4=', N'3f5ae95e-b87d-4aed-95b4-c3797afcb74f', CAST(N'2005-08-01T00:00:00.000' AS DateTime))

	EXEC tSQLt.FakeTable 'SalesLT', 'CustomerAddress';
	INSERT [SalesLT].[CustomerAddress] ([CustomerID], [AddressID], [AddressType], [rowguid], [ModifiedDate]) VALUES (@customerId, 1, N'Main Office', N'e26c8c28-a7c3-4ee4-a844-b1430b97aef7', CAST(N'2006-08-01T00:00:00.000' AS DateTime))

	EXEC tSQLt.FakeTable 'SalesLT', 'Address';
	INSERT [SalesLT].[Address] ([AddressID], [AddressLine1], [AddressLine2], [City], [StateProvince], [CountryRegion], [PostalCode], [rowguid], [ModifiedDate]) VALUES (1, N'8713 Yosemite Ct.', NULL, N'Bothell', N'Washington', N'United States', N'98011', N'268af621-76d7-4c78-9441-144fd139821a', CAST(N'2006-07-01T00:00:00.000' AS DateTime))

------Execution
CREATE TABLE actual (
	    CustomerId INT,
	    CompanyName varchar(128),
	    Phone nvarchar(25),
	    BikeStore varchar(128),
	    NorthAmericaAddess varchar(128)
    );
	INSERT INTO actual
EXEC NorthAmericaBikeCustomers;

------Assertion
    CREATE TABLE expected (
	    CustomerId INT,
	    CompanyName varchar(128),
	    Phone nvarchar(25),
	    BikeStore varchar(128),
	    NorthAmericaAddess varchar(128)
    );

	INSERT INTO expected (CustomerId, CompanyName, Phone, BikeStore, NorthAmericaAddess) SELECT @customerId, @companyName,@phoneNumber, 'true','true';

------Assertion
    EXEC tSQLt.AssertEqualsTable expected, actual;
END;
GO