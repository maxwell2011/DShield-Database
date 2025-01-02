USE [DShield]
GO

-- =============================================
-- Title:       IPAddress Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressManager', 'CoreManager'
	EXEC sp_droprolemember 'IPAddressManager', 'UtilityManager'
	EXEC sp_droprole [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressManager' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressManager', 'CoreManager'
EXEC sp_addrolemember 'IPAddressManager', 'UtilityManager'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'IPAddressExecutor', 'UtilityExecutor'
	EXEC sp_droprole [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'IPAddressExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressWriter', 'CoreWriter'
	EXEC sp_droprolemember 'IPAddressWriter', 'UtilityWriter'
	EXEC sp_droprole [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressWriter' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressWriter', 'CoreWriter'
EXEC sp_addrolemember 'IPAddressWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressReader', 'CoreReader'
	EXEC sp_droprolemember 'IPAddressReader', 'UtilityReader'
	EXEC sp_droprole [IPAddressReader];
GO
-- =============================================
-- Title:       IPAddress Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressReader' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressReader', 'CoreReader'
EXEC sp_addrolemember 'IPAddressReader', 'UtilityReader'
GO
