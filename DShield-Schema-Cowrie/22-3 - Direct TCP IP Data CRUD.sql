USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TCP IP Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Upsert a Cowrie Direct TCP IP Data Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpData] 
	@LogTimestamp DATETIME2(7),
	@Source VARCHAR(45),
	@Session VARCHAR(32),
	@Message NVARCHAR(MAX),
	@Sensor VARCHAR(32),
	@Destination VARCHAR(45),
	@DestinationPort INT,
	@Data NVARCHAR(MAX),
	@Identifier INT,
	@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @LogID INT;
	DECLARE @ULogID INT;
	DECLARE @DataID INT;
	DECLARE @DestinationID INT;
	EXEC [Cowrie].[UpsertLogs] @LogTimestamp, 'cowrie.direct-tcpip.data', @Source, @Session, @Message, @Sensor, @LogID OUTPUT;
	EXEC [IPAddress].[UpsertIP] @Destination, @DestinationID OUTPUT;
	EXEC [Cowrie].[UpsertDirectTcpIpDataValues] @Data, @DataID OUTPUT;
	SELECT @ULogID = [Id]
    FROM [Cowrie].[DirectTcpIpData] 
    WHERE 
		[Id] = @LogID AND
		[DestinationID] = @DestinationID AND
		[DataID]= @DataID AND
		[DestinationPort]=@DestinationPort AND
		[Identifier] = @Identifier;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpData] 
			([Id], [DestinationID], [DataID], [DestinationPort], [Identifier]) 
		VALUES 
			(@LogID, @DestinationID, @DataID, @DestinationPort, @Identifier);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO