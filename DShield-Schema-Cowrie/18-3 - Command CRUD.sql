USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command Input
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Input Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandInput] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.input', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 0 AND
		[Failed]= 0 AND
		[Input] = 1 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 0, 0, 1, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Command Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Success Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandSuccess] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.success', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 1 AND
		[Failed]= 0 AND
		[Input] = 0 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 1, 0, 0, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       Cowrie - Command Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Client Command Failed Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsCommandFailed] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Command NVARCHAR(MAX),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @CommandID INT
	DECLARE @PasswordID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.command.failed', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Cowrie].[UpsertInputCommands] @Command, @CommandID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[Command] 
    WHERE 
		[Id] = @LogID AND
		[Success] = 0 AND
		[Failed]= 1 AND
		[Input] = 0 AND 
		[CommandID] = @CommandID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Command] 
			([Id], [Success], [Failed], [Input], [CommandID]) 
		VALUES 
			(@LogID, 0, 1, 0, @CommandID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
