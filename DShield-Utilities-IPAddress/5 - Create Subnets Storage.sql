USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store Subnet addresses and associated
--  Netmask values (in CIDR notation)
-- =============================================


CREATE TABLE [IPAddress].[Subnets] (
    [Id]            BIGINT NOT NULL,
    [Value]         VARBINARY(16) NOT NULL,
    [CIDR]          TINYINT NOT NULL CHECK ([CIDR] <= 96),
    [Netmask]       VARBINARY(16) NOT NULL,
    [Bogon]         BIT NOT NULL DEFAULT 0,
    [Comment]       VARCHAR(128) NULL,
    CONSTRAINT UQ_IPAddress_Subnets_Address_CIDR_Netmask UNIQUE CLUSTERED ([Value], [CIDR], [Netmask]),
    CONSTRAINT FK_IPAddress_Subnets_Storage_Id
		FOREIGN KEY ([Id]) 
		REFERENCES [IPAddress].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    CONSTRAINT FK_IPAddress_Subnets_Storage_Value
		FOREIGN KEY ([Value]) 
		REFERENCES [IPAddress].[Storage]([Value])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'First address in the subnet, eg: 192.168.0.0',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Address'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'CIDR, eg: the 24 in CIDR slash 24',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'CIDR'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Netmask, eg: 255.255.0.0 for 192.168.0.0/16, in VARBINARY',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Netmask'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bool flag to tag a subnet as a bogon (nonpublic)',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Bogon'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Comments or observations about subnet, NOT for ownership',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Comment'

GO

-- =============================================
-- Title:       IPAddress - Subnets
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
GRANT SELECT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Subnets] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressManager] WITH GRANT OPTION; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressManager] WITH GRANT OPTION; 
GO

-- =============================================
-- Title:       IPAddress - Subnets
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
GRANT SELECT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor]; 
GO
-- =============================================
-- Title:       IPAddress - Subnets
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
GRANT SELECT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressWriter];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Subnets] TO [IPAddressWriter]; 
GO
GRANT INSERT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressWriter]; 
GO
GRANT DELETE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressWriter]; 
GO
GRANT UPDATE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressWriter]; 
GO
-- =============================================
-- Title:       IPAddress - Subnets
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
GRANT SELECT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressReader];
GO
GRANT REFERENCES ON OBJECT::[IPAddress].[Subnets] TO [IPAddressReader]; 
GO
DENY INSERT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressReader]; 
GO
DENY DELETE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressReader]; 
GO
DENY UPDATE ON OBJECT::[IPAddress].[Subnets] TO [IPAddressReader]; 
GO

-- =============================================
-- Title:       IPAddress - RFC 1918 Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table Update
-- Description:
--	Add essential RFC 1918 Subnets to 
--  repository
-- Source:
--  https://datatracker.ietf.org/doc/html/rfc1918
-- =============================================
INSERT INTO [IPAddress].[Subnets] 
    ([Address], [CIDR], [Netmask], [Bogon], [Comment])
VALUES 
    ([IPAddress].[ToBinary]('192.168.0.0'),16,[IPAddress].[ToBinary]('192.168.255.255'),1,'RFC 1918 - Private'),
    ([IPAddress].[ToBinary]('172.16.0.0'), 12,[IPAddress].[ToBinary]('172.31.255.255'), 1,'RFC 1918 - Business'),
    ([IPAddress].[ToBinary]('10.0.0.0'),   8, [IPAddress].[ToBinary]('10.255.255.255'), 1,'RFC 1918 - Enterprise');
GO
-- =============================================
-- Title:       IPAddress - Bogon Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table Update
-- Description:
--	Add essential IPv4 and IPv6 Bogon Subnets to
--  repository
-- Source:
--  https://ipinfo.io/bogon
-- =============================================
INSERT INTO [IPAddress].[Subnets] 
    ([Address], [CIDR], [Netmask], [Bogon], [Comment])
VALUES 
    ([IPAddress].[ToBinary]('0.0.0.0'),		8,	[IPAddress].[ToBinary]('0.255.255.255'),	1,'"This" network'),
    ([IPAddress].[ToBinary]('100.64.0.0'),	10,	[IPAddress].[ToBinary]('100.127.255.255'),1,'Carrier-grade NAT'),
    ([IPAddress].[ToBinary]('127.0.0.0'),		8,	[IPAddress].[ToBinary]('127.255.255.255'),1,'Loopback'),
    ([IPAddress].[ToBinary]('127.0.53.53'),	0,	[IPAddress].[ToBinary]('255.255.255.255'),1,'Name collision occurrence'),
    ([IPAddress].[ToBinary]('169.254.0.0'),	16,	[IPAddress].[ToBinary]('169.254.255.255'),1,'Link local'),
    ([IPAddress].[ToBinary]('192.0.0.0'),		24,	[IPAddress].[ToBinary]('192.0.0.255'),	1,'IETF protocol assignments'),
    ([IPAddress].[ToBinary]('192.0.2.0'),		24,	[IPAddress].[ToBinary]('192.0.2.255'),	1,'TEST-NET-1');
GO