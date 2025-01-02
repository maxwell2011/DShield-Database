USE [DShield]
GO

-- =============================================
-- Reference - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceManager', 'CoreManager'
	EXEC sp_droprolemember 'ReferenceManager', 'UtilityManager'
	EXEC sp_droprole [ReferenceManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceManager' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceManager] 
	AUTHORIZATION db_securityadmin;

EXEC sp_addrolemember 'ReferenceManager', 'CoreManager'
EXEC sp_addrolemember 'ReferenceManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceWriter', 'CoreWriter'
	EXEC sp_droprolemember 'ReferenceWriter', 'UtilityWriter'
	EXEC sp_droprole [ReferenceWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceWriter' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceWriter', 'CoreWriter'
EXEC sp_addrolemember 'ReferenceWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'ReferenceExecutor', 'UtilityExecutor'
	EXEC sp_droprole [ReferenceExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'ReferenceExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceReader', 'CoreReader'
	EXEC sp_droprolemember 'ReferenceReader', 'UtilityReader'
	EXEC sp_droprole [ReferenceReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceReader' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceReader', 'CoreReader'
EXEC sp_addrolemember 'ReferenceReader', 'UtilityReader'
GO


-- =============================================
-- Title:       IPAddress Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Map Permissions for IPAddress Schema
-- =============================================
EXEC sp_addrolemember 'IPAddressManager', 'ReferenceManager'
EXEC sp_addrolemember 'IPAddressWriter', 'ReferenceWriter'
EXEC sp_addrolemember 'IPAddressExecutor', 'ReferenceExecutor'
EXEC sp_addrolemember 'IPAddressReader', 'ReferenceReader'
GO