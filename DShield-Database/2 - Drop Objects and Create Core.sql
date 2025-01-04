USE [DShield]
GO

-- =============================================
-- Core Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================

-- =============================================
-- Permissions Schema
--  Database permissions management utilities
-- =============================================
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Core')
    DROP SCHEMA [Core]
GO

CREATE SCHEMA [Core]
GO

-- =============================================
-- Title:       Login - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a login for the SANS ISC Service 
--	Account using a Windows user
-- ============================================= 
CREATE LOGIN [$(Domain)\sans_isc_svc] FROM WINDOWS WITH DEFAULT_DATABASE = DShield
GO
-- =============================================
-- Title:       User - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a user for login using the SANS ISC 
--	Service Account from a Windows user. Assign
--	default Schema as 'Core'
-- ============================================= 
CREATE USER [$(Domain)\sans_isc_svc]
	FOR LOGIN [$(Domain)\sans_isc_svc]
	WITH DEFAULT_SCHEMA = [Core]
GO