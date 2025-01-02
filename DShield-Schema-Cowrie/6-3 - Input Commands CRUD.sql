USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - InputCommands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Command Input Entry (Single)
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