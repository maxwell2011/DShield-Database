USE [DShield]
GO

-- =============================================
-- Title:       SessionId Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdManager', 'CoreManager'
	EXEC sp_droprolemember 'SessionIdManager', 'UtilityManager'
	EXEC sp_droprole [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdManager' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdManager', 'CoreManager'
EXEC sp_addrolemember 'SessionIdManager', 'UtilityManager'
GO
-- =============================================
-- Title:       SessionId Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'SessionIdExecutor', 'UtilityExecutor'
	EXEC sp_droprole [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'SessionIdExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       SessionId Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdWriter', 'CoreWriter'
	EXEC sp_droprolemember 'SessionIdWriter', 'UtilityWriter'
	EXEC sp_droprole [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdWriter' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdWriter', 'CoreWriter'
EXEC sp_addrolemember 'SessionIdWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       SessionId Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdReader', 'CoreReader'
	EXEC sp_droprolemember 'SessionIdReader', 'UtilityReader'
	EXEC sp_droprole [SessionIdReader];
GO
-- =============================================
-- Title:       SessionId Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdReader' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdReader', 'CoreReader'
EXEC sp_addrolemember 'SessionIdReader', 'UtilityReader'
GO

