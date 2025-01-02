USE [DShield]
GO
/* Inserts */
-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
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
	EXEC [Cowrie].[UpsertSessions] @Session, @SessionID OUTPUT;
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

-- =============================================
-- Title:       Cowrie - Upsert Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Session Connect Log Entry (Single)
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
-- =============================================
-- Title:       Cowrie - Upsert Session Connect
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
-- Title:       Cowrie - Upsert Session Connect
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
-- Title:       Cowrie - Upsert Session Connect
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
-- Title:       Cowrie - Upsert Session Connect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieReader]
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
	EXEC [Rolodex].[UpsertSSHClientVersions] @SSHClientVersion, @ClientVersionID OUTPUT;
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
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsSessionParams] TO [CowrieReader]
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
-- =============================================
-- Title:       Cowrie - Client KEX
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
-- Title:       Cowrie - Client KEX
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
-- Title:       Cowrie - Client KEX
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
-- Title:       Cowrie - Client KEX
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsClientKeyExchange] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Upsert Client Key Exchange
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
	EXEC [Rolodex].[UpsertFingerprints] @Fingerprint, @FingerprintID OUTPUT;
	EXEC [Rolodex].[UpsertPublicKeys] @Key, @KeyID OUTPUT;
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