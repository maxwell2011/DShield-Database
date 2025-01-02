USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - SessionFiles
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.session.file_upload
--				cowrie.session.file_download
-- Description:
--  Combined table. should be a view anyways
-- SessionFileUploads
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
-- 'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
-- 'shasum'		- CHAR(64)		- ShaSum			-						- NOT NULL
-- 
-- SessionFileDownloads
-- Id			- FK INT		- Id				- Logs/Cowrie			- 		
-- 'destfile'	- VARCHAR(255)	- Filename			- 						- NOT NULL
-- 'outfile'	- VARCHAR(255)	- Outfile			- 						- NOT NULL
-- 'shasum'		- CHAR(64)		- ShaSum			-						- NOT NULL
-- 'duplicate'	- BIT			- Duplicate			-						- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[SessionFiles] (
	[Id]				INT NOT NULL,
	[Filename]			VARCHAR(255) NOT NULL,
	[Outfile]			VARCHAR(255) NOT NULL,
	[ShaSum]			CHAR(64) NOT NULL,
	[Duplicate]			BIT NOT NULL DEFAULT 0,
	CONSTRAINT FK_Cowrie_SessionFiles_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
