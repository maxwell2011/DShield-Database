USE [DShield]
GO
-- =============================================
-- Title:       Logs - Firewall
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  Firewall Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Firewall] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2 NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [SourcePort]    INT NOT NULL,
    [TargetID]      BIGINT NOT NULL,
    [TargetPort]    INT NOT NULL,
    [Protocol]      INT NOT NULL,
    CONSTRAINT FK_Logs_Firewall_Source FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Target FOREIGN KEY ([TargetID]) 
        REFERENCES [IPAddresses].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Firewall_Protocol FOREIGN KEY ([Protocol]) 
        REFERENCES [Reference].[Protocols]([Number])
);
CREATE INDEX IX_Logs_Firewall_LogTimestamp 
    ON [Logs].[Firewall]([LogTimestamp]);
CREATE INDEX IX_Logs_Firewall_SourceID 
    ON [Logs].[Firewall]([SourceID]);
GO


