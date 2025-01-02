USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Input Commands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a cowrie recorded input
-- =============================================
CREATE TABLE [Cowrie].[InputCommands] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO
