USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a sensor in a cowrie log
-- =============================================
-- 
CREATE TABLE [Cowrie].[Sensors] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(128) NOT NULL UNIQUE
);
GO
