USE [DShield]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Firewall Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Firewall] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2 NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [SourcePort]    INT NOT NULL,
    [TargetID]      BIGINT NOT NULL,
    [TargetPort]    INT NOT NULL,
    [Protocol]      INT NOT NULL,
    CONSTRAINT FK_Logs_Firewall_Source FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Target FOREIGN KEY ([TargetID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Protocol FOREIGN KEY ([Protocol]) 
        REFERENCES [Reference].[Protocols]([Number])
);
CREATE INDEX IX_Logs_Firewall_LogTimestamp 
    ON [Logs].[Firewall]([LogTimestamp]);
CREATE INDEX IX_Logs_Firewall_SourceID 
    ON [Logs].[Firewall]([SourceID]);
GO
-- =============================================
-- Title:       Logs - Firewall
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Firewall] TO [LogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Firewall] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Firewall] TO [LogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - Firewall
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
GRANT REFERENCES, SELECT ON [Logs].[Firewall] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Firewall] TO [FirewallLogsManager];
GO
-- =============================================
-- Title:       Logs - Firewall
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Logs].[Firewall] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Firewall] TO [FirewallLogsExecutor]; 
GO

-- =============================================
-- Title:       Logs - Firewall
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
GRANT REFERENCES, SELECT ON [Logs].[Firewall] TO [FirewallLogsReader]
GO