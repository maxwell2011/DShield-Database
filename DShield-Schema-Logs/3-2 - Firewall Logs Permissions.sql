USE [DShield]
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Firewall] TO [FirewallLogsManager]
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Firewall] TO [FirewallLogsExecutor] 
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

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertFirewallLogs] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetFirewallLogs] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastFirewallLogDate] TO [FirewallLogsReader]
GO

-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsManager]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsWriter]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Firewall Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[FirewallObservations] TO [FirewallLogsReader]
GO