USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--	Manage Rolodex of various important
--  identifiers such as IP Addresses, providers
--  usernames, etc, etc
-- =============================================

-- =============================================
-- Rolodex - Drop Views
-- =============================================

-- =============================================
-- Rolodex - Drop Functions
-- =============================================

-- =============================================
-- Rolodex - Drop Procedures
-- =============================================
IF OBJECT_ID('[Rolodex].[UpsertSSHClientVersion]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertSSHClientVersion]
GO
IF OBJECT_ID('[Rolodex].[UpsertUrl]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUrl]
GO
IF OBJECT_ID('[Rolodex].[UpsertPassword]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertPassword]
GO
IF OBJECT_ID('[Rolodex].[UpsertUsername]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUsername]
GO
IF OBJECT_ID('[Rolodex].[UpsertUserAgent]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUserAgent]
GO
IF OBJECT_ID('[Rolodex].[UpsertHassh]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertHassh]
GO
-- =============================================
-- Rolodex - Drop Tables
-- =============================================
IF OBJECT_ID('[Rolodex].[SSHClientVersions]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[SSHClientVersions]
GO
IF OBJECT_ID('[Rolodex].[Urls]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Urls]
GO
IF OBJECT_ID('[Rolodex].[Passwords]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Passwords]
GO
IF OBJECT_ID('[Rolodex].[Usernames]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Usernames]
GO
IF OBJECT_ID('[Rolodex].[UserAgents]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[UserAgents]
GO
IF OBJECT_ID('[Rolodex].[Hassh]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Hassh]
GO
-- =============================================
-- Rolodex - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Rolodex')
    DROP SCHEMA [Rolodex]
GO

CREATE SCHEMA [Rolodex]
GO

USE [DShield]
GO

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexManager' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexManager] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexExecutor] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexWriter' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexWriter] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexReader' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexReader] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       IPAddress Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for IPAddress Schema
-- =============================================
EXEC sp_addrolemember 'IPAddressManager', 'RolodexManager'
EXEC sp_addrolemember 'IPAddressWriter', 'RolodexWriter'
EXEC sp_addrolemember 'IPAddressExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'IPAddressReader', 'RolodexReader'
GO

-- =============================================
-- Title:       Fingerprints Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'FingerprintManager', 'RolodexManager'
EXEC sp_addrolemember 'FingerprintWriter', 'RolodexWriter'
EXEC sp_addrolemember 'FingerprintExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'FingerprintReader', 'RolodexReader'
GO

-- =============================================
-- Title:       PublicKeys Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'PublicKeyManager', 'RolodexManager'
EXEC sp_addrolemember 'PublicKeyWriter', 'RolodexWriter'
EXEC sp_addrolemember 'PublicKeyExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'PublicKeyReader', 'RolodexReader'
GO

-- =============================================
-- Title:       Reference Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'ReferenceManager', 'RolodexManager'
EXEC sp_addrolemember 'ReferenceWriter', 'RolodexWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'RolodexReader'
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique User Agents (All)
-- =============================================
CREATE TABLE [Rolodex].[UserAgents] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(1023) NOT NULL,
	CONSTRAINT UQ_Rolodex_UserAgents_Agent UNIQUE ([Value])
);
-- Index on Agent to prevent duplicates
CREATE INDEX IX_Rolodex_UserAgents_Agent ON [Rolodex].[UserAgents]([Value]);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert UserAgent
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a User Agent (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUserAgent] @Value NVARCHAR(1023),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing User Agent
    SELECT @ID = [Id] 
    FROM [Rolodex].[UserAgents] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[UserAgents] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Rolodex User Agents Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Rolodex
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  User Agents table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[UserAgents] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique Usernames observed in the wild
-- =============================================
CREATE TABLE [Rolodex].[Usernames] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(255) NOT NULL
);
GO
-- Index on Username to prevent duplicates
CREATE INDEX IX_Rolodex_Usernames_Username ON [Rolodex].[Usernames]([Value]);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert Username
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Username (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUsername] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Usernames] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Usernames] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Rolodex Usernames Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Rolodex
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Rolodex 
--  Usernames table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[Usernames] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Store Passwords observed in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Passwords] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(255) NOT NULL
);
GO
-- Index on Username to prevent duplicates
CREATE INDEX IX_Rolodex_Passwords_Password ON [Rolodex].[Passwords]([Value]);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert Password
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Password (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertPassword] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Passwords] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Passwords] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Rolodex Passwords Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Rolodex
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Rolodex 
--  Passwords table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[Passwords] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique Urls Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Urls] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(2048) NOT NULL
);
GO

USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Upsert Url
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Url (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUrl] @Value NVARCHAR(2048),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Urls] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Urls] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Rolodex Urls Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Rolodex
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Rolodex 
--  Urls table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[Urls] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[SSHClientVersions] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(1023) NOT NULL UNIQUE
);
GO

USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Upsert SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a SSHClientVersions (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertSSHClientVersion] @Value NVARCHAR(1023),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[SSHClientVersions] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[SSHClientVersions] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Rolodex SSH Client Versions Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Rolodex
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Rolodex 
--  SSH Client Versions table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[SSHClientVersions] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Hassh] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	CHAR(32) NOT NULL UNIQUE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Hasshs (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertHassh] @Value CHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Hassh] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Hassh] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Reference Passwords Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Passwords table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Rolodex].[Passwords] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[UserAgents] TO [RolodexManager]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[UserAgents] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[UserAgents] TO [RolodexExecutor] 
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[UserAgents] TO [RolodexReader]
GO


-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Usernames] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Usernames] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Passwords] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Passwords] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Passwords] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[Passwords] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Urls] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Urls] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Urls] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[Urls] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[SSHClientVersions] TO [RolodexManager]
GO
-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[SSHClientVersions] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[SSHClientVersions] TO [RolodexExecutor] 
GO

-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[SSHClientVersions] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Hassh] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Hassh] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Hassh] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[Hassh] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexReader]
GO

