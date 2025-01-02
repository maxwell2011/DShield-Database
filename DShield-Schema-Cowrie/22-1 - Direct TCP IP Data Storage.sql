USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.direct-tcpip.data
-- Description:
-- DirectTcpIpData
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
-- 'data'		- FK INT		- Data				- Cowrie/DirectTcpIpData- NOT NULL
-- 'id'		- INT			- Identifier		-						- NOT NULL
-- =============================================
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

