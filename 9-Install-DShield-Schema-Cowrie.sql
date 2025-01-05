USE [DShield]
GO

-- =============================================
-- Cowrie Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================
-- =============================================
-- Cowrie - Drop Views
-- =============================================

IF OBJECT_ID('[Cowrie].[SessionFileDownloads]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[SessionFileDownloads]
GO
IF OBJECT_ID('[Cowrie].[SessionFileUploads]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[SessionFileUploads]
GO
IF OBJECT_ID('[Cowrie].[CommandFailedLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandFailedLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandSuccessLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandSuccessLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandInputLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandInputLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandLogs]
GO
-- =============================================
-- Cowrie - Drop Procedures
-- =============================================
IF OBJECT_ID('[Cowrie].[InsertFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertFirewallLogs]
GO
IF OBJECT_ID('[Cowrie].[GetFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetFirewallLogs]
GO
IF OBJECT_ID('[Cowrie].[InsertHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertHoneypotLogs]
GO
IF OBJECT_ID('[Cowrie].[GetHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetHoneypotLogs]
GO
IF OBJECT_ID('[Cowrie].[InsertRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertRawSSHLogs]
GO
IF OBJECT_ID('[Cowrie].[GetRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetRawSSHLogs]
GO

-- =============================================
-- Cowrie - Drop Procedures - Upsert
-- =============================================

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionConnect]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionConnect]
GO

IF OBJECT_ID('[Cowrie].[UpsertSensors]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertSensors]
GO
IF OBJECT_ID('[Cowrie].[UpsertMessages]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertMessages]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogsDirectTcpIpData]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpData]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogsDirectTcpIpRequest]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpRequest]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileDownloadFailures]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloadFailures]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileDownloads]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloads]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileUploads]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileUploads]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandFailed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandFailed]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandSuccess]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandSuccess]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandInput]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandInput]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsLoginSuccess]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsLoginSuccess]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsLoginFailed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsLoginFailed]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientSize]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientSize]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientFingerprint]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientFingerprint]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientVar]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientVar]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientKeyExchange]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientKeyExchange]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientVersion]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientVersion]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionParams]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionParams]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionClosed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionClosed]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogs]
GO
IF OBJECT_ID('[Cowrie].[UpsertDirectTcpIpDataValues]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertDirectTcpIpDataValues]
GO

IF OBJECT_ID('[Cowrie].[UpsertInputCommands]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertInputCommands]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogs]
GO
-- =============================================
-- Cowrie - Drop Procedures - CRUD
-- =============================================



-- =============================================
-- Cowrie - Drop Tables
-- =============================================
IF OBJECT_ID('[Cowrie].[DirectTcpIpData]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpData]
GO

IF OBJECT_ID('[Cowrie].[DirectTcpIpRequest]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpRequest]
GO

IF OBJECT_ID('[Cowrie].[SessionFileDownloadFailures]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionFileDownloadFailures]
GO

IF OBJECT_ID('[Cowrie].[SessionFiles]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionFiles]
GO

IF OBJECT_ID('[Cowrie].[Command]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Command]
GO

IF OBJECT_ID('[Cowrie].[Login]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Login]
GO

IF OBJECT_ID('[Cowrie].[ClientSize]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientSize]
GO

IF OBJECT_ID('[Cowrie].[ClientFingerprint]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientFingerprint]
GO

IF OBJECT_ID('[Cowrie].[ClientVar]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientVar]
GO

IF OBJECT_ID('[Cowrie].[ClientKeyExchange]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientKeyExchange]
GO

IF OBJECT_ID('[Cowrie].[ClientVersion]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientVersion]
GO

IF OBJECT_ID('[Cowrie].[SessionParams]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionParams]
GO

IF OBJECT_ID('[Cowrie].[SessionClosed]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionClosed]
GO

IF OBJECT_ID('[Cowrie].[SessionConnect]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionConnect]
GO

IF OBJECT_ID('[Cowrie].[Logs]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Logs]
GO

IF OBJECT_ID('[Cowrie].[DirectTcpIpDataValues]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpDataValues]
GO

IF OBJECT_ID('[Cowrie].[InputCommands]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[InputCommands]
GO

IF OBJECT_ID('[Cowrie].[Sensors]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Sensors]
GO

IF OBJECT_ID('[Cowrie].[Messages]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Messages]
GO

IF OBJECT_ID('[Cowrie].[EventIds]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[EventIds]
GO

-- =============================================
-- Cowrie - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Cowrie')
    DROP SCHEMA [Cowrie]
GO

CREATE SCHEMA [Cowrie]
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.closed
-- Description:
-- SessionClosed
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'duration'	- DOUBLE(7)		- Duration			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionClosed] (
	[Id]				INT NOT NULL,
	[Duration]			FLOAT NOT NULL,
	CONSTRAINT CK_Cowrie_SessionClosed_Duration_Bounds CHECK ([Duration] BETWEEN 0.0 AND 86400.0),
	CONSTRAINT FK_Cowrie_SessionClosed_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Closed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Session Closed Log Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionClosed] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Duration FLOAT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.closed', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionClosed] 
    WHERE 
		[Id] = @LogID AND
		[Duration] = @Duration;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionClosed] 
			([Id], [Duration]) 
		VALUES 
			(@LogID, @Duration);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.params
-- Description:
-- SessionParams
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'arch'		- FK INT		- Arch				- Reference/Archit.		- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionParams] (
	[Id]				INT NOT NULL,
	[ArchitectureID]	INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionParams_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id]),
	CONSTRAINT FK_Cowrie_SessionParams_Architecture
		FOREIGN KEY ([ArchitectureID]) 
		REFERENCES [Reference].[Architectures]([Id])
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Session Params Log Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionParams] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Architecture NVARCHAR(64),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @ArchitectureID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.params', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Reference].[UpsertArchitectures] @Architecture, @ArchitectureID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionParams] 
    WHERE 
		[Id] = @LogID AND
		[ArchitectureID] = @ArchitectureID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionParams] 
			([Id], [ArchitectureID]) 
		VALUES 
			(@LogID, @ArchitectureID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.version
-- Description:
-- ClientVersion
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'version'	- FK INT		- Version			- Rolodex/SSHClientV.	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientVersion] (
	[Id]				INT NOT NULL,
	[VersionID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVersion_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientVersion_Version
		FOREIGN KEY ([VersionID]) 
		REFERENCES [Rolodex].[SSHClientVersions]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Upsert Client Version
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Version Log Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientVersion] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@SSHClientVersion NVARCHAR(1023),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @ClientVersionID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.version', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertSSHClientVersion] @SSHClientVersion, @ClientVersionID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientVersion] 
    WHERE 
		[Id] = @LogID AND
		[VersionID] = @ClientVersionID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientVersion] 
			([Id], [VersionID]) 
		VALUES 
			(@LogID, @ClientVersionID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.kex
-- Description:
-- ClientKeyExchange
-- Id			- FK INT	- Id					- Logs/Cowrie							- 		
-- 'hassh'		- FK INT	- Hassh					- Reference/Hassh						- NULL, null if not cowrie.client.kex
-- 'hasshAlgorithms'
-- 				- FK INT	- HasshAlgorithms		- HasshAlgorithms						- NOT NULL
-- 'kexAlgs'	- FK INT	- KeyExchangeAlgorithms	- Reference/KeyExchangeAlgorithms		- NOT NULL
-- 'keyAlgs'	- FK INT	- KeyAlgorithms			- Reference/KeyAlgorithms				- NOT NULL
-- 'encCS'		- FK INT	- EncryptionAlgorithms	- Reference/EncryptionAlgorithms		- NOT NULL (Client To Server)
-- 'macCS'		- FK INT	- MACAlgorithms			- Reference/MessageAuthCipherAlgorithms	- NOT NULL (Client To Server)
-- 'compCS'		- FK INT	- CompressionAlgorithms	- Reference/CompressionAlgorithms		- NOT NULL (Client To Server)
-- 'langCS'		- FK INT	- Languages				- Reference/Languages					- NOT NULL (Client To Server)
-- =============================================
CREATE TABLE [Cowrie].[ClientKeyExchange] (
	[Id]						INT NOT NULL,
	[HasshID]					INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientKeyExchange_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientKeyExchange_Hassh
		FOREIGN KEY ([HasshID]) 
		REFERENCES [Rolodex].[Hassh]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Key Exchange Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientKeyExchange] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Hassh CHAR(32),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @HasshID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.kex', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertHassh] @Hassh, @HasshID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientKeyExchange] 
    WHERE 
		[Id] = @LogID AND
		[HasshID] = @HasshID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientKeyExchange] 
			([Id], [HasshID]) 
		VALUES 
			(@LogID, @HasshID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.var
-- Description:
-- ClientVar
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'name'		- CHAR(32)		- Name				-						- NOT NULL
-- 'value'		- CHAR(32)		- Value				-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientVar] (
	[Id]				INT NOT NULL,
	[Name]				CHAR(32) NOT NULL,
	[Value]				CHAR(32) NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVar_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Var Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientVar] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Name CHAR(32),
	@Value CHAR(32),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @HasshID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.var', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientVar] 
    WHERE 
		[Id] = @LogID AND
		[Name] = @Name AND
		[Value]= @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientVar] 
			([Id], [Name], [Value]) 
		VALUES 
			(@LogID, @Name, @Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.fingerprint
-- Description:
-- ClientFingerprint
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'username'	- FK INT	- Username			- Rolodex/Usernames		- NOT NULL
-- 'fingerprint'- FK INT	- Fingerprint		- Rolodex/Fingerprints	- NOT NULL
-- 'key'		- FK INT	- Key				- Rolodex/PublicKeys	- NOT NULL
-- 'type'		- FK INT	- Type				- Reference/KeyTypes	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientFingerprint] (
	[Id]				INT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[FingerprintID]		INT NOT NULL,
	[KeyID]				INT NOT NULL,
	[TypeID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientFingerprint_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Fingerprint
		FOREIGN KEY ([FingerprintID]) 
		REFERENCES [Fingerprint].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Key
		FOREIGN KEY ([KeyID]) 
		REFERENCES [PublicKey].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Type
		FOREIGN KEY ([TypeID]) 
		REFERENCES [Reference].[KeyTypes]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);
GO

USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Upsert Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Fingerprint Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientFingerprint] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Username NVARCHAR(255),
	@Fingerprint CHAR(32),
	@Key VARCHAR(MAX),
	@Type NVARCHAR(32),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @UsernameID INT
	DECLARE @FingerprintID INT
	DECLARE @KeyID INT
	DECLARE @TypeID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.fingerprint', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
	EXEC [Fingerprint].[UpsertText] @Fingerprint, @FingerprintID OUTPUT;
	EXEC [PublicKey].[UpsertText] @Key, @KeyID OUTPUT;
	EXEC [Reference].[UpsertKeyTypes] @Type, @TypeID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientFingerprint] 
    WHERE 
		[Id] = @LogID AND
		[UsernameID] = @UsernameID AND
		[FingerprintID]= @FingerprintID AND
		[KeyID] = @KeyID AND
		[TypeID] = @TypeID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientFingerprint] 
			([Id], [UsernameID], [FingerprintID], [KeyID], [TypeID]) 
		VALUES 
			(@LogID, @UsernameID, @FingerprintID, @KeyID, @TypeID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.size
-- Description:
-- ClientSize
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'width'		- INT		- TTYWidth			-						- NOT NULL
-- 'height'		- INT		- TTYHeight			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientSize] (
	[Id]				INT NOT NULL,
	[Width]				INT NOT NULL,
	[Height]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientSize_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Size Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientSize] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Width INT,
	@Height INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @HasshID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.size', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientSize] 
    WHERE 
		[Id] = @LogID AND
		[Width] = @Width AND
		[Height]= @Height;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientSize] 
			([Id], [Width], [Height]) 
		VALUES 
			(@LogID, @Width, @Height);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.login.failed
--				cowrie.login.success
-- Description:
-- Login
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'success'	- BIT		- Success			-						- NOT NULL
-- 'failed'		- BIT		- Failed			-						- NOT NULL
-- 'username'	- FK INT	- Username			- Rolodex/Usernames		- NOT NULL
-- 'password'	- FK INT	- Password			- Rolodex/Passwords		- NOT NULL
-- Check - Success != Failed AND Success NOT NULL AND Failed NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[Login] (
	[Id]				INT NOT NULL,
	[Success]			BIT NOT NULL,
	[Failed]			BIT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[PasswordID]		INT NOT NULL,
	CONSTRAINT CK_Cowrie_Login_Success_Or_Failure_XOR CHECK ([Success] != [Failed]),
	CONSTRAINT FK_Cowrie_Login_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Password
		FOREIGN KEY ([PasswordID]) 
		REFERENCES [Rolodex].[Passwords]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Login Failed Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsLoginFailed] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Username NVARCHAR(255),
	@Password NVARCHAR(255),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @UsernameID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.login.failed', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
	EXEC [Rolodex].[UpsertPassword] @Password, @PasswordID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Login] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 0 AND
		[Failed]= 1 AND
		[UsernameID] = @UsernameID AND 
		[PasswordID] = @PasswordID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Login] 
			([Id], [Success], [Failed], [UsernameID], [PasswordID]) 
		VALUES 
			(@LogID, 0, 1, @UsernameID, @PasswordID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Login Success Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsLoginSuccess] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Username NVARCHAR(255),
	@Password NVARCHAR(255),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @UsernameID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.login.success', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
	EXEC [Rolodex].[UpsertPassword] @Password, @PasswordID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Login] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 1 AND
		[Failed]= 0 AND
		[UsernameID] = @UsernameID AND 
		[PasswordID] = @PasswordID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Login] 
			([Id], [Success], [Failed], [UsernameID], [PasswordID]) 
		VALUES 
			(@LogID, 1, 0, @UsernameID, @PasswordID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.command.input
--				cowrie.command.failed
--				cowrie.command.success
-- Description:
-- Command
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'success'	- TINYINT	- Success			-						- NOT NULL DEFAULT 0
-- 'failed'		- TINYINT	- Failed			-						- NOT NULL DEFAULT 0
-- '______'		- TINYINT	- Input				-						- NOT NULL DEFAULT 0
-- 'input'		- FK INT	- Command			- Cowrie/InputCommands	- NOT NULL
-- Check - (Success + Failed + Input) = 1
-- Check - (Success in (0,1), Failed in (0,1), Input in (0,1))
-- =============================================
CREATE TABLE [Cowrie].[Command] (
	[Id]				INT NOT NULL,
	[Success]			TINYINT NOT NULL DEFAULT 0,
	[Failed]			TINYINT NOT NULL DEFAULT 0,
	[Input]				TINYINT NOT NULL DEFAULT 0,
	[CommandID]			INT NOT NULL,
	CONSTRAINT CK_Cowrie_Command_Success_Failure_Input_XOR CHECK (([Success] + [Failed] + [Input]) = 1),
	CONSTRAINT CK_Cowrie_Command_Success_In CHECK ([Success] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Failed_In CHECK ([Failed] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Input_In CHECK ([Input] IN (0, 1)),
	CONSTRAINT FK_Cowrie_Command_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Command_Command
		FOREIGN KEY ([CommandID]) 
		REFERENCES [Cowrie].[InputCommands]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Input Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandInput] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.input', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 0 AND
		[Failed]= 0 AND
		[Input] = 1 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 0, 0, 1, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Success Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandSuccess] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.success', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 1 AND
		[Failed]= 0 AND
		[Input] = 0 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 1, 0, 0, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Failed Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandFailed] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.failed', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 0 AND
		[Failed]= 1 AND
		[Input] = 0 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 0, 1, 0, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command Logs (All)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.input
--				cowrie.command.failed
--				cowrie.command.success
-- Description:
--	View to select all command logs
-- =============================================
CREATE VIEW [Cowrie].[CommandLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
GO


-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.input
-- Description:
--	View to select all command input logs
-- =============================================
CREATE VIEW [Cowrie].[CommandInputLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Input] = 1
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.success
-- Description:
--	View to select all command success logs
-- =============================================
CREATE VIEW [Cowrie].[CommandSuccessLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Success] = 1
GO


-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.failed
-- Description:
--	View to select all command failed logs
-- =============================================
CREATE VIEW [Cowrie].[CommandFailedLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Failed] = 1
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_upload
--				cowrie.session.file_download
-- Description:
--  Combined table. should be a view anyways
-- SessionFileUploads
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
-- 'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
-- 'shasum'		- CHAR(64)		- ShaSum			-						- NOT NULL
-- 
-- SessionFileDownloads
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
-- 'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
-- 'shasum'		- CHAR(64)		- ShaSum			-						- NOT NULL
-- 'duplicate'	- BIT			- Duplicate			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionFiles] (
	[Id]				INT NOT NULL,
	[Filename]			VARCHAR(255) NOT NULL,
	[Outfile]			VARCHAR(255) NOT NULL,
	[ShaSum]			CHAR(64) NOT NULL,
	[Duplicate]			BIT NOT NULL DEFAULT 0,
	CONSTRAINT FK_Cowrie_SessionFiles_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Session File Upload
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Session File Upload Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionFileUploads] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Filename VARCHAR(255),
	@Outfile VARCHAR(255),
	@ShaSum CHAR(64),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.file_upload', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionFiles] 
    WHERE 
		[Id] = @LogID AND
		[Filename] = @Filename AND
		[Outfile]= @Outfile AND
		[ShaSum] = @ShaSum AND 
		[Duplicate] = 0;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionFiles] 
			([Id], [Filename], [Outfile], [ShaSum], [Duplicate]) 
		VALUES 
			(@LogID, @Filename, @Outfile, @ShaSum, 0);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Session File Download
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Session File Download Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloads] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Filename VARCHAR(255),
	@Outfile VARCHAR(255),
	@ShaSum CHAR(64),
	@Duplicate BIT = 0,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.file_download', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionFiles] 
    WHERE 
		[Id] = @LogID AND
		[Filename] = @Filename AND
		[Outfile]= @Outfile AND
		[ShaSum] = @ShaSum AND 
		[Duplicate] = @Duplicate;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionFiles] 
			([Id], [Filename], [Outfile], [ShaSum], [Duplicate]) 
		VALUES 
			(@LogID, @Filename, @Outfile, @ShaSum, @Duplicate);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.session.file_upload
-- Description:
--	View to select session file upload logs
-- =============================================
CREATE VIEW [Cowrie].[SessionFileUploads] AS
SELECT
	   sf.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
	  ,sf.[Filename] AS [Destination File]
	  ,sf.[Outfile] AS [Output File]
	  ,sf.[ShaSum] AS [SHA 256 Sum]
  FROM [Cowrie].[SessionFiles] sf
  JOIN [Cowrie].[Logs] l ON l.[Id] = sf.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE e.[Value] = 'cowrie.session.file_upload'
GO


-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.session.file_download
-- Description:
--	View to select session file download logs
-- =============================================
CREATE VIEW [Cowrie].[SessionFileDownloads] AS
SELECT
	   sf.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[IPAddress].[FromBinary](i.[Value]) AS [Source Address]
	  ,[SessionId].[FromBinary](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
	  ,sf.[Filename] AS [Destination File]
	  ,sf.[Outfile] AS [Output File]
	  ,sf.[ShaSum] AS [SHA 256 Sum]
	  ,sf.[Duplicate]
  FROM [Cowrie].[SessionFiles] sf
  JOIN [Cowrie].[Logs] l ON l.[Id] = sf.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [SessionId].[Storage] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE e.[Value] = 'cowrie.session.file_download'
GO

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
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionFileDownloadFailures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_download.failed
-- Description:
-- SessionFileDownloadFailures
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'url'		- FK INT		- Url				- Rolodex/Urls			- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionFileDownloadFailures] (
	[Id]				INT NOT NULL,
	[UrlID]				INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_Url
		FOREIGN KEY ([UrlID]) 
		REFERENCES [Rolodex].[Urls]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Session File Download Failure
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Session File Download Failure Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloadFailures] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Url NVARCHAR(2048),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @UrlID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.file_download.failed', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Rolodex].[UpsertUrl] @Url, @UrlID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionFileDownloadFailures] 
    WHERE 
		[Id] = @LogID AND
		[UrlID] = @UrlID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionFileDownloadFailures] 
			([Id], [UrlID]) 
		VALUES 
			(@LogID, @UrlID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_download.failed
-- Description:
-- DirectTcpIpRequest
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
-- 'src_port'	- INT			- SourcePort		-						- 0, GTE 0, LTE 65535, not null		
-- =============================================
CREATE TABLE [Cowrie].[DirectTcpIpRequest] (
	[Id]				INT NOT NULL,
	[SourcePort]		INT NOT NULL,
	[DestinationPort]	INT NOT NULL,
	[DestinationID]		INT	NOT NULL,
	CONSTRAINT CK_Cowrie_DirectTcpIpRequest_SourcePort_Bounds CHECK ([SourcePort] BETWEEN 0 AND 65535),
	CONSTRAINT CK_Cowrie_DirectTcpIpRequest_DestinationPort_Bounds CHECK ([DestinationPort] BETWEEN 0 AND 65535),
	CONSTRAINT FK_Cowrie_DirectTcpIpRequest_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_DirectTcpIpRequest_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO


USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Direct TCP IP Request Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpRequest] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Destination VARCHAR(45),
	@DestinationPort INT,
	@SourcePort INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @DestinationID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.direct-tcpip.request', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [IPAddress].[UpsertIP] @Destination, @DestinationID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[DirectTcpIpRequest] 
    WHERE 
		[Id] = @LogID AND
		[DestinationID] = @DestinationID AND
		[SourcePort]= @SourcePort AND
		[DestinationPort]=@DestinationPort;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpRequest] 
			([Id], [DestinationID], [SourcePort], [DestinationPort]) 
		VALUES 
			(@LogID, @DestinationID, @SourcePort, @DestinationPort);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.direct-tcpip.data
-- Description:
-- DirectTcpIpData
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
-- 'data'		- FK INT		- Data				- Cowrie/DirectTcpIpData- NOT NULL
-- 'id'		- INT			- Identifier		-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[DirectTcpIpData] (
	[Id]				INT NOT NULL,
	[DestinationPort]	INT NOT NULL CHECK ([DestinationPort] <= 65535),
	[DestinationID]		INT	NOT NULL,
	[DataID]			INT	NOT NULL,
	[Identifier]		INT	NOT NULL,
	CONSTRAINT FK_Cowrie_DirectTcpIpData_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id]),
	CONSTRAINT FK_Cowrie_DirectTcpIpData_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id]),
	CONSTRAINT FK_Cowrie_DirectTcpIpData_Data
		FOREIGN KEY ([DataID]) 
		REFERENCES [Cowrie].[DirectTcpIpDataValues]([Id])
);
GO


USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Direct TCP IP Data Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpData] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Destination VARCHAR(45),
	@DestinationPort INT,
	@Data NVARCHAR(MAX),
	@Identifier INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @DataID INT;
	DECLARE @DestinationID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.direct-tcpip.data', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [IPAddress].[UpsertIP] @Destination, @DestinationID OUTPUT;
	EXEC [Cowrie].[UpsertDirectTcpIpDataValues] @Data, @DataID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[DirectTcpIpData] 
    WHERE 
		[Id] = @LogID AND
		[DestinationID] = @DestinationID AND
		[DataID]= @DataID AND
		[DestinationPort]=@DestinationPort AND
		[Identifier] = @Identifier;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpData] 
			([Id], [DestinationID], [DataID], [DestinationPort], [Identifier]) 
		VALUES 
			(@LogID, @DestinationID, @DataID, @DestinationPort, @Identifier);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  a string representation of a cowrie event id name
-- =============================================
CREATE TABLE [Cowrie].[EventIds] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(64) NOT NULL UNIQUE
);
GO


USE [DShield]
GO

USE [DShield]
GO

-- =============================================
-- Title:       Preload - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Data
-- Description:
--  Preload the Event Id table (All)
-- =============================================
INSERT INTO [Cowrie].[EventIds] ([Value]) VALUES 
('cowrie.session.connect'),
('cowrie.client.version'),
('cowrie.client.kex'),
('cowrie.login.failed'),
('cowrie.session.closed'),
('cowrie.login.success'),
('cowrie.session.params'),
('cowrie.command.input'),
('cowrie.command.failed'),
('cowrie.log.closed'),
('cowrie.session.file_download'),
('cowrie.direct-tcpip.request'),
('cowrie.session.file_upload'),
('cowrie.client.var'),
('cowrie.command.success'),
('cowrie.client.fingerprint'),
('cowrie.direct-tcpip.data'),
('cowrie.client.size'),
('cowrie.session.file_download.failed'),
('UNKNOWN');
GO
USE [DShield]
GO

-- =============================================
-- DShield Cowrie Event Ids Table Audit
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
--  UPDATE, DELETE statements on the Cowrie 
--  Event Ids table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Cowrie].[EventIds] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a message in a cowrie log
-- =============================================
-- 
CREATE TABLE [Cowrie].[Messages] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO


USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Message Value (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertMessages] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[Messages] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Messages] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a sensor in a cowrie log
-- =============================================
-- 
CREATE TABLE [Cowrie].[Sensors] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(128) NOT NULL UNIQUE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Sensors Name Value (Single) 
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertSensors] @Value NVARCHAR(128),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[Sensors] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Sensors] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a cowrie recorded input
-- =============================================
CREATE TABLE [Cowrie].[InputCommands] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - InputCommands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Command Input Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertInputCommands] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[EventIds] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[InputCommands] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a cowrie direct 
--	TCP IP input
-- =============================================
CREATE TABLE [Cowrie].[DirectTcpIpDataValues] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Direct TcpIp Data Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertDirectTcpIpDataValues] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[EventIds] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpDataValues] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
-- Logs, primary anchor table for cowrie logs
-- Input Name	- Type			- Column Name		- FK Table Name/Column	- Default
-- Id			- INT			- Id				-						- IDENTITY(1,1)		
-- 'timestamp'	- DATETIME2		- LogTimestamp		-						- NOT NULL
-- 'eventid'	- FK INT		- EventId			- Cowrie/EventIds		- NOT NULL
-- 'src_ip'		- FK INT		- SourceID			- Rolodex/IPAddresses	- NOT NULL
-- 'session'	- FK INT		- Session			- Cowrie/Sensors		- NOT NULL
-- 'message'	- FK INT		- Message			- Cowrie/Messages		- NOT NULL
-- 'sensor'		- FK INT		- Sensor			- Cowrie/Sensors		- NOT NULL --> 1
-- =============================================
CREATE TABLE [Cowrie].[Logs] (
	[Id]			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[LogTimestamp]	DATETIME2 NOT NULL,
	[EventIdID]		INT NOT NULL,
	[SourceID]		INT	NOT NULL,
	[SessionID]		INT NOT NULL,
	[MessageID]		INT NOT NULL,
	[SensorID]		INT NOT NULL,
	CONSTRAINT FK_Cowrie_Logs_EventId
		FOREIGN KEY ([EventIdID]) 
		REFERENCES [Cowrie].[EventIds]([Id]),
	CONSTRAINT FK_Cowrie_Logs_SourceAddress
		FOREIGN KEY ([SourceID]) 
		REFERENCES [IPAddress].[Addresses]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Session
		FOREIGN KEY ([SessionID]) 
		REFERENCES [Cowrie].[Sensors]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Message
		FOREIGN KEY ([MessageID]) 
		REFERENCES [Cowrie].[Messages]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Sensor
		FOREIGN KEY ([SensorID]) 
		REFERENCES [Cowrie].[Sensors]([Id])
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Log (Base, Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogs] 
	@LogTimestamp DATETIME2(7),
	@EventId NVARCHAR(64),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @EventIdID INT;
	DECLARE @SourceID BIGINT;
	DECLARE @SessionID INT;
	DECLARE @MessageID INT;
	DECLARE @SensorID INT;
	SELECT @EventIdID = [Id] FROM [Cowrie].[EventIds] WHERE [Value] = @EventId;
	IF @EventIdID IS NULL
	SELECT @EventIdID = [Id] FROM [Cowrie].[EventIds] WHERE [Value] = 'UNKNOWN';
	EXEC [IPAddress].[UpsertIP] @Source, @SourceID OUTPUT;
	EXEC [SessionId].[UpsertText] @Session, @SessionID OUTPUT;
	EXEC [Cowrie].[UpsertMessages] @Message, @MessageID OUTPUT;
	EXEC [Cowrie].[UpsertSensors] @Sensor, @SensorID OUTPUT;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[Logs] 
    WHERE 
		[LogTimestamp] = @LogTimestamp AND
		[EventIdID] = @EventIdID AND
		[SourceID] = @SourceID AND
		[SessionID] = @SessionID AND
		[MessageID] = @MessageID AND
		[SensorID] = @SensorID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Logs] 
			([LogTimestamp], [EventIdID], [SourceID], [SessionID], [MessageID], [SensorID]) 
		VALUES 
			(@LogTimestamp, @EventIdID, @SourceID, @SessionID, @MessageID, @SensorID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionConnect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.connect
-- Description:
-- SessionConnect
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'src_port'	- INT			- SourcePort		-						- 0, GTE 0, LTE 65535, null if not cowrie.session.connect
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, null if not cowrie.session.connect
-- 'protocol'	- FK INT		- Protocol			- Reference/Protocols	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionConnect] (
	[Id]				INT NOT NULL,
	[SourcePort]		INT NOT NULL,
	[DestinationPort]	INT NOT NULL,
	[DestinationID]		INT	NOT NULL,
	[Protocol]			INT	NOT NULL,
	CONSTRAINT CK_Cowrie_SessionConnect_SourcePort_Bounds CHECK ([SourcePort] BETWEEN 0 AND 65535),
	CONSTRAINT CK_Cowrie_SessionConnect_DestinationPort_Bounds CHECK ([DestinationPort] BETWEEN 0 AND 65535),
	CONSTRAINT FK_Cowrie_SessionConnect_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionConnect_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionConnect_Protocol
		FOREIGN KEY ([Protocol]) 
		REFERENCES [Reference].[Protocols]([Number])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Logs Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Session Connect Log Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionConnect] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@SourcePort INT,
	@DestinationPort INT,
	@Destination VARCHAR(45),
	@Protocol INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @ProtocolID INT;
	DECLARE @DestinationID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.connect', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
    -- Try to find existing Username
    SELECT @ProtocolID = [Number] FROM [Reference].[Protocols] WHERE [Number] = @Protocol;
	EXEC [IPAddress].[UpsertIP] @Destination, @DestinationID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionConnect] 
    WHERE 
		[Id] = @LogID AND
		[SourcePort] = @SourcePort AND
		[DestinationPort] = @DestinationPort AND
		[DestinationID] = @DestinationID AND
		[Protocol] = @ProtocolID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionConnect] 
			([Id], [SourcePort], [DestinationPort], [DestinationID], [Protocol]) 
		VALUES 
			(@LogID, @SourcePort, @DestinationPort, @DestinationID, @ProtocolID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

USE [DShield]
GO


-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionClosed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionClosed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionClosed] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionClosed] TO [CowrieReader]
GO


-- =============================================
-- Title:       Cowrie - Logs Session Closed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionClosed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Logs Session Closed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionClosed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Logs Session Closed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionClosed] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Logs Session Closed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionClosed] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionParams] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionParams] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionParams] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionParams] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientVersion] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientVersion] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVersion] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVersion] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Version
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVersion] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Version
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVersion] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Version
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVersion] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Version
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVersion] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientKeyExchange] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientKeyExchange] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientKeyExchange] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientKeyExchange] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientKeyExchange] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientKeyExchange] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientKeyExchange] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientKeyExchange] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientVar] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientVar] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVar] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVar] TO [CowrieReader]
GO


-- =============================================
-- Title:       Cowrie - Client VAR
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVar] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client VAR
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVar] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client VAR
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVar] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client VAR
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientVar] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientFingerprint] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientFingerprint] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientFingerprint] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientFingerprint] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientFingerprint] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientFingerprint] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientFingerprint] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientFingerprint] TO [CowrieReader]
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientSize] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientSize] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientSize] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientSize] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientSize] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientSize] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientSize] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientSize] TO [CowrieReader]
GO
USE [DShield]
GO


-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Login] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Command] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Command] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Command] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Command] TO [CowrieReader]
GO



-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandLogs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandLogs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[CommandLogs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[CommandLogs] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandInput] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandInput] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandInput] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandInput] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandSuccess] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandSuccess] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandSuccess] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandSuccess] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandFailed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandFailed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandFailed] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsCommandFailed] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandInputLogs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandInputLogs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[CommandInputLogs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[CommandInputLogs] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandSuccessLogs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandSuccessLogs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[CommandSuccessLogs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[CommandSuccessLogs] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandFailedLogs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandFailedLogs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[CommandFailedLogs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[CommandFailedLogs] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFiles] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFiles] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFiles] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFiles] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Session File Upload
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileUploads] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session File Upload
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileUploads] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session File Upload
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileUploads] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Session File Upload
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileUploads] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Session File Download
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloads] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session File Download
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloads] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session File Download
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloads] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Session File Download
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloads] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFileUploads] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFileUploads] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileUploads] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileUploads] TO [CowrieReader]
GO


-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFileDownloads] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFileDownloads] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloads] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloads] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Session Files (Download Failure)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFileDownloadFailures] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session Files (Download Failure)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session Files (Download Failure)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Session Files (Download Failure)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Session File Download Failure
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloadFailures] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session File Download Failure
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloadFailures] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session File Download Failure
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloadFailures] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Session File Download Failure
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionFileDownloadFailures] TO [CowrieReader]
GO

USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpRequest] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpRequest] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpRequest] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpRequest] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpRequest] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpData] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpData] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpData] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpData] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsDirectTcpIpData] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[EventIds] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[EventIds] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[EventIds] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[EventIds] TO [CowrieReader]
GO


USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Messages] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Messages] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[Messages] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Messages] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertMessages] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertMessages] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertMessages] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertMessages] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Sensors] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Sensors] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Sensors] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Sensors] TO [CowrieReader]
GO


-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertSensors] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertSensors] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertSensors] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertSensors] TO [CowrieReader]
GO
USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[InputCommands] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[InputCommands] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[InputCommands] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[InputCommands] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertInputCommands] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertInputCommands] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertInputCommands] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertInputCommands] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[DirectTcpIpDataValues] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertDirectTcpIpDataValues] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertDirectTcpIpDataValues] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertDirectTcpIpDataValues] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertDirectTcpIpDataValues] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Logs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Logs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Logs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Logs] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogs] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogs] TO [CowrieReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionConnect] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionConnect] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionConnect] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[SessionConnect] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Logs Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionConnect] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Logs Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionConnect] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Logs Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionConnect] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Logs Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionConnect] TO [CowrieReader]
GO
