USE [DShield]
GO

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Store Reference Table of IP Ranges owned
--	by various major cloud providers
-- =============================================
CREATE TABLE [Reference].[CloudProviderSubnets] (
    [Id]				INT IDENTITY(1,1) PRIMARY KEY,
	[Subnet]			VARBINARY(16) NOT NULL,
	[NetMask]			INT NOT NULL,
    [CloudProviderID]   INT NOT NULL,
	[Comment]			NVARCHAR(255) NULL DEFAULT NULL,
	--CONSTRAINT UQ_Reference_CloudProviders_Ip UNIQUE ([SubnetID]),	-- Only one provider can own a range at a time...
	CONSTRAINT CK_Reference_CloudProviders_NetMask CHECK ([NetMask] >= 0 AND [NetMask] <= 128), -- Not perfect, but better than nothing
	CONSTRAINT FK_Reference_CloudProviderSubnets_Subnet FOREIGN KEY ([Subnet]) 
		REFERENCES [IPAddress].[Subnets]([Value]),
	CONSTRAINT FK_Reference_CloudProviderSubnets_CloudProvider FOREIGN KEY ([CloudProviderID]) 
		REFERENCES [Reference].[CloudProviders]([Id])
);
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
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
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviderSubnets] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
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
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviderSubnets] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
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
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviderSubnets] TO [ReferenceExecutor]; 
GO

-- =============================================
-- Title:       Reference - CloudProviderSubnets
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
GRANT REFERENCES, SELECT ON [Reference].[CloudProviderSubnets] TO [ReferenceReader]
GO
