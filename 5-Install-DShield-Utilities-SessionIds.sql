USE [DShield]
GO

-- =============================================
-- Title:       SessionId - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Manage SessionIds of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- SessionId - Drop Views
-- =============================================
-- =============================================
-- SessionId - Drop Procedures
-- =============================================
IF OBJECT_ID('[SessionId].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [SessionId].[UpsertText]
GO
IF OBJECT_ID('[SessionId].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [SessionId].[UpsertBinary]
GO

-- =============================================
-- SessionId - Drop Functions
-- =============================================
IF OBJECT_ID('[SessionId].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [SessionId].[ToBinary]
GO
IF OBJECT_ID('[SessionId].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [SessionId].[FromBinary]
GO

-- =============================================
-- SessionId - Drop Tables
-- =============================================

IF OBJECT_ID('[SessionId].[Storage]', 'U') IS NOT NULL
    DROP TABLE [SessionId].[Storage]
GO
-- =============================================
-- SessionId - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'SessionId')
	DROP SCHEMA [SessionId];
GO
CREATE SCHEMA [SessionId]
GO
USE [DShield]
GO

-- =============================================
-- Title:       SessionId Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdManager', 'CoreManager'
	EXEC sp_droprolemember 'SessionIdManager', 'UtilityManager'
	EXEC sp_droprole [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdManager' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdManager', 'CoreManager'
EXEC sp_addrolemember 'SessionIdManager', 'UtilityManager'
GO
-- =============================================
-- Title:       SessionId Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'SessionIdExecutor', 'UtilityExecutor'
	EXEC sp_droprole [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'SessionIdExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       SessionId Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdWriter', 'CoreWriter'
	EXEC sp_droprolemember 'SessionIdWriter', 'UtilityWriter'
	EXEC sp_droprole [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdWriter' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdWriter', 'CoreWriter'
EXEC sp_addrolemember 'SessionIdWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       SessionId Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'SessionIdReader', 'CoreReader'
	EXEC sp_droprolemember 'SessionIdReader', 'UtilityReader'
	EXEC sp_droprole [SessionIdReader];
GO
-- =============================================
-- Title:       SessionId Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'SessionIdReader' AND 
		type = 'R'
		)
	CREATE ROLE [SessionIdReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'SessionIdReader', 'CoreReader'
EXEC sp_addrolemember 'SessionIdReader', 'UtilityReader'
GO


USE [DShield]
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [SessionId].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(16) NOT NULL
);
GO
-- Index on SessionId to prevent duplicates
CREATE INDEX IX_SessionId_Storage_Value ON [SessionId].[Storage]([Value]);
GO



USE [DShield]
GO



-- =============================================
-- Title:       SessionId - Upsert SessionId
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Stored Procedure
-- Description:
--  Upsert a SessionId (Single)
-- =============================================
CREATE PROCEDURE [SessionId].[UpsertBinary] @Value VARBINARY(16),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @SessionBin VARBINARY(16) = [SessionId].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [SessionId].[Storage] 
    WHERE [Value] = @SessionBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [SessionId].[Storage] ([Value]) VALUES (@SessionBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO


-- =============================================
-- Title:       SessionId - Upsert SessionId
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Stored Procedure
-- Description:
--  Upsert a Logged Public Key value (Single)
-- =============================================
CREATE PROCEDURE [SessionId].[UpsertText] @Value VARCHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @SessionIdBin VARBINARY(16) = [SessionId].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [SessionId].[Storage] 
    WHERE [Value] = @SessionIdBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [SessionId].[Storage] ([Value]) VALUES (@SessionIdBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO

-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Scalar Function
-- Description:
--	Accept an MD5 hash/session id and convert 
--  to binary
-- =============================================
CREATE FUNCTION [SessionId].[ToBinary]
(
    @SessionId VARCHAR(32)
)
RETURNS VARBINARY(16)
AS
BEGIN
    -- Convert hex string to binary, removing any non-hex characters
    RETURN CAST('' AS XML).value('xs:hexBinary(sql:variable("@SessionId"))', 'VARBINARY(16)');
END;
GO

-- =============================================
-- Title:		SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Scalar Function
-- Description:
--	Accept a binary representation of an MD5 
--  hash/session id and convert back to varchar/string
-- =============================================

CREATE FUNCTION [SessionId].[FromBinary]
(
    @Binary VARBINARY(16)
)
RETURNS VARCHAR(32)
AS
BEGIN
    -- Convert binary back to lowercase hex string
    RETURN LOWER(
        CAST('' AS XML).value('xs:hexBinary(sql:variable("@Binary"))', 'VARCHAR(32)')
    );
END;
GO


USE [DShield]
GO

-- =============================================
-- DShield Session Id Storage Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		SessionId
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Session Id 
--  Storage table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [SessionId].[Storage] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [SessionId].[Storage] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[SessionId].[Storage] TO [SessionIdExecutor]; 
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdReader]
GO

-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdReader];
GO

-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdReader];
GO


-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdReader]
GO

-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdReader]
GO
