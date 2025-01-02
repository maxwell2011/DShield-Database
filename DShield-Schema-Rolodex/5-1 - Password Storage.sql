USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Store Passwords observed in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Passwords] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(255) NOT NULL
);
GO
-- Index on Username to prevent duplicates
CREATE INDEX IX_Rolodex_Passwords_Password ON [Rolodex].[Passwords]([Value]);
GO
