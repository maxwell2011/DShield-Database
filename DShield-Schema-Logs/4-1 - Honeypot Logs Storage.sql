USE [DShield]
GO
-- =============================================
-- Title:       Logs - Honeypot
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  Honeypot Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[Honeypot] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [Count]         INT NOT NULL,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UrlID]         INT NOT NULL,
    [UserAgentID]   INT NOT NULL,
    CONSTRAINT FK_Logs_Honeypot_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_Honeypot_UserAgent
        FOREIGN KEY ([UserAgentID]) 
        REFERENCES [Rolodex].[UserAgents]([Id]),
    CONSTRAINT FK_Logs_Honeypot_Url
        FOREIGN KEY ([UrlID]) 
        REFERENCES [Rolodex].[Urls]([Id])
);
CREATE INDEX IX_Logs_Honeypot_LogTimestamp 
    ON [Logs].[Honeypot]([LogTimestamp]);
CREATE INDEX IX_Logs_Honeypot_SourceID 
    ON [Logs].[Honeypot]([SourceID]);
GO
