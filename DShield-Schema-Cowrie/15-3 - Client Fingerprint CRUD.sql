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