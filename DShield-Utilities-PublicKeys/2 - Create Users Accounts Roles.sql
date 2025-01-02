USE [DShield]
GO

-- =============================================
-- Title:       PublicKey Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'PublicKeyManager', 'CoreManager'
	EXEC sp_droprolemember 'PublicKeyManager', 'UtilityManager'
	EXEC sp_droprole [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyManager' AND 
		type = 'R'
		)
	CREATE ROLE [PublicKeyManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'PublicKeyManager', 'CoreManager'
EXEC sp_addrolemember 'PublicKeyManager', 'UtilityManager'
GO
-- =============================================
-- Title:       PublicKey Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'PublicKeyExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'PublicKeyExecutor', 'UtilityExecutor'
	EXEC sp_droprole [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [PublicKeyExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'PublicKeyExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'PublicKeyExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       PublicKey Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'PublicKeyWriter', 'CoreWriter'
	EXEC sp_droprolemember 'PublicKeyWriter', 'UtilityWriter'
	EXEC sp_droprole [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyWriter' AND 
		type = 'R'
		)
	CREATE ROLE [PublicKeyWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'PublicKeyWriter', 'CoreWriter'
EXEC sp_addrolemember 'PublicKeyWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       PublicKey Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'PublicKeyReader', 'CoreReader'
	EXEC sp_droprolemember 'PublicKeyReader', 'UtilityReader'
	EXEC sp_droprole [PublicKeyReader];
GO
-- =============================================
-- Title:       PublicKey Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PublicKeyReader' AND 
		type = 'R'
		)
	CREATE ROLE [PublicKeyReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'PublicKeyReader', 'CoreReader'
EXEC sp_addrolemember 'PublicKeyReader', 'UtilityReader'
GO

