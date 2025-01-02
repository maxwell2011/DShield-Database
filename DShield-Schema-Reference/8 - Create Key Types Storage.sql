USE [DShield]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Reference].[KeyTypes] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(32) NOT NULL UNIQUE
);
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[KeyTypes] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[KeyTypes] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[KeyTypes] TO [ReferenceExecutor]; 
GO

-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[KeyTypes] TO [ReferenceReader]
GO

