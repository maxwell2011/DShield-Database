USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Schema
-- Description:
--	Manage PublicKeys of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- PublicKey - Drop Views
-- =============================================
-- =============================================
-- PublicKey - Drop Procedures
-- =============================================
IF OBJECT_ID('[PublicKey].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [PublicKey].[UpsertText]
GO
IF OBJECT_ID('[PublicKey].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [PublicKey].[UpsertBinary]
GO

-- =============================================
-- PublicKey - Drop Functions
-- =============================================
IF OBJECT_ID('[PublicKey].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [PublicKey].[ToBinary]
GO
IF OBJECT_ID('[PublicKey].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [PublicKey].[FromBinary]
GO

-- =============================================
-- PublicKey - Drop Tables
-- =============================================

IF OBJECT_ID('[PublicKey].[Storage]', 'U') IS NOT NULL
    DROP TABLE [PublicKey].[Storage]
GO
-- =============================================
-- PublicKey - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'PublicKey')
	DROP SCHEMA [PublicKey];
GO
CREATE SCHEMA [PublicKey]
GO