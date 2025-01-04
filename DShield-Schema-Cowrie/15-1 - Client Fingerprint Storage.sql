USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.fingerprint
-- Description:
-- ClientFingerprint
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'username'	- FK INT	- Username			- Rolodex/Usernames		- NOT NULL
-- 'fingerprint'- FK INT	- Fingerprint		- Rolodex/Fingerprints	- NOT NULL
-- 'key'		- FK INT	- Key				- Rolodex/PublicKeys	- NOT NULL
-- 'type'		- FK INT	- Type				- Reference/KeyTypes	- NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[ClientFingerprint] (
	[Id]				INT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[FingerprintID]		INT NOT NULL,
	[KeyID]				INT NOT NULL,
	[TypeID]			INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientFingerprint_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Fingerprint
		FOREIGN KEY ([FingerprintID]) 
		REFERENCES [Fingerprint].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Key
		FOREIGN KEY ([KeyID]) 
		REFERENCES [PublicKey].[Storage]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientFingerprint_Type
		FOREIGN KEY ([TypeID]) 
		REFERENCES [Reference].[KeyTypes]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);
GO
