USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique User Agents (All)
-- =============================================
CREATE TABLE [Rolodex].[UserAgents] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(1023) NOT NULL,
	CONSTRAINT UQ_Rolodex_UserAgents_Agent UNIQUE ([Value])
);
-- Index on Agent to prevent duplicates
CREATE INDEX IX_Rolodex_UserAgents_Agent ON [Rolodex].[UserAgents]([Value]);
GO
