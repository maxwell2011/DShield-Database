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

