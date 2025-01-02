USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  a string representation of a cowrie event id name
-- =============================================
CREATE TABLE [Cowrie].[EventIds] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(64) NOT NULL UNIQUE
);
GO

