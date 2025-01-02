USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Hassh
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Rolodex].[Hassh] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	CHAR(32) NOT NULL UNIQUE
);
GO
