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