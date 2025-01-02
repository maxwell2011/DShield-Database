USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Schema
-- Description:
--	Manage Fingerprints of Clients/Servers
--  efficiently
-- =============================================

-- =============================================
-- Fingerprint - Drop Views
-- =============================================
-- =============================================
-- Fingerprint - Drop Procedures
-- =============================================
IF OBJECT_ID('[Fingerprint].[UpsertText]', 'P') IS NOT NULL
    DROP PROCEDURE [Fingerprint].[UpsertText]
GO
IF OBJECT_ID('[Fingerprint].[UpsertBinary]', 'P') IS NOT NULL
    DROP PROCEDURE [Fingerprint].[UpsertBinary]
GO

-- =============================================
-- Fingerprint - Drop Functions
-- =============================================
IF OBJECT_ID('[Fingerprint].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [Fingerprint].[ToBinary]
GO
IF OBJECT_ID('[Fingerprint].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [Fingerprint].[FromBinary]
GO

-- =============================================
-- Fingerprint - Drop Tables
-- =============================================

IF OBJECT_ID('[Fingerprint].[Storage]', 'U') IS NOT NULL
    DROP TABLE [Fingerprint].[Storage]
GO
-- =============================================
-- Fingerprint - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Fingerprint')
	DROP SCHEMA [Fingerprint];
GO
CREATE SCHEMA [Fingerprint]
GO