USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique User Agents (All)
-- =============================================
CREATE TABLE [Rolodex].[UserAgents] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(1023) NOT NULL,
	CONSTRAINT UQ_Rolodex_UserAgents_Agent UNIQUE ([Value])
);
-- Index on Agent to prevent duplicates
--CREATE INDEX IX_Rolodex_UserAgents_Agent ON [Rolodex].[UserAgents]([Value]);
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[UserAgents] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[UserAgents] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[UserAgents] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[UserAgents] TO [RolodexReader]
GO


