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
    @level1name = N'Storage',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Storage',
    @level2type = N'INDEX',
    @level2name = N'IX_IPAddress_Storage_Address'

GO
