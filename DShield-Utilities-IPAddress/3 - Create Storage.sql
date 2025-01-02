USE [DShield]
GO
-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store unique IP addresses as 
--  Binary (All) (VARBINARY(16))
--  Indexed on Value to prevent duplicates
-- =============================================


CREATE TABLE [IPAddress].[Storage] (
    [Id]            BIGINT IDENTITY(1,1) PRIMARY KEY,
    [Value]         VARBINARY(16) NOT NULL
);
GO
-- Index on IP Address to prevent duplicates
CREATE INDEX IX_IPAddress_Storage_Address ON [IPAddress].[Storage]([Value]);
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique IP Addresses, stored as Binary',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Addresses',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Addresses',
    @level2type = N'INDEX',
    @level2name = N'IX_Hassh_IPAddresses_IPAddress'

GO

-- =============================================
-- Title:       IPAddress - Addresses
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
GRANT SELECT ON OBJECT::[IPAddress].[Storage] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Storage] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Storage] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Storage] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Storage] TO [IPAddressManager] WITH GRANT OPTION; 
GO

-- =============================================
-- Title:       IPAddress - Addresses
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
GRANT SELECT ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor]; 
GO
-- =============================================
-- Title:       IPAddress - Addresses
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
GRANT SELECT ON OBJECT::[IPAddress].[Storage] TO [IPAddressWriter];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Storage] TO [IPAddressWriter]; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Storage] TO [IPAddressWriter]; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Storage] TO [IPAddressWriter]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Storage] TO [IPAddressWriter]; 
GO
-- =============================================
-- Title:       IPAddress - Addresses
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
GRANT SELECT ON OBJECT::[IPAddress].[Storage] TO [IPAddressReader];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Storage] TO [IPAddressReader]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Storage] TO [IPAddressReader]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Storage] TO [IPAddressReader]; 
GO
DENY UPDATE ON OBJECT::[IPAddress].[Storage] TO [IPAddressReader]; 
GO