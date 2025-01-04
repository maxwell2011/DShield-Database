USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionConnect
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.connect
-- Description:
-- SessionConnect
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'src_port'	- INT			- SourcePort		-						- 0, GTE 0, LTE 65535, null if not cowrie.session.connect
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, null if not cowrie.session.connect
-- 'protocol'	- FK INT		- Protocol			- Reference/Protocols	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionConnect] (
	[Id]				INT NOT NULL,
	[SourcePort]		INT NOT NULL,
	[DestinationPort]	INT NOT NULL,
	[DestinationID]		INT	NOT NULL,
	[Protocol]			INT	NOT NULL,
	CONSTRAINT CK_Cowrie_SessionConnect_SourcePort_Bounds CHECK ([SourcePort] BETWEEN 0 AND 65535),
	CONSTRAINT CK_Cowrie_SessionConnect_DestinationPort_Bounds CHECK ([DestinationPort] BETWEEN 0 AND 65535),
	CONSTRAINT FK_Cowrie_SessionConnect_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionConnect_DestinationAddress
		FOREIGN KEY ([DestinationID]) 
		REFERENCES [IPAddress].[Addresses]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionConnect_Protocol
		FOREIGN KEY ([Protocol]) 
		REFERENCES [Reference].[Protocols]([Number])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
