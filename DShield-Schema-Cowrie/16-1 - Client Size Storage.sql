USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Size
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.size
-- Description:
-- ClientSize
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'width'		- INT		- TTYWidth			-						- NOT NULL
-- 'height'		- INT		- TTYHeight			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientSize] (
	[Id]				INT NOT NULL,
	[Width]				INT NOT NULL,
	[Height]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientSize_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
