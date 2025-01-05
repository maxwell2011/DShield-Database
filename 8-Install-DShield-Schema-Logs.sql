USE [DShield]
GO

-- =============================================
-- Logs Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================
-- =============================================
-- Logs - Drop Views
-- =============================================
IF OBJECT_ID('[Logs].[LastFirewallLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastFirewallLogDate]
GO
IF OBJECT_ID('[Logs].[LastHoneypotLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastHoneypotLogDate]
GO
IF OBJECT_ID('[Logs].[LastRawSSHLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastRawSSHLogDate]
GO

IF OBJECT_ID('[Logs].[FirewallObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[FirewallObservations]
GO
IF OBJECT_ID('[Logs].[HoneypotObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[HoneypotObservations]
GO
IF OBJECT_ID('[Logs].[RawSSHObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[RawSSHObservations]
GO

IF OBJECT_ID('[Logs].[UrlsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[UrlsObserved]
GO
IF OBJECT_ID('[Logs].[IpAddressesObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[IpAddressesObserved]
GO
IF OBJECT_ID('[Logs].[UserAgentsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[UserAgentsObserved]
GO
IF OBJECT_ID('[Logs].[LoginsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LoginsObserved]
GO
-- =============================================
-- Logs - Drop Procedures
-- =============================================
IF OBJECT_ID('[Logs].[InsertFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertFirewallLogs]
GO
IF OBJECT_ID('[Logs].[GetFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetFirewallLogs]
GO
IF OBJECT_ID('[Logs].[InsertHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertHoneypotLogs]
GO
IF OBJECT_ID('[Logs].[GetHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetHoneypotLogs]
GO
IF OBJECT_ID('[Logs].[InsertRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertRawSSHLogs]
GO
IF OBJECT_ID('[Logs].[GetRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetRawSSHLogs]
GO
-- =============================================
-- Logs - Drop Tables
-- =============================================
IF OBJECT_ID('[Logs].[Firewall]', 'U') IS NOT NULL
  DROP TABLE [Logs].[Firewall]
GO

IF OBJECT_ID('[Logs].[Honeypot]', 'U') IS NOT NULL
  DROP TABLE [Logs].[Honeypot]
GO

IF OBJECT_ID('[Logs].[RawSSH]', 'U') IS NOT NULL
  DROP TABLE [Logs].[RawSSH]
GO

-- =============================================
-- Logs - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Logs')
    DROP SCHEMA [Logs]
GO

CREATE SCHEMA [Logs]
GO

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
USE [DShield]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  Firewall Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Firewall] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2 NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [SourcePort]    INT NOT NULL,
    [TargetID]      BIGINT NOT NULL,
    [TargetPort]    INT NOT NULL,
    [Protocol]      INT NOT NULL,
    CONSTRAINT FK_Logs_Firewall_Source FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Target FOREIGN KEY ([TargetID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Protocol FOREIGN KEY ([Protocol]) 
        REFERENCES [Reference].[Protocols]([Number])
);
CREATE INDEX IX_Logs_Firewall_LogTimestamp 
    ON [Logs].[Firewall]([LogTimestamp]);
CREATE INDEX IX_Logs_Firewall_SourceID 
    ON [Logs].[Firewall]([SourceID]);
GO



USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert Firewall Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertFirewallLogs]
    @Date       DATE,
    @Time       TIME,
    @Source     VARCHAR(45),
    @SourcePort INT,
    @Target     VARCHAR(45),
    @TargetPort INT,
    @Protocol   INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID INT, @TargetID INT;
    DECLARE @LogTimestamp DATETIME2(7);
	-- Correct way to combine date and time into datetime2
    -- Convert using binary concatenation since DATE is 3 bytes and TIME(7) is 6 bytes
    SET @LogTimestamp = CAST(
        CAST(@Time AS BINARY(6)) + 
        CAST(@Date AS BINARY(3)) 
        AS DATETIME2(7)
    );
    -- Get or create Source IP
    EXEC [IPAddress].[UpsertIP] @Source, @SourceID OUTPUT;
    -- Get or create Target IP
    EXEC [IPAddress].[UpsertIP] @Target, @TargetID OUTPUT;
    -- Insert log entry
    INSERT INTO [Logs].[Firewall] (
        [LogTimestamp],
        [SourceID],
        [SourcePort],
        [TargetID],
        [TargetPort],
        [Protocol]
    )
    VALUES (
        @LogTimestamp,
        @SourceID,
        @SourcePort,
        @TargetID,
        @TargetPort,
        @Protocol
    );
END;
GO

-- =============================================
-- Title:       Logs - Get Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Firewall Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetFirewallLogs]
AS
BEGIN
    SELECT 
        FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
        FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time],
        [IPAddress].[FromBinary](src.[Value]) AS [Source],
        fl.[SourcePort],
        [IPAddress].[FromBinary](tgt.[Value]) AS [Target],
        fl.[TargetPort],
        fl.[Protocol]
    FROM [Logs].[Firewall] fl
    JOIN [IPAddress].[Addresses] src ON fl.[SourceID] = src.[Id]
    JOIN [IPAddress].[Addresses] tgt ON fl.[TargetID] = tgt.[Id];
END;
GO


USE [DShield]
GO

-- =============================================
-- Title:       Logs - Last Firewall Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last Firewall Log Date
-- =============================================
CREATE VIEW [Logs].[LastFirewallLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[Firewall]
ORDER BY [LogTimestamp] DESC
GO

-- =============================================
-- Title:       Logs - Firewall Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of Firewall observations
-- =============================================
CREATE VIEW [Logs].[FirewallObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    fl.[SourcePort],
    fl.[TargetPort]
FROM [Logs].[Firewall] fl
JOIN [IPAddress].[Addresses] src ON fl.[SourceID] = src.[Id]
JOIN [IPAddress].[Addresses] tgt ON fl.[TargetID] = tgt.[Id];
GO
USE [DShield]
GO
-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  Honeypot Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Honeypot] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [Count]         INT NOT NULL,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UrlID]         INT NOT NULL,
    [UserAgentID]   INT NOT NULL,
    CONSTRAINT FK_Logs_Honeypot_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Honeypot_UserAgent
        FOREIGN KEY ([UserAgentID]) 
        REFERENCES [Rolodex].[UserAgents]([Id]),
    CONSTRAINT FK_Logs_Honeypot_Url
        FOREIGN KEY ([UrlID]) 
        REFERENCES [Rolodex].[Urls]([Id])
);
CREATE INDEX IX_Logs_Honeypot_LogTimestamp 
    ON [Logs].[Honeypot]([LogTimestamp]);
CREATE INDEX IX_Logs_Honeypot_SourceID 
    ON [Logs].[Honeypot]([SourceID]);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert Honeypot Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertHoneypotLogs]
    @Count INT,
    @Date DATE,
    @Time TIME,
    @Source VARCHAR(45),
    @Url NVARCHAR(2048),
    @UserAgent NVARCHAR(1024)
AS BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID BIGINT;
    DECLARE @UrlID INT;
    DECLARE @UserAgentID INT;
    DECLARE @LogTimestamp datetime2(7);
    -- Combine date and time using binary concatenation
    SET @LogTimestamp = CAST(
        CAST(@Time AS binary(6)) + 
        CAST(@Date AS binary(3)) 
        AS datetime2(7)
    );
    -- Get or create Source IP
    EXEC [IPAddress].[UpsertIP] @Source, @SourceID OUTPUT;
    -- Get or create Url
    EXEC [Rolodex].[UpsertUrl] @Url, @UrlID OUTPUT;
    -- Get or create UserAgent
    EXEC [Rolodex].[UpsertUserAgent] @UserAgent, @UserAgentID OUTPUT;
    INSERT INTO [Logs].[Honeypot] (
        [LogTimestamp],
        [Count],
        [SourceID],
        [UrlID],
        [UserAgentID]
    )
    VALUES (
        @LogTimestamp,
        @Count,
        @SourceID,
        @UrlID,
        @UserAgentID
    );
END;
GO

-- =============================================
-- Title:       Logs - Get Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Honeypot Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetHoneypotLogs]
AS BEGIN
    SELECT 
        FORMAT(hp.[LogTimestamp], 'yyyy-MM-dd') AS [Date],
        FORMAT(hp.[LogTimestamp], 'HH:mm:ss.fffffff') AS [Time],
        hp.[Count],
        [IPAddress].[FromBinary](addr.[Value]) AS [Source],
        u.[Value] AS [Url],
        ua.[Value] AS [UserAgent]
    FROM [Logs].[Honeypot] hp
    JOIN [IPAddress].[Addresses] addr ON hp.[SourceID] = addr.[Id]
    JOIN [Rolodex].[UserAgents] ua ON hp.[UserAgentID] = ua.[Id]
    JOIN [Rolodex].[Urls] u ON hp.[UrlID] = u.[Id];
END;
GO
USE [DShield]
GO

-- =============================================
-- Title:       Logs - Last Honeypot Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last Honeypot Log Date
-- =============================================
CREATE VIEW [Logs].[LastHoneypotLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[Honeypot]
ORDER BY [LogTimestamp] DESC
GO

-- =============================================
-- Title:       Logs - Honeypot Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of Honeypot observations
-- =============================================
CREATE VIEW [Logs].[HoneypotObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    u.[Value] AS [Url],
    ua.[Value] AS [UserAgent]
FROM [Logs].[Honeypot] hp
JOIN [IPAddress].[Addresses] src ON hp.[SourceID] = src.[Id]
JOIN [Rolodex].[UserAgents] ua ON hp.[UserAgentID] = ua.[Id]
JOIN [Rolodex].[Urls] u ON hp.[UrlID] = u.[Id];
GO

-- =============================================
-- Title:       Logs - URL's Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Url's observed by the honeypot
--  and count of occurrences
-- =============================================
CREATE VIEW [Logs].[UrlsObserved] AS
SELECT  
	u.[Value] AS [Url],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [Rolodex].[Urls] u ON h.[UrlID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
GO

-- =============================================
-- Title:       Logs - Addresses Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select IP Addresses observed by the 
--  honeypot and count of occurrences
-- =============================================
CREATE VIEW [Logs].[IpAddressesObserved] AS
SELECT
	[IpAddress].[FromBinary](u.[Value]) AS [IPAddress],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [IPAddress].[Addresses] u ON h.[SourceID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
GO

-- =============================================
-- Title:       Logs - UserAgents Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select User Agents observed by the 
--  honeypot and count of occurrences
-- =============================================
CREATE VIEW [Logs].[UserAgentsObserved] AS
SELECT  
	u.[Value] AS [UserAgent],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [Rolodex].[UserAgents] u ON h.[UserAgentID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
GO
USE [DShield]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  RawSSH Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[RawSSH] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UsernameID]    INT NOT NULL,
    [PasswordID]    INT NOT NULL,
    CONSTRAINT FK_Logs_RawSSH_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Username
        FOREIGN KEY ([UsernameID]) 
        REFERENCES [Rolodex].[Usernames]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Password
        FOREIGN KEY ([PasswordID]) 
        REFERENCES [Rolodex].[Passwords]([Id]),
);
CREATE INDEX IX_Logs_RawSSH_LogTimestamp 
    ON [Logs].[RawSSH]([LogTimestamp]);
CREATE INDEX IX_Logs_RawSSH_SourceID 
    ON [Logs].[RawSSH]([SourceID]);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert RawSSH Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertRawSSHLogs]
    @Date DATE,
    @Time TIME,
    @Source VARCHAR(45),
    @Username NVARCHAR(255),
    @Password NVARCHAR(255)
AS BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID BIGINT;
    DECLARE @UsernameID INT;
    DECLARE @PasswordID INT;
    DECLARE @LogTimestamp datetime2(7);    
    SET @LogTimestamp = CAST(
        CAST(@Time AS binary(6)) + 
        CAST(@Date AS binary(3)) 
        AS DATETIME2(7)
    );
    EXEC [IPAddress].[UpsertIP] @Source, @SourceID OUTPUT;
    EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
    EXEC [Rolodex].[UpsertPassword] @Password, @PasswordID OUTPUT;
    INSERT INTO [Logs].[RawSSH] (
        [LogTimestamp],
        [SourceID],
        [UsernameID],
        [PasswordID]
    )
    VALUES (
        @LogTimestamp,
        @SourceID,
        @UsernameID,
        @PasswordID
    );
END;
GO

-- =============================================
-- Title:       Logs - Get RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Raw SSH Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetRawSSHLogs]
AS BEGIN
    SELECT 
        FORMAT(rs.[LogTimestamp], 'yyyy-MM-dd') as [Date],
        FORMAT(rs.[LogTimestamp], 'HH:mm:ss.fffffff') as [Time],
        [Rolodex].[IPToString](addr.[Value]) as [Source],
        un.[Value] AS [Username],
        pw.[Value] AS [Password]
    FROM [Logs].[RawSSH] rs
    JOIN [IPAddress].[Addresses] addr ON rs.[SourceID] = addr.[Id]
    JOIN [Rolodex].[Usernames] un ON rs.[UsernameID] = un.[Id]
    JOIN [Rolodex].[Passwords] pw ON rs.[PasswordID] = pw.[Id];
END;
GO
USE [DShield]
GO

-- =============================================
-- Title:       Logs - Last RawSSH Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last RawSSH Log Date
-- =============================================
CREATE VIEW [Logs].[LastRawSSHLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[RawSSH]
ORDER BY [LogTimestamp] DESC
GO

-- =============================================
-- Title:       Logs - RawSSH Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of RawSSH observations
-- =============================================
CREATE VIEW [Logs].[RawSSHObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    u.[Value] AS [Username],
    p.[Value] AS [Password]
FROM [Logs].[RawSSH] rs
JOIN [IPAddress].[Addresses] src ON rs.[SourceID] = src.[Id]
JOIN [Rolodex].[Usernames] u ON rs.[UsernameID] = u.[Id]
JOIN [Rolodex].[Passwords] p ON rs.[PasswordID] = p.[Id];
GO

-- =============================================
-- Title:       Logs - UserAgents Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Unique Username/Password 
--  Combinations and count of occurrences
-- =============================================
CREATE VIEW [Logs].[LoginsObserved] AS
SELECT 
    u.[Value] AS [Username],
    p.[Value] AS [Password],
    COUNT(*) AS [Occurrences]
FROM [Logs].[RawSSH] r
JOIN [Rolodex].[Usernames] u ON r.[UsernameID] = u.[Id]
JOIN [Rolodex].[Passwords] p ON r.[PasswordID] = p.[Id]
GROUP BY u.[Value], p.[Value]
HAVING COUNT(*) >= 1
GO
USE [DShield]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Firewall] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Firewall] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Firewall] TO [FirewallLogsExecutor] 
GO

-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Logs].[Firewall] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Honeypot] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Honeypot] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Honeypot] TO [HoneypotLogsExecutor] 
GO

-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Logs].[Honeypot] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[RawSSH] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[RawSSH] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[RawSSH] TO [RawSSHLogsExecutor] 
GO

-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Logs].[RawSSH] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsReader]
GO

