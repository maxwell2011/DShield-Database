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
    @level2name = N'Value'

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
