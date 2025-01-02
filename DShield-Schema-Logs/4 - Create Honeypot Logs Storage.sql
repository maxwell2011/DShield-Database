USE [DShield]
GO
-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Honeypot Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Honeypot] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [Count]         INT NOT NULL,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UrlID]         INT NOT NULL,
    [UserAgentID]   INT NOT NULL,
    CONSTRAINT FK_Logs_Honeypot_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Honeypot_UserAgent
        FOREIGN KEY ([UserAgentID]) 
        REFERENCES [Rolodex].[UserAgents]([Id]),
    CONSTRAINT FK_Logs_Honeypot_Url
        FOREIGN KEY ([UrlID]) 
        REFERENCES [Rolodex].[Urls]([Id])
);
CREATE INDEX IX_Logs_Honeypot_LogTimestamp 
    ON [Logs].[Honeypot]([LogTimestamp]);
CREATE INDEX IX_Logs_Honeypot_SourceID 
    ON [Logs].[Honeypot]([SourceID]);
GO
-- =============================================
-- Title:       Logs - Honeypot
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Honeypot] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Honeypot] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Honeypot] TO [LogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - Honeypot
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
GRANT REFERENCES, SELECT ON [Logs].[Honeypot] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Honeypot] TO [HoneypotLogsManager];
GO
-- =============================================
-- Title:       Logs - Honeypot
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Honeypot] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Honeypot] TO [HoneypotLogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - Honeypot
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
GRANT REFERENCES, SELECT ON [Logs].[Honeypot] TO [HoneypotLogsReader]
GO