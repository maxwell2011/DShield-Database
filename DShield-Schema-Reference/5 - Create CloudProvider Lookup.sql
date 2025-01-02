USE [DShield]
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store unique Cloud Providers for
--	fast lookups
-- =============================================
CREATE TABLE [Reference].[CloudProviders](
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Value] NVARCHAR(255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
) WITH (
	PAD_INDEX = OFF, 
	STATISTICS_NORECOMPUTE = OFF, 
	IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, 
	ALLOW_PAGE_LOCKS = ON, 
	OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
	) ON [PRIMARY],
 CONSTRAINT [UQ_Reference_CloudProviders_Name] UNIQUE NONCLUSTERED 
(
	[Value] ASC
) WITH (
	PAD_INDEX = OFF, 
	STATISTICS_NORECOMPUTE = OFF, 
	IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, 
	ALLOW_PAGE_LOCKS = ON, 
	OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
	) ON [PRIMARY]
) ON [PRIMARY]
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviders] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviders] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviders] TO [ReferenceExecutor]; 
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[CloudProviders] TO [ReferenceReader]
GO

INSERT INTO [Reference].[CloudProviders] ([Value]) VALUES 
	('alibaba'),
	('amazon'),
	('baidu'),
	('cloudflare'),
	('digitalocean'),
	('dropbox'),
	('github'),
	('google'),
	('gotomeeting'),
	('huawei'),
	('oracle'),
	('salesforce'),
	('tencent');

GO