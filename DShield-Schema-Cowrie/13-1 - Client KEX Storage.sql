USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Client Key Exchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.client.kex
-- Description:
-- ClientKeyExchange
-- Id			- FK INT	- Id					- Logs/Cowrie							- 		
-- 'hassh'		- FK INT	- Hassh					- Reference/Hassh						- NULL, null if not cowrie.client.kex
-- 'hasshAlgorithms'
-- 				- FK INT	- HasshAlgorithms		- HasshAlgorithms						- NOT NULL
-- 'kexAlgs'	- FK INT	- KeyExchangeAlgorithms	- Reference/KeyExchangeAlgorithms		- NOT NULL
-- 'keyAlgs'	- FK INT	- KeyAlgorithms			- Reference/KeyAlgorithms				- NOT NULL
-- 'encCS'		- FK INT	- EncryptionAlgorithms	- Reference/EncryptionAlgorithms		- NOT NULL (Client To Server)
-- 'macCS'		- FK INT	- MACAlgorithms			- Reference/MessageAuthCipherAlgorithms	- NOT NULL (Client To Server)
-- 'compCS'		- FK INT	- CompressionAlgorithms	- Reference/CompressionAlgorithms		- NOT NULL (Client To Server)
-- 'langCS'		- FK INT	- Languages				- Reference/Languages					- NOT NULL (Client To Server)
-- =============================================
CREATE TABLE [Cowrie].[ClientKeyExchange] (
	[Id]						INT NOT NULL,
	[HasshID]					INT NOT NULL,
	CONSTRAINT FK_Cowrie_ClientKeyExchange_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_ClientKeyExchange_Hassh
		FOREIGN KEY ([HasshID]) 
		REFERENCES [Rolodex].[Hassh]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
