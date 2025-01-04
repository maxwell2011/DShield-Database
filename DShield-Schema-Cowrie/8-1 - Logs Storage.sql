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
	[SourceID]		INT	NOT NULL,
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
