USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - SSH Client Versions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[SSHClientVersions] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(1023) NOT NULL UNIQUE
);
GO
