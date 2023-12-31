USE [master]
RESTORE DATABASE [AdventureWorksLT2022] 
FROM  DISK = N'/var/opt/mssql/backup/AdventureWorksLT2022.bak' 
WITH  FILE = 1,  MOVE N'AdventureWorksLT2022_Data' TO N'/var/opt/mssql/data/AdventureWorksLT2022.mdf',  
MOVE N'AdventureWorksLT2022_Log' TO N'/var/opt/mssql/data/AdventureWorksLT2022_log.ldf',  NOUNLOAD,  STATS = 5
GO

USE [AdventureWorksLT2022]
GO

CREATE PROCEDURE [dbo].[NorthAmericaBikeCustomers]
AS

SELECT 
CUS.CustomerID,
CUS.CompanyName,
CUS.Phone,
CASE 
        WHEN CHARINDEX('Bike', CUS.CompanyName) > 0 THEN 'true'
        ELSE 'false'
    END AS BikeStore, 
CASE
        WHEN COUNT(CASE WHEN ADR.CountryRegion LIKE '%United States%' THEN 1 END) > 0
             OR COUNT(CASE WHEN ADR.CountryRegion LIKE '%Canada%' THEN 1 END) > 0
        THEN 'true'
        ELSE 'false'
    END AS NorthAmericaAddress	
  FROM [AdventureWorksLT2022].[SalesLT].[Customer] CUS
  left join [AdventureWorksLT2022].[SalesLT].CustomerAddress CA 
  on CUS.CustomerID=CA.CustomerID
  left join [AdventureWorksLT2022].[SalesLT].[Address] ADR
  on CA.AddressID = ADR.AddressID
GROUP BY CUS.CustomerID,CUS.CompanyName, ADR.CountryRegion, CUS.Phone

GO

USE [AdventureWorksLT2022]
GO

CREATE PROCEDURE [dbo].[DiscontinueBikes]
AS

  DECLARE @currDate DATETIME;
  SET @currDate = convert(datetime,0);

  UPDATE [AdventureWorksLT2022].[SalesLT].[Product] 
  SET DiscontinuedDate=@currDate
  FROM [AdventureWorksLT2022].[SalesLT].[Product] as P
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductModel as PM
  ON P.ProductModelID = PM.ProductModelID
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductModelProductDescription as PMD
  ON PM.ProductModelID = PMD.ProductModelID
  LEFT JOIN [AdventureWorksLT2022].[SalesLT].ProductDescription as PD
  ON PD.ProductDescriptionID = PMD.ProductDescriptionID
  WHERE PD.Description like ('%bike%') 
  AND P.DiscontinuedDate is null

GO



