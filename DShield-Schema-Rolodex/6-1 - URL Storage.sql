USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique Urls Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Urls] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         NVARCHAR(2048) NOT NULL
);
GO
