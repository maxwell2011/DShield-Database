USE [DShield]
GO
/* Inserts */
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
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsReader]
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
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsReader]
GO


-- =============================================
-- Title:       Logs - Insert RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert RawSSH Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertRawSSHLogs]
    @Date DATE,
    @Time TIME,
    @Source VARCHAR(45),
    @Username NVARCHAR(255),
    @Password NVARCHAR(255)
AS BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID BIGINT;
    DECLARE @UsernameID INT;
    DECLARE @PasswordID INT;
    DECLARE @LogTimestamp datetime2(7);    
    SET @LogTimestamp = CAST(
        CAST(@Time AS binary(6)) + 
        CAST(@Date AS binary(3)) 
        AS DATETIME2(7)
    );
    EXEC [IPAddresses].[UpsertIP] @Source, @SourceID OUTPUT;
    EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
    EXEC [Rolodex].[UpsertPassword] @Password, @PasswordID OUTPUT;
    INSERT INTO [Logs].[RawSSH] (
        [LogTimestamp],
        [SourceID],
        [UsernameID],
        [PasswordID]
    )
    VALUES (
        @LogTimestamp,
        @SourceID,
        @UsernameID,
        @PasswordID
    );
END;
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsReader]
GO
/* Gets */

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

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsReader]
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

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Get RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Raw SSH Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetRawSSHLogs]
AS BEGIN
    SELECT 
        FORMAT(rs.[LogTimestamp], 'yyyy-MM-dd') as [Date],
        FORMAT(rs.[LogTimestamp], 'HH:mm:ss.fffffff') as [Time],
        [Rolodex].[IPToString](addr.[Value]) as [Source],
        un.[Value] AS [Username],
        pw.[Value] AS [Password]
    FROM [Logs].[RawSSH] rs
    JOIN [IPAddress].[Addresses] addr ON rs.[SourceID] = addr.[Id]
    JOIN [Rolodex].[Usernames] un ON rs.[UsernameID] = un.[Id]
    JOIN [Rolodex].[Passwords] pw ON rs.[PasswordID] = pw.[Id];
END;
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsReader]
GO