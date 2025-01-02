USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Table
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [Fingerprint].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(16) NOT NULL UNIQUE
);
GO
-- Index on Fingerprint to prevent duplicates
CREATE INDEX IX_Fingerprint_Storage_Value ON [Fingerprint].[Storage]([Value]);
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Fingerprint].[Storage] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Fingerprint].[Storage] TO [FingerprintExecutor]; 
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintReader]
GO


