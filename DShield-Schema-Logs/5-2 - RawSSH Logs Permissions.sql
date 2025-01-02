USE [DShield]
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Logs].[RawSSH] TO [RawSSHLogsManager]
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
GRANT REFERENCES, SELECT ON OBJECT::[Logs].[RawSSH] TO [RawSSHLogsExecutor] 
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

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Logs].[InsertRawSSHLogs] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Logs].[GetRawSSHLogs] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LastRawSSHLogDate] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT INSERT, REFERENCES, SELECT ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[RawSSHObservations] TO [RawSSHLogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [LogsReader]
GO

-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsManager]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsWriter]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsExecutor]
GO
-- =============================================
-- Title:       Logs - RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Reader
-- =============================================
GRANT SELECT, REFERENCES ON OBJECT::[Logs].[LoginsObserved] TO [RawSSHLogsReader]
GO
