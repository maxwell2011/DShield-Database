USE [DShield]
GO

-- =============================================
-- Permissions - Drop Views
-- =============================================
IF OBJECT_ID('[Permissions].[GuestUser]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[GuestUser]
GO

IF OBJECT_ID('[Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[UsersWithConnect]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithConnect]
GO

IF OBJECT_ID('[Permissions].[RolesWithConnect]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithConnect]
GO

IF OBJECT_ID('[Permissions].[UsersWithViewAnyColumnMasterKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithViewAnyColumnMasterKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[RolesWithViewAnyColumnMasterKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithViewAnyColumnMasterKeyDefinition]
GO
-- =============================================
-- Permissions Schema
--  Database permissions management utilities
-- =============================================
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Permissions')
    DROP SCHEMA [Permissions]
GO

CREATE SCHEMA [Permissions]
GO
