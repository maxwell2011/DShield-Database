USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert Honeypot Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertHoneypotLogs]
    @Count INT,
    @Date DATE,
    @Time TIME,
    @Source VARCHAR(45),
    @Url NVARCHAR(2048),
    @UserAgent NVARCHAR(1024)
AS BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID BIGINT;
    DECLARE @UrlID INT;
    DECLARE @UserAgentID INT;
    DECLARE @LogTimestamp datetime2(7);
    -- Combine date and time using binary concatenation
    SET @LogTimestamp = CAST(
        CAST(@Time AS binary(6)) + 
        CAST(@Date AS binary(3)) 
        AS datetime2(7)
    );
    -- Get or create Source IP
    EXEC [IPAddresses].[UpsertIP] @Source, @SourceID OUTPUT;
    -- Get or create Url
    EXEC [Rolodex].[UpsertUrl] @Url, @UrlID OUTPUT;
    -- Get or create UserAgent
    EXEC [Rolodex].[UpsertUserAgent] @UserAgent, @UserAgentID OUTPUT;
    INSERT INTO [Logs].[Honeypot] (
        [LogTimestamp],
        [Count],
        [SourceID],
        [UrlID],
        [UserAgentID]
    )
    VALUES (
        @LogTimestamp,
        @Count,
        @SourceID,
        @UrlID,
        @UserAgentID
    );
END;
GO

-- =============================================
-- Title:       Logs - Get Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Honeypot Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetHoneypotLogs]
AS BEGIN
    SELECT 
        FORMAT(hp.[LogTimestamp], 'yyyy-MM-dd') AS [Date],
        FORMAT(hp.[LogTimestamp], 'HH:mm:ss.fffffff') AS [Time],
        hp.[Count],
        [IPAddress].[FromBinary](addr.[Value]) AS [Source],
        u.[Value] AS [Url],
        ua.[Value] AS [UserAgent]
    FROM [Logs].[Honeypot] hp
    JOIN [IPAddress].[Addresses] addr ON hp.[SourceID] = addr.[Id]
    JOIN [Rolodex].[UserAgents] ua ON hp.[UserAgentID] = ua.[Id]
    JOIN [Rolodex].[Urls] u ON hp.[UrlID] = u.[Id];
END;
GO