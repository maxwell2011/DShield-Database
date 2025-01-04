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