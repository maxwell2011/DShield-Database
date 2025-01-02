USE [DShield]
GO


-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[Login] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[Login] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Login Failed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginFailed] TO [CowrieReader]
GO

-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieExecutor]
GO
-- =============================================
-- Title:       Cowrie - Client Login Success
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Cowrie].[UpsertLogsLoginSuccess] TO [CowrieReader]
GO