USE [DShield]
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [SessionId].[Storage] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[SessionId].[Storage] TO [SessionIdExecutor]; 
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [SessionId].[Storage] TO [SessionIdReader]
GO

-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[ToBinary] TO [SessionIdReader];
GO

-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdExecutor];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdWriter];
GO
-- =============================================
-- Title:       SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[FromBinary] TO [SessionIdReader];
GO


-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdReader]
GO

-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdReader]
GO