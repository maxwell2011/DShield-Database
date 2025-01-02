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