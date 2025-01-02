USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Fingerprint].[Storage] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Fingerprint].[Storage] TO [FingerprintExecutor]; 
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Fingerprint].[Storage] TO [FingerprintReader]
GO


-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintExecutor];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintWriter];
GO
-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[ToBinary] TO [FingerprintReader];
GO


-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintExecutor];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintWriter];
GO
-- =============================================
-- Title:       Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[FromBinary] TO [FingerprintReader];
GO

-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintExecutor]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertBinary] TO [FingerprintReader]
GO

-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintManager];
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintWriter]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintExecutor]
GO
-- =============================================
-- Title:       Fingerprint - Fingerprints
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Fingerprint].[UpsertText] TO [FingerprintReader]
GO