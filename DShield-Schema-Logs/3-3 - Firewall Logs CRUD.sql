USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert Firewall Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertFirewallLogs]
    @Date       DATE,
    @Time       TIME,
    @Source     VARCHAR(45),
    @SourcePort INT,
    @Target     VARCHAR(45),
    @TargetPort INT,
    @Protocol   INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID INT, @TargetID INT;
    DECLARE @LogTimestamp DATETIME2(7);
	-- Correct way to combine date and time into datetime2
    -- Convert using binary concatenation since DATE is 3 bytes and TIME(7) is 6 bytes
    SET @LogTimestamp = CAST(
        CAST(@Time AS BINARY(6)) + 
        CAST(@Date AS BINARY(3)) 
        AS DATETIME2(7)
    );
    -- Get or create Source IP
    EXEC [IPAddress].[UpsertIP] @Source, @SourceID OUTPUT;
    -- Get or create Target IP
    EXEC [IPAddress].[UpsertIP] @Target, @TargetID OUTPUT;
    -- Insert log entry
    INSERT INTO [Logs].[Firewall] (
        [LogTimestamp],
        [SourceID],
        [SourcePort],
        [TargetID],
        [TargetPort],
        [Protocol]
    )
    VALUES (
        @LogTimestamp,
        @SourceID,
        @SourcePort,
        @TargetID,
        @TargetPort,
        @Protocol
    );
END;
GO

-- =============================================
-- Title:       Logs - Get Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Firewall Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetFirewallLogs]
AS
BEGIN
    SELECT 
        FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
        FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time],
        [IPAddress].[FromBinary](src.[Value]) AS [Source],
        fl.[SourcePort],
        [IPAddress].[FromBinary](tgt.[Value]) AS [Target],
        fl.[TargetPort],
        fl.[Protocol]
    FROM [Logs].[Firewall] fl
    JOIN [IPAddress].[Addresses] src ON fl.[SourceID] = src.[Id]
    JOIN [IPAddress].[Addresses] tgt ON fl.[TargetID] = tgt.[Id];
END;
GO

