USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv4 addresses from the 
--	Address table as VARBINARY(16)
-- =============================================

CREATE VIEW [IPAddress].[IPv4AsBinary]
	AS SELECT 
	[Id],
	[Value]			AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 4;
GO

-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv4 addresses from the 
--	Address table as VARCHAR(45)
-- =============================================

CREATE VIEW [IPAddress].[IPv4AsString]
	AS SELECT 
	[Id],
	[IPAddress].[FromBinary]([Value]) AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 4;
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