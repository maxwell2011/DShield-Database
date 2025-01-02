USE [DShield]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  RawSSH Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[RawSSH] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UsernameID]    INT NOT NULL,
    [PasswordID]    INT NOT NULL,
    CONSTRAINT FK_Logs_RawSSH_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Username
        FOREIGN KEY ([UsernameID]) 
        REFERENCES [Rolodex].[Usernames]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Password
        FOREIGN KEY ([PasswordID]) 
        REFERENCES [Rolodex].[Passwords]([Id]),
);
CREATE INDEX IX_Logs_RawSSH_LogTimestamp 
    ON [Logs].[RawSSH]([LogTimestamp]);
CREATE INDEX IX_Logs_RawSSH_SourceID 
    ON [Logs].[RawSSH]([SourceID]);
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[RawSSH] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[RawSSH] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[RawSSH] TO [LogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Logs].[RawSSH] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[RawSSH] TO [RawSSHLogsManager];
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[RawSSH] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[RawSSH] TO [RawSSHLogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Logs].[RawSSH] TO [RawSSHLogsReader]
GO