USE [DShield]
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [SessionId].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(MAX) NOT NULL
);
GO
-- Index on SessionId to prevent duplicates
CREATE INDEX IX_SessionId_Storage_Value ON [SessionId].[Storage]([Value]);
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [SessionId].[Storage] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[SessionId].[Storage] TO [SessionIdExecutor]; 
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdReader]
GO


