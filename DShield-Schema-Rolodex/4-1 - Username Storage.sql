USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store unique Usernames observed in the wild
-- =============================================
CREATE TABLE [Rolodex].[Usernames] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(255) NOT NULL
);
GO
-- Index on Username to prevent duplicates
CREATE INDEX IX_Rolodex_Usernames_Username ON [Rolodex].[Usernames]([Value]);
GO
