USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv6 addresses from the 
--	Address table as VARBINARY(16)
-- =============================================

CREATE VIEW [IPAddress].[IPv6AsBinary]
	AS SELECT 
	[Id],
	[Value] AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 16;
GO

-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressManager] WITH GRANT OPTION; 
GO

-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor]; 
GO
-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressWriter];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressWriter]; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressWriter]; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressWriter]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressWriter]; 
GO
-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressReader];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressReader]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressReader]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressReader]; 
GO
DENY UPDATE ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressReader]; 
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv6 addresses from the 
--	Address table as VARCHAR(45)
-- =============================================

CREATE VIEW [IPAddress].[IPv6AsString]
	AS SELECT 
	[Id],
	[IPAddress].[FromBinary]([Value]) AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 16;
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressManager] WITH GRANT OPTION; 
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor]; 
GO
-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressWriter];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressWriter]; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressWriter]; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressWriter]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressWriter]; 
GO
-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT SELECT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressReader];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressReader]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressReader]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressReader]; 
GO
DENY UPDATE ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressReader]; 
GO