USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a cowrie recorded input
-- =============================================
CREATE TABLE [Cowrie].[DirectTcpIpDataValues] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO

-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
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
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[DirectTcpIpDataValues] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - DirectTcpIpDataValues
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
GRANT REFERENCES, SELECT ON [Cowrie].[DirectTcpIpDataValues] TO [CowrieReader]
GO