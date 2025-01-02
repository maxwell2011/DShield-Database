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
