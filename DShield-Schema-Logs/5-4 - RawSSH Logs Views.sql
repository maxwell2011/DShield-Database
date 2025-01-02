USE [DShield]
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