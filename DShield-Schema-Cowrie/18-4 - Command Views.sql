USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command Logs (All)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.input
--				cowrie.command.failed
--				cowrie.command.success
-- Description:
--	View to select all command logs
-- =============================================
CREATE VIEW [Cowrie].[CommandLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
GO


-- =============================================
-- Title:       Cowrie - Command Logs (Input)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.input
-- Description:
--	View to select all command input logs
-- =============================================
CREATE VIEW [Cowrie].[CommandInputLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Input] = 1
GO

-- =============================================
-- Title:       Cowrie - Command Logs (Success)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.success
-- Description:
--	View to select all command success logs
-- =============================================
CREATE VIEW [Cowrie].[CommandSuccessLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Success] = 1
GO


-- =============================================
-- Title:       Cowrie - Command Logs (Failed)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.command.failed
-- Description:
--	View to select all command failed logs
-- =============================================
CREATE VIEW [Cowrie].[CommandFailedLogs] AS
SELECT
	   c.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
  FROM [sans_isc].[Cowrie].[Command] c
  JOIN [Cowrie].[InputCommands] ic ON ic.[Id] = c.[CommandID]
  JOIN [Cowrie].[Logs] l ON l.[Id] = c.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE c.[Failed] = 1
GO
