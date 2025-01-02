USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Upsert Session Params
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--	Upsert a Cowrie Session Params Log Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsSessionParams] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Architecture NVARCHAR(64),
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @ArchitectureID INT
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.session.params', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [Reference].[UpsertArchitectures] @Architecture, @ArchitectureID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[SessionParams] 
    WHERE 
		[Id] = @LogID AND
		[ArchitectureID] = @ArchitectureID;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[SessionParams] 
			([Id], [ArchitectureID]) 
		VALUES 
			(@LogID, @ArchitectureID);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
