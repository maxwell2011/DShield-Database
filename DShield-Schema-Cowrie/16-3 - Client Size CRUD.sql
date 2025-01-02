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
