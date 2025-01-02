USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Command
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Table
-- Event ID:	cowrie.command.input
--				cowrie.command.failed
--				cowrie.command.success
-- Description:
-- Command
-- Id			- FK INT	- Id				- Logs/Cowrie			- 		
-- 'success'	- TINYINT	- Success			-						- NOT NULL DEFAULT 0
-- 'failed'		- TINYINT	- Failed			-						- NOT NULL DEFAULT 0
-- '______'		- TINYINT	- Input				-						- NOT NULL DEFAULT 0
-- 'input'		- FK INT	- Command			- Cowrie/InputCommands	- NOT NULL
-- Check - (Success + Failed + Input) = 1
-- Check - (Success in (0,1), Failed in (0,1), Input in (0,1))
-- =============================================
CREATE TABLE [Cowrie].[Command] (
	[Id]				INT NOT NULL,
	[Success]			TINYINT NOT NULL DEFAULT 0,
	[Failed]			TINYINT NOT NULL DEFAULT 0,
	[Input]				TINYINT NOT NULL DEFAULT 0,
	[CommandID]			INT NOT NULL,
	CONSTRAINT CK_Cowrie_Command_Success_Failure_Input_XOR CHECK (([Success] + [Failed] + [Input]) = 1),
	CONSTRAINT CK_Cowrie_Command_Success_In CHECK ([Success] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Failed_In CHECK ([Failed] IN (0, 1)),
	CONSTRAINT CK_Cowrie_Command_Input_In CHECK ([Input] IN (0, 1)),
	CONSTRAINT FK_Cowrie_Command_LogId
		FOREIGN KEY ([Id]) 
		REFERENCES [Cowrie].[Logs]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Cowrie_Command_Command
		FOREIGN KEY ([CommandID]) 
		REFERENCES [Cowrie].[InputCommands]([Id])
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
GO
