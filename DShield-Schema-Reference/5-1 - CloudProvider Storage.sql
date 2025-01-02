USE [DShield]
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store unique Cloud Providers for
--	fast lookups
-- =============================================
CREATE TABLE [Reference].[CloudProviders](
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Value] NVARCHAR(255) NOT NULL,
	PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_Reference_CloudProviders_Name] 
		UNIQUE NONCLUSTERED ([Value] ASC)
	);
GO


