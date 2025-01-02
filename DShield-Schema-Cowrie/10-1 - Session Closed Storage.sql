USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionClosed
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.closed
-- Description:
-- SessionClosed
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'duration'	- DOUBLE(7)		- Duration			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionClosed] (
	[Id]				INT NOT NULL,
	[Duration]			FLOAT NOT NULL,
	CONSTRAINT CK_Cowrie_SessionClosed_Duration_Bounds CHECK ([Duration] BETWEEN 0.0 AND 86400.0),
	CONSTRAINT FK_Cowrie_SessionClosed_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
