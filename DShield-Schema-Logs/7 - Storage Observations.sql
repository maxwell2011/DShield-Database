USE [DShield]
GO
/* Last Date */
-- =============================================
-- Title:       Logs - Last Firewall Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last Firewall Log Date
-- =============================================
CREATE VIEW [Logs].[LastFirewallLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[Firewall]
ORDER BY [LogTimestamp] DESC
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Last Honeypot Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last Honeypot Log Date
-- =============================================
CREATE VIEW [Logs].[LastHoneypotLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[Honeypot]
ORDER BY [LogTimestamp] DESC
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Last RawSSH Log Date
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Last RawSSH Log Date
-- =============================================
CREATE VIEW [Logs].[LastRawSSHLogDate] AS
SELECT TOP (1)
    FORMAT([LogTimestamp], 'yyyy-MM-dd') AS [Date],
    FORMAT([LogTimestamp], 'HH:mm:ss') AS [Time]
FROM [Logs].[RawSSH]
ORDER BY [LogTimestamp] DESC
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsReader]
GO

/* Observations */
-- =============================================
-- Title:       Logs - Firewall Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of Firewall observations
-- =============================================
CREATE VIEW [Logs].[FirewallObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    fl.[SourcePort],
    fl.[TargetPort]
FROM [Logs].[Firewall] fl
JOIN [IPAddress].[Addresses] src ON fl.[SourceID] = src.[Id]
JOIN [IPAddress].[Addresses] tgt ON fl.[TargetID] = tgt.[Id];
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[FirewallObservations] TO [LogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[FirewallObservations] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [LogsReader]
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of Honeypot observations
-- =============================================
CREATE VIEW [Logs].[HoneypotObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    u.[Value] AS [Url],
    ua.[Value] AS [UserAgent]
FROM [Logs].[Honeypot] hp
JOIN [IPAddress].[Addresses] src ON hp.[SourceID] = src.[Id]
JOIN [Rolodex].[UserAgents] ua ON hp.[UserAgentID] = ua.[Id]
JOIN [Rolodex].[Urls] u ON hp.[UrlID] = u.[Id];
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[HoneypotObservations] TO [LogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[HoneypotObservations] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [LogsReader]
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Observations
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Timeline of RawSSH observations
-- =============================================
CREATE VIEW [Logs].[RawSSHObservations] AS
SELECT 
    [LogTimestamp] AS [Timestamp],
    [IPAddress].[FromBinary](src.[Value]) AS [Source],
    u.[Value] AS [Username],
    p.[Value] AS [Password]
FROM [Logs].[RawSSH] rs
JOIN [IPAddress].[Addresses] src ON rs.[SourceID] = src.[Id]
JOIN [Rolodex].[Usernames] u ON rs.[UsernameID] = u.[Id]
JOIN [Rolodex].[Passwords] p ON rs.[PasswordID] = p.[Id];
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[RawSSHObservations] TO [LogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[RawSSHObservations] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [LogsReader]
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
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsManager];
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
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - URL's Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Url's observed by the honeypot
--  and count of occurrences
-- =============================================
CREATE VIEW [Logs].[UrlsObserved] AS
SELECT  
	u.[Value] AS [Url],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [Rolodex].[Urls] u ON h.[UrlID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsReader]
GO


-- =============================================
-- Title:       Logs - Addresses Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select IP Addresses observed by the 
--  honeypot and count of occurrences
-- =============================================
CREATE VIEW [Logs].[IpAddressesObserved] AS
SELECT
	[IpAddress].[FromBinary](u.[Value]) AS [IPAddress],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [Rolodex].[IPAddresses] u ON h.[SourceID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsReader]
GO


-- =============================================
-- Title:       Logs - UserAgents Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select User Agents observed by the 
--  honeypot and count of occurrences
-- =============================================
CREATE VIEW [Logs].[UserAgentsObserved] AS
SELECT  
	u.[Value] AS [UserAgent],
	COUNT(*) AS [Occurrences]
FROM [Logs].[Honeypot] h
JOIN [Rolodex].[UserAgents] u ON h.[UserAgentID] = u.[Id]
GROUP BY u.[Value]
HAVING COUNT(*) >= 1
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - UserAgents Observed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		View
-- Description:
--  View to Select Unique Username/Password 
--  Combinations and count of occurrences
-- =============================================
CREATE VIEW [Logs].[LoginsObserved] AS
SELECT 
    u.[Value] AS [Username],
    p.[Value] AS [Password],
    COUNT(*) AS [Occurrences]
FROM [Logs].[RawSSH] r
JOIN [Rolodex].[Usernames] u ON r.[UsernameID] = u.[Id]
JOIN [Rolodex].[Passwords] p ON r.[PasswordID] = p.[Id]
GROUP BY u.[Value], p.[Value]
HAVING COUNT(*) >= 1
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsReader]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsManager];
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsWriter]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsExecutor]
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
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsReader]
GO
