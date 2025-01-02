USE [DShield]
GO
-- =============================================
-- Title:       Logs - RawSSH
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Table
-- Description:
--  RawSSH Logs, using the above IP Address types as FK's
-- =============================================
CREATE TABLE [Logs].[RawSSH] (
    [LogID]         BIGINT IDENTITY(1,1) PRIMARY KEY,
    [LogTimestamp]  DATETIME2(7) NOT NULL,
    [SourceID]      BIGINT NOT NULL,
    [UsernameID]    INT NOT NULL,
    [PasswordID]    INT NOT NULL,
    CONSTRAINT FK_Logs_RawSSH_Source 
        FOREIGN KEY ([SourceID]) 
        REFERENCES [IPAddress].[Addresses]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Username
        FOREIGN KEY ([UsernameID]) 
        REFERENCES [Rolodex].[Usernames]([Id]),
    CONSTRAINT FK_Logs_RawSSH_Password
        FOREIGN KEY ([PasswordID]) 
        REFERENCES [Rolodex].[Passwords]([Id]),
);
CREATE INDEX IX_Logs_RawSSH_LogTimestamp 
    ON [Logs].[RawSSH]([LogTimestamp]);
CREATE INDEX IX_Logs_RawSSH_SourceID 
    ON [Logs].[RawSSH]([SourceID]);
GO
