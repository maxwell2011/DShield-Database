USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Login
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.login.failed
--				cowrie.login.success
-- Description:
-- Login
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'success'	- BIT		- Success			-						- NOT NULL
-- 'failed'		- BIT		- Failed			-						- NOT NULL
-- 'username'	- FK INT	- Username			- Rolodex/Usernames		- NOT NULL
-- 'password'	- FK INT	- Password			- Rolodex/Passwords		- NOT NULL
-- Check - Success != Failed AND Success NOT NULL AND Failed NOT NULL
-- =============================================
CREATE TABLE [Cowrie].[Login] (
	[Id]				INT NOT NULL,
	[Success]			BIT NOT NULL,
	[Failed]			BIT NOT NULL,
	[UsernameID]		INT NOT NULL,
	[PasswordID]		INT NOT NULL,
	CONSTRAINT CK_Cowrie_Login_Success_Or_Failure_XOR CHECK ([Success] != [Failed]),
	CONSTRAINT FK_Cowrie_Login_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Username
		FOREIGN KEY ([UsernameID]) 
		REFERENCES [Rolodex].[Usernames]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Login_Password
		FOREIGN KEY ([PasswordID]) 
		REFERENCES [Rolodex].[Passwords]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
