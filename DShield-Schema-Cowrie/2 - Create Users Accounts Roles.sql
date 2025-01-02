USE [DShield]
GO

-- =============================================
-- Cowrie - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'CowrieManager', 'CoreManager'
	EXEC sp_droprolemember 'CowrieManager', 'UtilityManager'
	EXEC sp_droprole [CowrieManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieManager' AND 
		type = 'R'
		)
	CREATE ROLE [CowrieManager] 
	AUTHORIZATION db_securityadmin;

EXEC sp_addrolemember 'CowrieManager', 'CoreManager'
EXEC sp_addrolemember 'CowrieManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'CowrieWriter', 'CoreWriter'
	EXEC sp_droprolemember 'CowrieWriter', 'UtilityWriter'
	EXEC sp_droprole [CowrieWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieWriter' AND 
		type = 'R'
		)
	CREATE ROLE [CowrieWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'CowrieWriter', 'CoreWriter'
EXEC sp_addrolemember 'CowrieWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'CowrieExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'CowrieExecutor', 'UtilityExecutor'
	EXEC sp_droprole [CowrieExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [CowrieExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'CowrieExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'CowrieExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'CowrieReader', 'CoreReader'
	EXEC sp_droprolemember 'CowrieReader', 'UtilityReader'
	EXEC sp_droprole [CowrieReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CowrieReader' AND 
		type = 'R'
		)
	CREATE ROLE [CowrieReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'CowrieReader', 'CoreReader'
EXEC sp_addrolemember 'CowrieReader', 'UtilityReader'
GO




-- =============================================
-- Title:       Reference Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Map Permissions for Reference Schema
-- =============================================
EXEC sp_addrolemember 'ReferenceManager', 'CowrieManager'
EXEC sp_addrolemember 'ReferenceWriter', 'CowrieWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'CowrieExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'CowrieReader'

GO

-- =============================================
-- Title:       Rolodex Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Map Permissions for Rolodex Schema
-- =============================================
EXEC sp_addrolemember 'RolodexManager', 'CowrieManager'
EXEC sp_addrolemember 'RolodexWriter', 'CowrieWriter'
EXEC sp_addrolemember 'RolodexExecutor', 'CowrieExecutor'
EXEC sp_addrolemember 'RolodexReader', 'CowrieReader'

GO

-- =============================================
-- Title:       SessionId Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Role
-- Description:
--	Map Permissions for SessionId Schema
-- =============================================
EXEC sp_addrolemember 'SessionIdManager', 'CowrieManager'
EXEC sp_addrolemember 'SessionIdWriter', 'CowrieWriter'
EXEC sp_addrolemember 'SessionIdExecutor', 'CowrieExecutor'
EXEC sp_addrolemember 'SessionIdReader', 'CowrieReader'

GO