USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [PublicKey].[Storage] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[PublicKey].[Storage] TO [PublicKeyExecutor]; 
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [PublicKey].[Storage] TO [PublicKeyReader]
GO

-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyReader];
GO

-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyReader];
GO

-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyReader]
GO

-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyReader]
GO