USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Client Var Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsClientVar] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Name CHAR(32),
	@Value CHAR(32),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @HasshID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.client.var', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[ClientVar] 
    WHERE 
		[Id] = @LogID AND
		[Name] = @Name AND
		[Value]= @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[ClientVar] 
			([Id], [Name], [Value]) 
		VALUES 
			(@LogID, @Name, @Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO