USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FingerprintManager', 'CoreManager'
	EXEC sp_droprolemember 'FingerprintManager', 'UtilityManager'
	EXEC sp_droprole [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintManager' AND 
		type = 'R'
		)
	CREATE ROLE [FingerprintManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FingerprintManager', 'CoreManager'
EXEC sp_addrolemember 'FingerprintManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Fingerprint Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FingerprintExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'FingerprintExecutor', 'UtilityExecutor'
	EXEC sp_droprole [FingerprintExecutor];
GO
-- =============================================
-- Title:       Fingerprint Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [FingerprintExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FingerprintExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'FingerprintExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       Fingerprint Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FingerprintWriter', 'CoreWriter'
	EXEC sp_droprolemember 'FingerprintWriter', 'UtilityWriter'
	EXEC sp_droprole [FingerprintWriter];
GO
-- =============================================
-- Title:       Fingerprint Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintWriter' AND 
		type = 'R'
		)
	CREATE ROLE [FingerprintWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FingerprintWriter', 'CoreWriter'
EXEC sp_addrolemember 'FingerprintWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       Fingerprint Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FingerprintReader', 'CoreReader'
	EXEC sp_droprolemember 'FingerprintReader', 'UtilityReader'
	EXEC sp_droprole [FingerprintReader];
GO
-- =============================================
-- Title:       Fingerprint Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FingerprintReader' AND 
		type = 'R'
		)
	CREATE ROLE [FingerprintReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FingerprintReader', 'CoreReader'
EXEC sp_addrolemember 'FingerprintReader', 'UtilityReader'
GO

