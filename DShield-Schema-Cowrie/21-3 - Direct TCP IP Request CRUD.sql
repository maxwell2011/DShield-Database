USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Direct TCP IP Request Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpRequest] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Destination VARCHAR(45),
	@DestinationPort INT,
	@SourcePort INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @DestinationID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.direct-tcpip.request', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [IPAddress].[UpsertIP] @Destination, @DestinationID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[DirectTcpIpRequest] 
    WHERE 
		[Id] = @LogID AND
		[DestinationID] = @DestinationID AND
		[SourcePort]= @SourcePort AND
		[DestinationPort]=@DestinationPort;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpRequest] 
			([Id], [DestinationID], [SourcePort], [DestinationPort]) 
		VALUES 
			(@LogID, @DestinationID, @SourcePort, @DestinationPort);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO