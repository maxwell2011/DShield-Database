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
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityManager' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityWriter' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityReader' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityReader] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Login - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a login for the SANS ISC Service 
--	Account using a Windows user
-- ============================================= 
CREATE LOGIN [$(Domain)\sans_isc_svc] FROM WINDOWS WITH DEFAULT_DATABASE = DShield
GO
-- =============================================
-- Title:       User - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a user for login using the SANS ISC 
--	Service Account from a Windows user. Assign
--	default Schema as 'Core'
-- ============================================= 
CREATE USER [$(Domain)\sans_isc_svc]
	FOR LOGIN [$(Domain)\sans_isc_svc]
	WITH DEFAULT_SCHEMA = [Core]
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

-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
-- Description:
--	Add SANS ISC Service Account to UtilityReader 
--	role with Read Permissions on Utility Schemas
-- =============================================
ALTER ROLE [UtilityReader]
ADD MEMBER [$(Domain)\sans_isc_svc]
GO

