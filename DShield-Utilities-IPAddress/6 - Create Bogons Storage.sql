USE [DShield]
GO
-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store Bogon IP addresses,
--  aka: loopback or non-public ranges
-- =============================================


CREATE TABLE [IPAddress].[Bogons] (
    [Id]            BIGINT NOT NULL,
    [Value]         VARBINARY(16) NOT NULL,
    CONSTRAINT FK_IPAddress_Bogons_Storage_Id
		FOREIGN KEY ([Id]) 
		REFERENCES [IPAddress].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    CONSTRAINT FK_IPAddress_Bogons_Storage_Value
		FOREIGN KEY ([Value]) 
		REFERENCES [IPAddress].[Storage]([Value])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);
GO
-- Index on Bogon IP Address to prevent duplicates
CREATE INDEX IX_IPAddress_Bogons ON [IPAddress].[Bogons]([Value]);
GO


EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique Bogon IP Addresses, stored as Binary',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Bogons',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique Bogon IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Bogons',
    @level2type = N'INDEX',
    @level2name = N'IX_IPAddress_Bogons'

GO

-- =============================================
-- Title:       IPAddress - Bogons
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
GRANT SELECT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Bogons] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressManager] WITH GRANT OPTION; 
GO

-- =============================================
-- Title:       IPAddress - Bogons
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
GRANT SELECT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor]; 
GO
-- =============================================
-- Title:       IPAddress - Bogons
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
GRANT SELECT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressWriter];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Bogons] TO [IPAddressWriter]; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressWriter]; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressWriter]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressWriter]; 
GO
-- =============================================
-- Title:       IPAddress - Bogons
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
GRANT SELECT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressReader];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Bogons] TO [IPAddressReader]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressReader]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressReader]; 
GO
DENY UPDATE ON OBJECT::[IPAddress].[Bogons] TO [IPAddressReader]; 
GO