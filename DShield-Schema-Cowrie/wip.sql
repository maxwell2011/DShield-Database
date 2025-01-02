USE [DShield]
GO

-- =============================================
-- Cowrie - ClientVar 
--		cowrie.client.var
-- =============================================

/*
ClientVar
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'name'		- CHAR(32)		- Name				-						- NOT NULL
'value'		- CHAR(32)		- Value				-						- NOT NULL
*/
CREATE TABLE [Cowrie].[ClientVar] (
	[Id]				INT NOT NULL,
	[Name]				CHAR(32) NOT NULL,
	[Value]				CHAR(32) NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVar_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientVar] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVar]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientVar]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientVar]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVar]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientVar]  TO [CowrieLogReader]
GO

-- =============================================
-- Cowrie - ClientFingerprint 
--		cowrie.client.fingerprint
-- =============================================

/*
ClientFingerprint
Id				- FK INT	- Id				- Logs/Cowrie			- 		
'username'		- FK INT	- Username			- Rolodex/Usernames		- NOT NULL
'fingerprint'	- FK INT	- Fingerprint		- Rolodex/Fingerprints	- NOT NULL
'key'			- FK INT	- Key				- Rolodex/PublicKeys	- NOT NULL
'type'			- FK INT	- Type				- Reference/KeyTypes	- NOT NULL
*/
CREATE TABLE [Cowrie].[ClientFingerprint] (
	[Id]				INT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[FingerprintID]		INT NOT NULL,
	[KeyID]				INT NOT NULL,
	[TypeID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientFingerprint_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Fingerprint
		FOREIGN KEY ([FingerprintID]) 
		REFERENCES [Rolodex].[Fingerprints]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Key
		FOREIGN KEY ([KeyID]) 
		REFERENCES [Rolodex].[PublicKeys]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Type
		FOREIGN KEY ([TypeID]) 
		REFERENCES [Reference].[KeyTypes]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientFingerprint] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[ClientFingerprint]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientFingerprint]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientFingerprint]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[ClientFingerprint]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientFingerprint]  TO [CowrieLogReader]
GO

-- =============================================
-- Cowrie - ClientSize 
--		cowrie.client.size
-- =============================================

/*
ClientSize
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'width'		- INT			- TTYWidth			-						- NOT NULL
'height'	- INT			- TTYHeight			-						- NOT NULL
*/
CREATE TABLE [Cowrie].[ClientSize] (
	[Id]				INT NOT NULL,
	[Width]				INT NOT NULL,
	[Height]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientSize_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientSize] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[ClientSize]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientSize]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientSize]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[ClientSize]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[ClientSize]  TO [CowrieLogReader]
GO


-- =============================================
-- Cowrie - Login 
--		cowrie.login.failed
--		cowrie.login.success
-- =============================================

/*
Login - Combination of cowrie.login.failed and cowrie.login.success
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'success'	- BIT			- Success			-						- NOT NULL
'failed'	- BIT			- Failed			-						- NOT NULL
'username'	- FK INT		- Username			- Rolodex/Usernames		- NOT NULL
'password'	- FK INT		- Password			- Rolodex/Passwords		- NOT NULL
-- Check - Success != Failed AND Success NOT NULL AND Failed NOT NULL
*/
CREATE TABLE [Cowrie].[Login] (
	[Id]				INT NOT NULL,
	[Success]			BIT NOT NULL,
	[Failed]			BIT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[PasswordID]		INT NOT NULL,
	CONSTRAINT CK_Cowrie_Login_Success_Or_Failure_XOR CHECK ([Success] != [Failed]),
	CONSTRAINT FK_Cowrie_Login_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Password
		FOREIGN KEY ([PasswordID]) 
		REFERENCES [Rolodex].[Passwords]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Login] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[Login]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[Login]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Login]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[Login]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[Login]  TO [CowrieLogReader]
GO

-- =============================================
-- Cowrie - Command 
--		cowrie.command.input
--		cowrie.command.failed
--		cowrie.command.success
-- =============================================

/*
Command - Combination of cowrie.command.input, success, and failed
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'success'	- TINYINT		- Success			-						- NOT NULL DEFAULT 0
'failed'	- TINYINT		- Failed			-						- NOT NULL DEFAULT 0
'______'	- TINYINT		- Input				-						- NOT NULL DEFAULT 0
'input'		- FK INT		- Command			- Cowrie/InputCommands	- NOT NULL
-- Check - (Success + Failed + Input) = 1
-- Check - (Success in (0,1), Failed in (0,1), Input in (0,1))
*/
CREATE TABLE [Cowrie].[Command] (
	[Id]				INT NOT NULL,
	[Success]			TINYINT NOT NULL DEFAULT 0,
	[Failed]			TINYINT NOT NULL DEFAULT 0,
	[Input]				TINYINT NOT NULL DEFAULT 0,
	[CommandID]			INT NOT NULL,
	CONSTRAINT CK_Cowrie_Command_Success_Failure_Input_XOR CHECK (([Success] + [Failed] + [Input]) = 1),
	CONSTRAINT CK_Cowrie_Command_Success_In CHECK ([Success] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Failed_In CHECK ([Failed] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Input_In CHECK ([Input] IN (0, 1)),
	CONSTRAINT FK_Cowrie_Command_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Command_Command
		FOREIGN KEY ([CommandID]) 
		REFERENCES [Cowrie].[InputCommands]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Command] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[Command]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[Command]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Command]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[Command]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[Command]  TO [CowrieLogReader]
GO

-- Select All Command Logs
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

-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandLogs] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[CommandLogs]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandLogs]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandLogs]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[CommandLogs]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandLogs]  TO [CowrieLogReader]
GO

-- View All Input Commands
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

-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandInputLogs] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[CommandInputLogs]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandInputLogs]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandInputLogs]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[CommandInputLogs]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandInputLogs]  TO [CowrieLogReader]
GO



-- View All Success Commands
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

-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandSuccessLogs] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[CommandSuccessLogs]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandSuccessLogs]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandSuccessLogs]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[CommandSuccessLogs]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandSuccessLogs]  TO [CowrieLogReader]
GO

-- View all Failed Commands
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

-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[CommandFailedLogs] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[CommandFailedLogs]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandFailedLogs]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[CommandFailedLogs]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[CommandFailedLogs]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[CommandFailedLogs]  TO [CowrieLogReader]
GO


-- =============================================
-- Cowrie - SessionFiles 
--		cowrie.session.file_upload
--		cowrie.session.file_download
-- =============================================

/*
--  Combined table. should be a view anyways
SessionFileUploads
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
'shasum'	- CHAR(64)		- ShaSum			-						- NOT NULL

SessionFileDownloads
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
'shasum'	- CHAR(64)		- ShaSum			-						- NOT NULL
'duplicate'	- BIT			- Duplicate			-						- NOT NULL
*/
CREATE TABLE [Cowrie].[SessionFiles] (
	[Id]				INT NOT NULL,
	[Filename]			VARCHAR(255) NOT NULL,
	[Outfile]			VARCHAR(255) NOT NULL,
	[ShaSum]			CHAR(64) NOT NULL,
	[Duplicate]			BIT NOT NULL DEFAULT 0,
	CONSTRAINT FK_Cowrie_SessionFiles_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFiles] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFiles]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[SessionFiles]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFiles]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFiles]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[SessionFiles]  TO [CowrieLogReader]
GO

-- =============================================
-- Cowrie - SessionFileDownloadFailures 
--		cowrie.session.file_download.failed
-- =============================================

/*
SessionFileDownloadFailures
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'url'		- FK INT		- Url				- Rolodex/Urls			- NOT NULL
*/
CREATE TABLE [Cowrie].[SessionFileDownloadFailures] (
	[Id]				INT NOT NULL,
	[UrlID]				INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_Url
		FOREIGN KEY ([UrlID]) 
		REFERENCES [Rolodex].[Urls]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionFileDownloadFailures] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[SessionFileDownloadFailures]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[SessionFileDownloadFailures]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[SessionFileDownloadFailures]  TO [CowrieLogReader]
GO

-- =============================================
-- Cowrie - DirectTcpIpRequest 
--		cowrie.direct-tcpip.request
-- =============================================

/*
DirectTcpIpRequest
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'dst_ip'	- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
'src_port'	- INT			- SourcePort		-						- 0, GTE 0, LTE 65535, not null		
*/
CREATE TABLE [Cowrie].[DirectTcpIpRequest] (
	[Id]				INT NOT NULL,
	[SourcePort]		INT NOT NULL,
	[DestinationPort]	INT NOT NULL,
	[DestinationID]		INT	NOT NULL,
	CONSTRAINT CK_Cowrie_DirectTcpIpRequest_SourcePort_Bounds CHECK ([SourcePort] BETWEEN 0 AND 65535),
	CONSTRAINT CK_Cowrie_DirectTcpIpRequest_DestinationPort_Bounds CHECK ([DestinationPort] BETWEEN 0 AND 65535),
	CONSTRAINT FK_Cowrie_DirectTcpIpRequest_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_DirectTcpIpRequest_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpRequest] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[DirectTcpIpRequest]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpRequest]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[DirectTcpIpRequest]  TO [CowrieLogReader]
GO
-- =============================================
-- Cowrie - DirectTcpIpData 
--		cowrie.direct-tcpip.data
-- =============================================

/*
DirectTcpIpData
Id			- FK INT		- Id				- Logs/Cowrie			- 		
'dst_ip'	- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
'data'		- FK INT		- Data				- Cowrie/DirectTcpIpData- NOT NULL
'id'		- INT			- Identifier		-						- NOT NULL
*/
CREATE TABLE [Cowrie].[DirectTcpIpData] (
	[Id]				INT NOT NULL,
	[DestinationPort]	INT NOT NULL CHECK ([DestinationPort] <= 65535),
	[DestinationID]		INT	NOT NULL,
	[DataID]			INT	NOT NULL,
	[Identifier]		INT	NOT NULL,
	CONSTRAINT FK_Cowrie_DirectTcpIpData_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id]),
	CONSTRAINT FK_Cowrie_DirectTcpIpData_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id]),
	CONSTRAINT FK_Cowrie_DirectTcpIpData_Data
		FOREIGN KEY ([DataID]) 
		REFERENCES [Cowrie].[DirectTcpIpDataValues]([Id])
);
GO
-- Logs Manager
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpData] TO [LogsManager]
GO
-- Logs Viewer
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData]  TO [LogsViewer]
GO
DENY DELETE, INSERT ON [Cowrie].[DirectTcpIpData]  TO [LogsViewer]
GO

-- Cowrie Writer
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData]  TO [CowrieLogWriter]
GO
-- Cowrie Reader
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpData]  TO [CowrieLogReader]
GO
DENY DELETE, INSERT ON [Cowrie].[DirectTcpIpData]  TO [CowrieLogReader]
GO
