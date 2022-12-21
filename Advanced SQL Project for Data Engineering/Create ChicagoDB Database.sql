-- =========================================
-- Create Database Called ChicagoDataDB
-- =========================================
USE MASTER
ALTER DATABASE [ChicagoDataDB] SET single_user with rollback immediate


IF EXISTS (
	SELECT name 
		FROM sys.databases
		WHERE name = N'ChicagoDataDB'	
) 
	drop database ChicagoDataDB
GO

CREATE DATABASE ChicagoDataDB

PRINT 'Finished Creating Database'
GO
