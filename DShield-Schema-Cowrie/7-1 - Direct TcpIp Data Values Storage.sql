USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct Tcp/Ip Data
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Description:
--  String representation of a cowrie direct 
--	TCP IP input
-- =============================================
CREATE TABLE [Cowrie].[DirectTcpIpDataValues] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(MAX) NOT NULL
);
GO
