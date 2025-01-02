USE [DShield]
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[Honeypot] TO [HoneypotLogsManager]
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[Honeypot] TO [HoneypotLogsExecutor] 
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

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertHoneypotLogs] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetHoneypotLogs] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastHoneypotLogDate] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[HoneypotObservations] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UrlsObserved] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[IpAddressesObserved] TO [HoneypotLogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsManager]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsWriter]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsExecutor]
GO
-- =============================================
-- Title:       Logs - Honeypot Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[UserAgentsObserved] TO [HoneypotLogsReader]
GO