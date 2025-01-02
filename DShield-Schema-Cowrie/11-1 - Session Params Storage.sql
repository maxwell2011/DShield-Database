USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionParams
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.params
-- Description:
-- SessionParams
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'arch'		- FK INT		- Arch				- Reference/Archit.		- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionParams] (
	[Id]				INT NOT NULL,
	[ArchitectureID]	INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionParams_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id]),
	CONSTRAINT FK_Cowrie_SessionParams_Architecture
		FOREIGN KEY ([ArchitectureID]) 
		REFERENCES [Reference].[Architectures]([Id])
);
GO
