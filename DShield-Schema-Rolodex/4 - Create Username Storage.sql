USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique Usernames observed in the wild
-- =============================================
CREATE TABLE [Rolodex].[Usernames] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(255) NOT NULL
);
GO
-- Index on Username to prevent duplicates
CREATE INDEX IX_Rolodex_Usernames_Username ON [Rolodex].[Usernames]([Value]);
GO

-- =============================================
-- Title:       Rolodex - Usernames
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Usernames] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
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
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Usernames] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Usernames
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
GRANT REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexReader]
GO
