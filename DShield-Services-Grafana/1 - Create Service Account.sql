USE [DShield]
GO



-- =============================================
-- Grafana Service Account Setup
-- =============================================

-- =============================================
-- Title:       Login - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a login for the Grafana Service 
--	Account using a Windows user
-- ============================================= 
CREATE LOGIN [$(Domain)\grafana_svc] FROM WINDOWS WITH DEFAULT_DATABASE = DShield
GO
-- =============================================
-- Title:       User - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a user for login using the Grafana
--	Service Account from a Windows user. Assign
--	default Schema as 'Core'
-- ============================================= 
CREATE USER [$(Domain)\grafana_svc]
	FOR LOGIN [$(Domain)\grafana_svc]
	WITH DEFAULT_SCHEMA = [Core]
GO

-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
--	Add Grafana Service Account to CoreReader 
--	role with Read Permissions on Core Schema
-- =============================================
ALTER ROLE [CoreReader]
ADD MEMBER [$(Domain)\grafana_svc]
GO

-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
-- Description:
--	Add Grafana Service Account to UtilityReader 
--	role with Read Permissions on Utility Schemas
-- =============================================
ALTER ROLE [UtilityReader]
ADD MEMBER [$(Domain)\grafana_svc]
GO

-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
-- Description:
--	Enable Server Monitoring in Grafana
-- =============================================
GRANT VIEW SERVER STATE TO [$(Domain)\grafana_svc] AS [sa]
GO