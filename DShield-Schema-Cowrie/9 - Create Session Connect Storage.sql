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
	[DestinationID]		BIGINT	NOT NULL,
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

-- =============================================
-- Title:       Cowrie - SessionConnect
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionConnect] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionConnect
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionConnect] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionConnect
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
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[SessionConnect] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionConnect
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
GRANT REFERENCES, SELECT ON [Cowrie].[SessionConnect] TO [CowrieReader]
GO