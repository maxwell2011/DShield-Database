USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Manage IP Address Space as a module
-- =============================================

-- =============================================
-- IPAddress - Drop Views
-- =============================================
IF OBJECT_ID('[IPAddress].[IPv4AsBinary]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv4AsBinary]
GO
IF OBJECT_ID('[IPAddress].[IPv4AsString]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv4AsString]
GO
IF OBJECT_ID('[IPAddress].[IPv6AsBinary]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv6AsBinary]
GO
IF OBJECT_ID('[IPAddress].[IPv6AsString]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv6AsString]
GO
-- =============================================
-- IPAddress - Drop Functions
-- =============================================
IF OBJECT_ID('[IPAddress].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[FromBinary]
GO
IF OBJECT_ID('[IPAddress].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[ToBinary]
GO
IF OBJECT_ID('[IPAddress].[ToBigInt]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[ToBigInt]
GO
IF OBJECT_ID('[IPAddress].[IsIpInSubnet]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[IsIpInSubnet]
GO
-- =============================================
-- IPAddress - Drop Procedures
-- =============================================
IF OBJECT_ID('[IPAddress].[GetIPs]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[GetIPs]
GO
IF OBJECT_ID('[IPAddress].[InsertIP]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[InsertIP]
GO
IF OBJECT_ID('[IPAddress].[UpsertIP]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[UpsertIP]
GO
IF OBJECT_ID('[IPAddress].[Addresses_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Addresses_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[Bogons_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Bogons_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[Subnets_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Subnets_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[DropSynonymIfExists]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[DropSynonymIfExists]
GO
IF OBJECT_ID('[IPAddress].[NewSynonymIfNotExists]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[NewSynonymIfNotExists]
GO
IF OBJECT_ID('[IPAddress].[ApplyRolePermissionsToSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[ApplyRolePermissionsToSynonym]
GO
-- =============================================
-- IPAddress - Drop Tables
-- =============================================
IF OBJECT_ID('[IPAddress].[Subnets]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Subnets]
GO

IF OBJECT_ID('[IPAddress].[Bogons]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Bogons]
GO

IF OBJECT_ID('[IPAddress].[Addresses]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Addresses]
GO

IF OBJECT_ID('[IPAddress].[Storage]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Storage]
GO
-- =============================================
-- IPAddress - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'IPAddress')
	DROP SCHEMA [IPAddress];
GO
CREATE SCHEMA [IPAddress]
GO