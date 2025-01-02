USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.version
-- Description:
-- ClientVersion
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'version'	- FK INT		- Version			- Rolodex/SSHClientV.	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientVersion] (
	[Id]				INT NOT NULL,
	[VersionID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVersion_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientVersion_Version
		FOREIGN KEY ([VersionID]) 
		REFERENCES [Rolodex].[SSHClientVersions]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

-- =============================================
-- Title:       Cowrie - ClientVersion
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientVersion] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientVersion] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
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
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[ClientVersion] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - ClientVersion
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
GRANT REFERENCES, SELECT ON [Cowrie].[ClientVersion] TO [CowrieReader]
GO