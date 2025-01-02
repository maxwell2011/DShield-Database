USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - ClientKeyExchange
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

-- =============================================
-- Title:       Cowrie - ClientKeyExchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Cowrie].[ClientKeyExchange] TO [CowrieManager];
GO
-- =============================================
-- Title:       Cowrie - ClientKeyExchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Cowrie].[ClientKeyExchange] TO [CowrieWriter]
GO
-- =============================================
-- Title:       Cowrie - ClientKeyExchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Cowrie].[ClientKeyExchange] TO [CowrieExecutor]; 
GO

-- =============================================
-- Title:       Cowrie - ClientKeyExchange
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Cowrie].[ClientKeyExchange] TO [CowrieReader]
GO