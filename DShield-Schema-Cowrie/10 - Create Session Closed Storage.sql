USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.closed
-- Description:
-- SessionClosed
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'duration'	- DOUBLE(7)		- Duration			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionClosed] (
	[Id]				INT NOT NULL,
	[Duration]			FLOAT NOT NULL,
	CONSTRAINT CK_Cowrie_SessionClosed_Duration_Bounds CHECK ([Duration] BETWEEN 0.0 AND 86400.0),
	CONSTRAINT FK_Cowrie_SessionClosed_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO

-- =============================================
-- Title:       Cowrie - SessionClosed
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[SessionClosed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[SessionClosed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
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
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[SessionClosed] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - SessionClosed
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
GRANT REFERENCES, SELECT ON [Cowrie].[SessionClosed] TO [CowrieReader]
GO