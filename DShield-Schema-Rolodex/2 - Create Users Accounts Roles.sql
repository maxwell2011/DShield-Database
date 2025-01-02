USE [DShield]
GO

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexManager' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexManager] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexExecutor] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexWriter' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexWriter] 
	AUTHORIZATION db_securityadmin;
GO
-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [RolodexReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'RolodexReader' AND 
		type = 'R'
		)
	CREATE ROLE [RolodexReader] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       IPAddress Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for IPAddress Schema
-- =============================================
EXEC sp_addrolemember 'IPAddressManager', 'RolodexManager'
EXEC sp_addrolemember 'IPAddressWriter', 'RolodexWriter'
EXEC sp_addrolemember 'IPAddressExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'IPAddressReader', 'RolodexReader'
GO

-- =============================================
-- Title:       Fingerprints Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'FingerprintManager', 'RolodexManager'
EXEC sp_addrolemember 'FingerprintWriter', 'RolodexWriter'
EXEC sp_addrolemember 'FingerprintExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'FingerprintReader', 'RolodexReader'
GO

-- =============================================
-- Title:       PublicKeys Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'PublicKeyManager', 'RolodexManager'
EXEC sp_addrolemember 'PublicKeyWriter', 'RolodexWriter'
EXEC sp_addrolemember 'PublicKeyExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'PublicKeyReader', 'RolodexReader'
GO

-- =============================================
-- Title:       Reference Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Role
-- Description:
--	Map Permissions for Fingerprint Schema
-- =============================================
EXEC sp_addrolemember 'ReferenceManager', 'RolodexManager'
EXEC sp_addrolemember 'ReferenceWriter', 'RolodexWriter'
EXEC sp_addrolemember 'ReferenceExecutor', 'RolodexExecutor'
EXEC sp_addrolemember 'ReferenceReader', 'RolodexReader'
GO