USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Session Files (Uploads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.session.file_upload
-- Description:
--	View to select session file upload logs
-- =============================================
CREATE VIEW [Cowrie].[SessionFileUploads] AS
SELECT
	   sf.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
	  ,sf.[Filename] AS [Destination File]
	  ,sf.[Outfile] AS [Output File]
	  ,sf.[ShaSum] AS [SHA 256 Sum]
  FROM [sans_isc].[Cowrie].[SessionFiles] sf
  JOIN [Cowrie].[Logs] l ON l.[Id] = sf.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE e.[Value] = 'cowrie.session.file_upload'
GO


-- =============================================
-- Title:       Cowrie - Session Files (Downloads)
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		View
-- Event ID:	cowrie.session.file_download
-- Description:
--	View to select session file download logs
-- =============================================
CREATE VIEW [Cowrie].[SessionFileDownloads] AS
SELECT
	   sf.[Id]
	  ,l.[LogTimestamp]
	  ,e.[Value] AS [Event ID]
	  ,[Rolodex].[IPToString](i.[Value]) AS [Source Address]
	  ,[Logs].[BinaryToSessionId](s.[Value]) AS [Session ID]
	  ,m.[Value] AS [Message]
      ,ic.[Value] AS [Command]
	  ,sf.[Filename] AS [Destination File]
	  ,sf.[Outfile] AS [Output File]
	  ,sf.[ShaSum] AS [SHA 256 Sum]
	  ,sf.[Duplicate]
  FROM [sans_isc].[Cowrie].[SessionFiles] sf
  JOIN [Cowrie].[Logs] l ON l.[Id] = sf.[Id]
  JOIN [Cowrie].[EventIds] e ON e.[Id] = l.[EventIdID]
  JOIN [IPAddress].[Addresses] i ON i.[Id] = l.[SourceID]
  JOIN [Cowrie].[Sessions] s ON s.[Id] = l.[SessionID]
  JOIN [Cowrie].[Messages] m ON m.[Id] = l.[MessageID]
  WHERE e.[Value] = 'cowrie.session.file_download'
GO
