USE [DShield]
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