USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a message in a cowrie log
-- =============================================
-- 
CREATE TABLE [Cowrie].[Messages] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO

