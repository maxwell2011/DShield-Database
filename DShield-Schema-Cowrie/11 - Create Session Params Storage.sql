USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.params
-- Description:
-- SessionParams
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'arch'		- FK INT		- Arch				- Reference/Archit.		- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionParams] (
	[Id]				INT NOT NULL,
	[ArchitectureID]	INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionParams_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id]),
	CONSTRAINT FK_Cowrie_SessionParams_Architecture
		FOREIGN KEY ([ArchitectureID]) 
		REFERENCES [Reference].[Architectures]([Id])
);
GO

-- =============================================
-- Title:       Cowrie - SessionParams
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionParams] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionParams
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionParams] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionParams
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
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[SessionParams] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionParams
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
GRANT REFERENCES, SELECT ON [Cowrie].[SessionParams] TO [CowrieReader]
GO