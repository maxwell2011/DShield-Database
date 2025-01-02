USE [DShield]
GO

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