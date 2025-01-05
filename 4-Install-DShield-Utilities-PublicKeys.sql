USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Manage PublicKeys of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- PublicKey - Drop Views
-- =============================================
-- =============================================
-- PublicKey - Drop Procedures
-- =============================================
IF OBJECT_ID('[PublicKey].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [PublicKey].[UpsertText]
GO
IF OBJECT_ID('[PublicKey].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [PublicKey].[UpsertBinary]
GO

-- =============================================
-- PublicKey - Drop Functions
-- =============================================
IF OBJECT_ID('[PublicKey].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [PublicKey].[ToBinary]
GO
IF OBJECT_ID('[PublicKey].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [PublicKey].[FromBinary]
GO

-- =============================================
-- PublicKey - Drop Tables
-- =============================================

IF OBJECT_ID('[PublicKey].[Storage]', 'U') IS NOT NULL
    DROP TABLE [PublicKey].[Storage]
GO
-- =============================================
-- PublicKey - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'PublicKey')
	DROP SCHEMA [PublicKey];
GO
CREATE SCHEMA [PublicKey]
GO
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


USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [PublicKey].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(MAX) NOT NULL
);
GO
-- Index on PublicKey to prevent duplicates
--CREATE INDEX IX_PublicKey_Storage_Value ON [PublicKey].[Storage]([Value]);
--GO




USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Upsert PublicKey
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Stored Procedure
-- Description:
--  Upsert a PublicKey (Single)
-- =============================================
CREATE PROCEDURE [PublicKey].[UpsertBinary] @Value VARBINARY(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [PublicKey].[Storage] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [PublicKey].[Storage] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO



-- =============================================
-- Title:       PublicKey - Upsert PublicKey
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Stored Procedure
-- Description:
--  Upsert a Logged Public Key value (Single)
-- =============================================
CREATE PROCEDURE [PublicKey].[UpsertText] @Value VARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @PublicKeyBin VARBINARY(MAX) = [PublicKey].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [PublicKey].[Storage] 
    WHERE [Value] = @PublicKeyBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [PublicKey].[Storage] ([Value]) VALUES (@PublicKeyBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Scalar Function
-- Description:
--	Convert a varchar representation of a public 
--  rsa key from varchar to binary
-- =============================================
CREATE FUNCTION [PublicKey].[ToBinary]
(
    @PublicKey VARCHAR(MAX)
)
RETURNS VARBINARY(MAX)
AS
BEGIN
    -- Remove header and whitespace, then convert to binary
    DECLARE @CleanKey VARCHAR(MAX) = REPLACE(
        SUBSTRING(@PublicKey, 
            CHARINDEX(' ', @PublicKey) + 1, 
            LEN(@PublicKey)),
        ' ', '');
    
    RETURN CAST('' AS XML).value('xs:base64Binary(sql:variable("@CleanKey"))', 'VARBINARY(MAX)');
END;
GO

-- =============================================
-- Title:		PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Scalar Function
-- Description:
--	Convert a binary representation of a 
--  fingerprint back to form 
--  '01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--  from binary
-- =============================================
CREATE FUNCTION [PublicKey].[FromBinary]
(
    @Binary VARBINARY(MAX),
    @KeyType VARCHAR(20)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    RETURN @KeyType + ' ' + 
        CAST('' AS XML).value('xs:base64Binary(sql:variable("@Binary"))', 'VARCHAR(MAX)');
END;
GO


USE [DShield]
GO

-- =============================================
-- DShield PublicKey Storage Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		PublicKey
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the PublicKey 
--  Storage table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [PublicKey].[Storage] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [PublicKey].[Storage] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[PublicKey].[Storage] TO [PublicKeyExecutor]; 
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyReader]
GO

-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyReader];
GO

-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyReader];
GO

-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyReader]
GO

-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyReader]
GO
