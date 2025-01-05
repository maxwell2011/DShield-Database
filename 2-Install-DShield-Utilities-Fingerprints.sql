USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Manage Fingerprints of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- Fingerprint - Drop Views
-- =============================================
-- =============================================
-- Fingerprint - Drop Procedures
-- =============================================
IF OBJECT_ID('[Fingerprint].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [Fingerprint].[UpsertText]
GO
IF OBJECT_ID('[Fingerprint].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [Fingerprint].[UpsertBinary]
GO

-- =============================================
-- Fingerprint - Drop Functions
-- =============================================
IF OBJECT_ID('[Fingerprint].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [Fingerprint].[ToBinary]
GO
IF OBJECT_ID('[Fingerprint].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [Fingerprint].[FromBinary]
GO

-- =============================================
-- Fingerprint - Drop Tables
-- =============================================

IF OBJECT_ID('[Fingerprint].[Storage]', 'U') IS NOT NULL
    DROP TABLE [Fingerprint].[Storage]
GO
-- =============================================
-- Fingerprint - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Fingerprint')
	DROP SCHEMA [Fingerprint];
GO
CREATE SCHEMA [Fingerprint]
GO
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


USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Table
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [Fingerprint].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(16) NOT NULL UNIQUE
);
GO
-- Index on Fingerprint to prevent duplicates
CREATE INDEX IX_Fingerprint_Storage_Value ON [Fingerprint].[Storage]([Value]);
GO

USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Upsert Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Stored Procedure
-- Description:
--  Upsert a Fingerprint (Single)
-- =============================================
CREATE PROCEDURE [Fingerprint].[UpsertBinary] @Value VARBINARY(16),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Fingerprint].[Storage] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Fingerprint].[Storage] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO


-- =============================================
-- Title:       Fingerprint - Upsert Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Stored Procedure
-- Description:
--  Upsert a Fingerprint (Single)
-- =============================================
CREATE PROCEDURE [Fingerprint].[UpsertText] @Value CHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @FingerprintBin VARBINARY(16) = [Fingerprint].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Fingerprint].[Storage] 
    WHERE [Value] = @FingerprintBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Fingerprint].[Storage] ([Value]) VALUES (@FingerprintBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Scalar Function
-- Description:
--	Convert a fingerprint of form 
--	'01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--	to binary
-- =============================================
CREATE FUNCTION [Fingerprint].[ToBinary]
(
    @Fingerprint VARCHAR(255)
)
RETURNS VARBINARY(16)
AS
BEGIN
    DECLARE @Clean VARCHAR(32);
    -- Remove colons and ensure lowercase
    SET @Clean = LOWER(REPLACE(@Fingerprint, ':', ''));
    
    -- Convert hex string to binary
    RETURN CAST('' AS XML).value('xs:hexBinary(sql:variable("@Clean"))', 'VARBINARY(16)');
END;
GO

-- =============================================
-- Title:		Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Scalar Function
-- Description:
--	Convert a binary representation of a 
--  fingerprint back to form 
--  '01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--  from binary
-- =============================================
CREATE FUNCTION [Fingerprint].[FromBinary]
(
    @Binary VARBINARY(16)
)
RETURNS VARCHAR(47)
AS
BEGIN
    DECLARE @HexString VARCHAR(32);
    -- Convert binary to hex string
    SET @HexString = LOWER(
        CAST('' AS XML).value('xs:hexBinary(sql:variable("@Binary"))', 'VARCHAR(32)')
    );
    
    -- Insert colons every 2 characters
    RETURN STUFF(
        (
            SELECT ':' + SUBSTRING(@HexString, Number, 2)
            FROM (
                SELECT ROW_NUMBER() OVER (ORDER BY object_id)
                FROM sys.objects
            ) AS Numbers(Number)
            WHERE Number % 2 = 1 
            AND Number <= LEN(@HexString)
            FOR XML PATH('')
        ), 1, 1, ''
    );
END;
GO

USE [DShield]
GO

-- =============================================
-- DShield Fingerprint Storage Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Fingerprint
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Fingerprint 
--  Storage table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Fingerprint].[Storage] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Fingerprint].[Storage] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Fingerprint].[Storage] TO [FingerprintExecutor]; 
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintReader]
GO


-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintExecutor];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintWriter];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintReader];
GO


-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintExecutor];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintWriter];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintReader];
GO

-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintExecutor]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintReader]
GO

-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintExecutor]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintReader]
GO
