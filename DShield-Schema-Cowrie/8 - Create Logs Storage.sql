USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
-- Logs, primary anchor table for cowrie logs
-- Input Name	- Type			- Column Name		- FK Table Name/Column	- Default
-- Id			- INT			- Id				-						- IDENTITY(1,1)		
-- 'timestamp'	- DATETIME2		- LogTimestamp		-						- NOT NULL
-- 'eventid'	- FK INT		- EventId			- Cowrie/EventIds		- NOT NULL
-- 'src_ip'		- FK INT		- SourceID			- Rolodex/IPAddresses	- NOT NULL
-- 'session'	- FK INT		- Session			- Cowrie/Sensors		- NOT NULL
-- 'message'	- FK INT		- Message			- Cowrie/Messages		- NOT NULL
-- 'sensor'		- FK INT		- Sensor			- Cowrie/Sensors		- NOT NULL --> 1
-- =============================================
CREATE TABLE [Cowrie].[Logs] (
	[Id]			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[LogTimestamp]	DATETIME2 NOT NULL,
	[EventIdID]		INT NOT NULL,
	[SourceID]		BIGINT	NOT NULL,
	[SessionID]		INT NOT NULL,
	[MessageID]		INT NOT NULL,
	[SensorID]		INT NOT NULL,
	CONSTRAINT FK_Cowrie_Logs_EventId
		FOREIGN KEY ([EventIdID]) 
		REFERENCES [Cowrie].[EventIds]([Id]),
	CONSTRAINT FK_Cowrie_Logs_SourceAddress
		FOREIGN KEY ([SourceID]) 
		REFERENCES [IPAddress].[Addresses]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Session
		FOREIGN KEY ([SessionID]) 
		REFERENCES [Cowrie].[Sensors]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Message
		FOREIGN KEY ([MessageID]) 
		REFERENCES [Cowrie].[Messages]([Id]),
	CONSTRAINT FK_Cowrie_Logs_Sensor
		FOREIGN KEY ([SensorID]) 
		REFERENCES [Cowrie].[Sensors]([Id])
);
GO

-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Logs] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Logs] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[Logs] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Logs] TO [CowrieReader]
GO