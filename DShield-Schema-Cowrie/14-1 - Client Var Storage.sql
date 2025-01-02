USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Var
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.var
-- Description:
-- ClientVar
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'name'		- CHAR(32)		- Name				-						- NOT NULL
-- 'value'		- CHAR(32)		- Value				-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientVar] (
	[Id]				INT NOT NULL,
	[Name]				CHAR(32) NOT NULL,
	[Value]				CHAR(32) NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVar_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
