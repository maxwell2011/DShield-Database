USE [DShield]
GO

-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Request
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_download.failed
-- Description:
-- DirectTcpIpRequest
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'dst_ip'		- FK INT		- DestinationAddress- Rolodex/IPAddresses	- NOT NULL
-- 'dst_port'	- INT			- DestinationPort	-						- 0, GTE 0, LTE 65535, not null
-- 'src_port'	- INT			- SourcePort		-						- 0, GTE 0, LTE 65535, not null		
-- =============================================
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

