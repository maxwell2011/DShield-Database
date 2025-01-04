USE [DShield]
GO
-- =============================================
-- Permissions - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsManager' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsReader' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsReader] 
	AUTHORIZATION db_securityadmin;
GO