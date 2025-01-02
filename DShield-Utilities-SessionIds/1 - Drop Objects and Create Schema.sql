USE [DShield]
GO

-- =============================================
-- Title:       SessionId - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Schema
-- Description:
--	Manage SessionIds of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- SessionId - Drop Views
-- =============================================
-- =============================================
-- SessionId - Drop Procedures
-- =============================================
IF OBJECT_ID('[SessionId].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [SessionId].[UpsertText]
GO
IF OBJECT_ID('[SessionId].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [SessionId].[UpsertBinary]
GO

-- =============================================
-- SessionId - Drop Functions
-- =============================================
IF OBJECT_ID('[SessionId].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [SessionId].[ToBinary]
GO
IF OBJECT_ID('[SessionId].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [SessionId].[FromBinary]
GO

-- =============================================
-- SessionId - Drop Tables
-- =============================================

IF OBJECT_ID('[SessionId].[Storage]', 'U') IS NOT NULL
    DROP TABLE [SessionId].[Storage]
GO
-- =============================================
-- SessionId - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'SessionId')
	DROP SCHEMA [SessionId];
GO
CREATE SCHEMA [SessionId]
GO