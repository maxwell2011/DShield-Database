USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [PublicKey].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(MAX) NOT NULL
);
GO
-- Index on PublicKey to prevent duplicates
--CREATE INDEX IX_PublicKey_Storage_Value ON [PublicKey].[Storage]([Value]);
--GO



