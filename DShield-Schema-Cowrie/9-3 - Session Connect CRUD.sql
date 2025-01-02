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
