USE [DShield]
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