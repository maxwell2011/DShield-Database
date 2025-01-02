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