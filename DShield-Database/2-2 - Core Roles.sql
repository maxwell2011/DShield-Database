USE [DShield]
GO

-- =============================================
-- Core - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreManager' AND 
		type = 'R'
		)
	CREATE ROLE [CoreManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreWriter' AND 
		type = 'R'
		)
	CREATE ROLE [CoreWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [CoreExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreReader' AND 
		type = 'R'
		)
	CREATE ROLE [CoreReader] 
	AUTHORIZATION db_securityadmin;
GO







-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
--	Add SANS ISC Service Account to CoreReader 
--	role with Read Permissions on Core Schema
-- =============================================
ALTER ROLE [CoreReader]
ADD MEMBER [$(Domain)\sans_isc_svc]
GO



