USE [DShield]
GO

-- =============================================
-- Title:       Users - Orphaned
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Detect and display orphaned users in the
--	local database
-- Note:
--	Instructions for resolving orphaned users
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server?view=sql-server-ver16
-- =============================================
CREATE VIEW [Utility].[OrphanedUsers] AS
	SELECT 
		dp.type_desc, 
		dp.sid, 
		dp.name AS user_name  
	FROM sys.database_principals AS dp  
		LEFT JOIN sys.server_principals AS sp 
			ON dp.sid = sp.sid  
	WHERE 
		sp.sid IS NULL AND 
		dp.authentication_type_desc = 'INSTANCE';  
GO





-- =============================================
-- Title:       Users - Guest User
-- Author:		Microsoft
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Detect if guest user is enabled and
--	configured in the current database
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[GuestUser] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.name = 'guest' AND 
		perms.permission_name = 'CONNECT';

GO

-- =============================================
-- Title:       Users - View Column Encryption
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to view any column
--	encryption key definition. Or, which users in the 
--	current scope possess the VWCK permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type IN ('U','S') AND
		perms.permission_name = 'VIEW ANY COLUMN ENCRYPTION KEY DEFINITION';
GO

-- =============================================
-- Title:       Roles - View Column Encryption
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to view any column
--	encryption key definition. Or, which roles in the 
--	current scope possess the VWCK permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN ENCRYPTION KEY DEFINITION';
GO

-- =============================================
-- Title:       Users - Connect
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to connect. 
--	Or, which users in the current scope
--	possess the CO permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithConnect] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type IN ('U','S') AND
		perms.permission_name = 'CONNECT';
GO

-- =============================================
-- Title:       Roles - Connect
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to connect. 
--	Or, which roles in the current scope
--	possess the CO permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithConnect] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'CONNECT';
GO

-- =============================================
-- Title:       Users - View Column Master
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to view any column
--	master key definition. Or, which users in the 
--	current scope possess the VWCM permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithViewAnyColumnMasterKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN MASTER KEY DEFINITION';
GO

-- =============================================
-- Title:       Roles - View Column Master
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to view any column
--	master key definition. Or, which roles in the 
--	current scope possess the VWCM permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithViewAnyColumnMasterKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN MASTER KEY DEFINITION';
GO
