USE [DShield]
GO

-- =============================================
-- Logs - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'LogsManager', 'CoreManager'
	EXEC sp_droprolemember 'LogsManager', 'UtilityManager'
	EXEC sp_droprole [LogsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsManager' AND 
		type = 'R'
		)
	CREATE ROLE [LogsManager] 
	AUTHORIZATION db_securityadmin;

EXEC sp_addrolemember 'LogsManager', 'CoreManager'
EXEC sp_addrolemember 'LogsManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'LogsWriter', 'CoreWriter'
	EXEC sp_droprolemember 'LogsWriter', 'UtilityWriter'
	EXEC sp_droprole [LogsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [LogsWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'LogsWriter', 'CoreWriter'
EXEC sp_addrolemember 'LogsWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'LogsExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'LogsExecutor', 'UtilityExecutor'
	EXEC sp_droprole [LogsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [LogsExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'LogsExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'LogsExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'LogsReader', 'CoreReader'
	EXEC sp_droprolemember 'LogsReader', 'UtilityReader'
	EXEC sp_droprole [LogsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'LogsReader' AND 
		type = 'R'
		)
	CREATE ROLE [LogsReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'LogsReader', 'CoreReader'
EXEC sp_addrolemember 'LogsReader', 'UtilityReader'
GO

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FirewallLogsManager', 'LogsManager'
	EXEC sp_droprolemember 'FirewallLogsManager', 'CoreManager'
	EXEC sp_droprolemember 'FirewallLogsManager', 'UtilityManager'
	EXEC sp_droprole [FirewallLogsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsManager' AND 
		type = 'R'
		)
	CREATE ROLE [FirewallLogsManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FirewallLogsManager', 'LogsManager'
EXEC sp_addrolemember 'FirewallLogsManager', 'CoreManager'
EXEC sp_addrolemember 'FirewallLogsManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FirewallLogsWriter', 'LogsWriter'
	EXEC sp_droprolemember 'FirewallLogsWriter', 'CoreWriter'
	EXEC sp_droprolemember 'FirewallLogsWriter', 'UtilityWriter'
	EXEC sp_droprole [FirewallLogsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [FirewallLogsWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FirewallLogsWriter', 'LogsWriter'
EXEC sp_addrolemember 'FirewallLogsWriter', 'CoreWriter'
EXEC sp_addrolemember 'FirewallLogsWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FirewallLogsExecutor', 'LogsExecutor'
	EXEC sp_droprolemember 'FirewallLogsExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'FirewallLogsExecutor', 'UtilityExecutor'
	EXEC sp_droprole [FirewallLogsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [FirewallLogsExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FirewallLogsExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'FirewallLogsExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'FirewallLogsExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'FirewallLogsReader', 'LogsReader'
	EXEC sp_droprolemember 'FirewallLogsReader', 'CoreReader'
	EXEC sp_droprolemember 'FirewallLogsReader', 'UtilityReader'
	EXEC sp_droprole [FirewallLogsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'FirewallLogsReader' AND 
		type = 'R'
		)
	CREATE ROLE [FirewallLogsReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'FirewallLogsReader', 'LogsReader'
EXEC sp_addrolemember 'FirewallLogsReader', 'CoreReader'
EXEC sp_addrolemember 'FirewallLogsReader', 'UtilityReader'
GO

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'HoneypotLogsManager', 'LogsManager'
	EXEC sp_droprolemember 'HoneypotLogsManager', 'CoreManager'
	EXEC sp_droprolemember 'HoneypotLogsManager', 'UtilityManager'
	EXEC sp_droprole [HoneypotLogsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsManager' AND 
		type = 'R'
		)
	CREATE ROLE [HoneypotLogsManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'HoneypotLogsManager', 'LogsManager'
EXEC sp_addrolemember 'HoneypotLogsManager', 'CoreManager'
EXEC sp_addrolemember 'HoneypotLogsManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'HoneypotLogsWriter', 'LogsWriter'
	EXEC sp_droprolemember 'HoneypotLogsWriter', 'CoreWriter'
	EXEC sp_droprolemember 'HoneypotLogsWriter', 'UtilityWriter'
	EXEC sp_droprole [HoneypotLogsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [HoneypotLogsWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'HoneypotLogsWriter', 'LogsWriter'
EXEC sp_addrolemember 'HoneypotLogsWriter', 'CoreWriter'
EXEC sp_addrolemember 'HoneypotLogsWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'HoneypotLogsExecutor', 'LogsExecutor'
	EXEC sp_droprolemember 'HoneypotLogsExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'HoneypotLogsExecutor', 'UtilityExecutor'
	EXEC sp_droprole [HoneypotLogsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [HoneypotLogsExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'HoneypotLogsExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'HoneypotLogsExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'HoneypotLogsExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'HoneypotLogsReader', 'LogsReader'
	EXEC sp_droprolemember 'HoneypotLogsReader', 'CoreReader'
	EXEC sp_droprolemember 'HoneypotLogsReader', 'UtilityReader'
	EXEC sp_droprole [HoneypotLogsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'HoneypotLogsReader' AND 
		type = 'R'
		)
	CREATE ROLE [HoneypotLogsReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'HoneypotLogsReader', 'LogsReader'
EXEC sp_addrolemember 'HoneypotLogsReader', 'CoreReader'
EXEC sp_addrolemember 'HoneypotLogsReader', 'UtilityReader'
GO

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'RawSSHLogsManager', 'LogsManager'
	EXEC sp_droprolemember 'RawSSHLogsManager', 'CoreManager'
	EXEC sp_droprolemember 'RawSSHLogsManager', 'UtilityManager'
	EXEC sp_droprole [RawSSHLogsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsManager' AND 
		type = 'R'
		)
	CREATE ROLE [RawSSHLogsManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'RawSSHLogsManager', 'LogsManager'
EXEC sp_addrolemember 'RawSSHLogsManager', 'CoreManager'
EXEC sp_addrolemember 'RawSSHLogsManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'RawSSHLogsWriter', 'LogsWriter'
	EXEC sp_droprolemember 'RawSSHLogsWriter', 'CoreWriter'
	EXEC sp_droprolemember 'RawSSHLogsWriter', 'UtilityWriter'
	EXEC sp_droprole [RawSSHLogsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [RawSSHLogsWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'RawSSHLogsWriter', 'LogsWriter'
EXEC sp_addrolemember 'RawSSHLogsWriter', 'CoreWriter'
EXEC sp_addrolemember 'RawSSHLogsWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'RawSSHLogsExecutor', 'LogsExecutor'
	EXEC sp_droprolemember 'RawSSHLogsExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'RawSSHLogsExecutor', 'UtilityExecutor'
	EXEC sp_droprole [RawSSHLogsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [RawSSHLogsExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'RawSSHLogsExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'RawSSHLogsExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'RawSSHLogsExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'RawSSHLogsReader', 'LogsReader'
	EXEC sp_droprolemember 'RawSSHLogsReader', 'CoreReader'
	EXEC sp_droprolemember 'RawSSHLogsReader', 'UtilityReader'
	EXEC sp_droprole [RawSSHLogsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RawSSHLogsReader' AND 
		type = 'R'
		)
	CREATE ROLE [RawSSHLogsReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'RawSSHLogsReader', 'LogsReader'
EXEC sp_addrolemember 'RawSSHLogsReader', 'CoreReader'
EXEC sp_addrolemember 'RawSSHLogsReader', 'UtilityReader'
GO



-- =============================================
-- Title:       Reference Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Map Permissions for Reference Schema
-- =============================================
EXEC sp_addrolemember 'ReferenceManager', 'LogsManager'
EXEC sp_addrolemember 'ReferenceWriter', 'LogsWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'LogsReader'

EXEC sp_addrolemember 'ReferenceWriter', 'HoneypotLogsWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'HoneypotLogsExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'HoneypotLogsReader'

EXEC sp_addrolemember 'ReferenceWriter', 'RawSSHLogsWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'RawSSHLogsExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'RawSSHLogsReader'

EXEC sp_addrolemember 'ReferenceWriter', 'FirewallLogsWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'FirewallLogsExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'FirewallLogsReader'
GO

-- =============================================
-- Title:       Rolodex Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Map Permissions for Rolodex Schema
-- =============================================
EXEC sp_addrolemember 'RolodexManager', 'LogsManager'
EXEC sp_addrolemember 'RolodexWriter', 'LogsWriter'
EXEC sp_addrolemember 'RolodexExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'RolodexReader', 'LogsReader'

EXEC sp_addrolemember 'RolodexWriter', 'HoneypotLogsWriter'
EXEC sp_addrolemember 'RolodexExecutor', 'HoneypotLogsExecutor'
EXEC sp_addrolemember 'RolodexReader', 'HoneypotLogsReader'

EXEC sp_addrolemember 'RolodexWriter', 'RawSSHLogsWriter'
EXEC sp_addrolemember 'RolodexExecutor', 'RawSSHLogsExecutor'
EXEC sp_addrolemember 'RolodexReader', 'RawSSHLogsReader'

EXEC sp_addrolemember 'RolodexWriter', 'FirewallLogsWriter'
EXEC sp_addrolemember 'RolodexExecutor', 'FirewallLogsExecutor'
EXEC sp_addrolemember 'RolodexReader', 'FirewallLogsReader'
GO

-- =============================================
-- Title:       SessionId Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Role
-- Description:
--	Map Permissions for SessionId Schema
-- =============================================
EXEC sp_addrolemember 'SessionIdManager', 'LogsManager'
EXEC sp_addrolemember 'SessionIdWriter', 'LogsWriter'
EXEC sp_addrolemember 'SessionIdExecutor', 'LogsExecutor'
EXEC sp_addrolemember 'SessionIdReader', 'LogsReader'

EXEC sp_addrolemember 'SessionIdWriter', 'HoneypotLogsWriter'
EXEC sp_addrolemember 'SessionIdExecutor', 'HoneypotLogsExecutor'
EXEC sp_addrolemember 'SessionIdReader', 'HoneypotLogsReader'

EXEC sp_addrolemember 'SessionIdWriter', 'RawSSHLogsWriter'
EXEC sp_addrolemember 'SessionIdExecutor', 'RawSSHLogsExecutor'
EXEC sp_addrolemember 'SessionIdReader', 'RawSSHLogsReader'

EXEC sp_addrolemember 'SessionIdWriter', 'FirewallLogsWriter'
EXEC sp_addrolemember 'SessionIdExecutor', 'FirewallLogsExecutor'
EXEC sp_addrolemember 'SessionIdReader', 'FirewallLogsReader'

GO