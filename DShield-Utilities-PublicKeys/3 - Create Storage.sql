USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [PublicKey].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(MAX) NOT NULL
);
GO
-- Index on PublicKey to prevent duplicates
CREATE INDEX IX_PublicKey_Storage_Value ON [PublicKey].[Storage]([Value]);
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [PublicKey].[Storage] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[PublicKey].[Storage] TO [PublicKeyExecutor]; 
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyReader]
GO


