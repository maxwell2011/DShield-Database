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
