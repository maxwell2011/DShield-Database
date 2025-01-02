USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionFileDownloadFailures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_download.failed
-- Description:
-- SessionFileDownloadFailures
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'url'		- FK INT		- Url				- Rolodex/Urls			- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionFileDownloadFailures] (
	[Id]				INT NOT NULL,
	[UrlID]				INT NOT NULL,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_SessionFileDownloadFailures_Url
		FOREIGN KEY ([UrlID]) 
		REFERENCES [Rolodex].[Urls]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
