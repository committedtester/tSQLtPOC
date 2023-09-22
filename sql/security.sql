-- https://stackoverflow.com/questions/46551132/unable-to-create-the-tsqltclr-assembly-in-sql-server-2017#:~:text=CREATE%20or%20ALTER%20ASSEMBLY%20for,login%20with%20UNSAFE%20ASSEMBLY%20permission.

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;

EXEC sp_configure 'clr enabled', 1;  
RECONFIGURE;  
GO