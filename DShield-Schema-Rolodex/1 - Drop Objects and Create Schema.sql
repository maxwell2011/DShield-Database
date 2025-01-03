USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Schema
-- Description:
--	Manage Rolodex of various important
--  identifiers such as IP Addresses, providers
--  usernames, etc, etc
-- =============================================

-- =============================================
-- Rolodex - Drop Views
-- =============================================

-- =============================================
-- Rolodex - Drop Functions
-- =============================================

-- =============================================
-- Rolodex - Drop Procedures
-- =============================================
IF OBJECT_ID('[Rolodex].[UpsertSSHClientVersion]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertSSHClientVersion]
GO
IF OBJECT_ID('[Rolodex].[UpsertUrl]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUrl]
GO
IF OBJECT_ID('[Rolodex].[UpsertPassword]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertPassword]
GO
IF OBJECT_ID('[Rolodex].[UpsertUsername]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUsername]
GO
IF OBJECT_ID('[Rolodex].[UpsertUserAgent]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertUserAgent]
GO
IF OBJECT_ID('[Rolodex].[UpsertHassh]', 'P') IS NOT NULL
    DROP PROCEDURE [Rolodex].[UpsertHassh]
GO
-- =============================================
-- Rolodex - Drop Tables
-- =============================================
IF OBJECT_ID('[Rolodex].[SSHClientVersions]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[SSHClientVersions]
GO
IF OBJECT_ID('[Rolodex].[Urls]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Urls]
GO
IF OBJECT_ID('[Rolodex].[Passwords]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Passwords]
GO
IF OBJECT_ID('[Rolodex].[Usernames]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Usernames]
GO
IF OBJECT_ID('[Rolodex].[UserAgents]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[UserAgents]
GO
IF OBJECT_ID('[Rolodex].[Hassh]', 'U') IS NOT NULL
    DROP TABLE [Rolodex].[Hassh]
GO
-- =============================================
-- Rolodex - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Rolodex')
    DROP SCHEMA [Rolodex]
GO

CREATE SCHEMA [Rolodex]
GO
