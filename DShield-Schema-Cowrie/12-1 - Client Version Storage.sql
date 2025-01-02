USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - ClientVersion
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.version
-- Description:
-- ClientVersion
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'version'	- FK INT		- Version			- Rolodex/SSHClientV.	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientVersion] (
	[Id]				INT NOT NULL,
	[VersionID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientVersion_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientVersion_Version
		FOREIGN KEY ([VersionID]) 
		REFERENCES [Rolodex].[SSHClientVersions]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
