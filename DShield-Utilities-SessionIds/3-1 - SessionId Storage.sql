USE [DShield]
GO

-- =============================================
-- Title:       SessionId - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--  Table to store unique fingerprints as binary (All)
-- =============================================
CREATE TABLE [SessionId].[Storage] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	VARBINARY(16) NOT NULL
);
GO
-- Index on SessionId to prevent duplicates
CREATE INDEX IX_SessionId_Storage_Value ON [SessionId].[Storage]([Value]);
GO


