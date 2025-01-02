USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Table
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [Fingerprint].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(16) NOT NULL UNIQUE
);
GO
-- Index on Fingerprint to prevent duplicates
CREATE INDEX IX_Fingerprint_Storage_Value ON [Fingerprint].[Storage]([Value]);
GO
