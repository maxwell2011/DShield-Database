USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Rolodex].[Usernames] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Rolodex].[Usernames] TO [RolodexExecutor]; 
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Rolodex].[Usernames] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexReader]
GO