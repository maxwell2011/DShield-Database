USE [DShield]
GO

-- =============================================
-- Reference Schema
--  Relatively static, 
--  source of a lot of FK constraints
-- =============================================
-- =============================================
-- Reference - Drop Procedures
-- =============================================
IF OBJECT_ID('[Reference].[UpsertCloudProviderSubnets]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertCloudProviderSubnet]
GO
IF OBJECT_ID('[Reference].[UpsertCloudProvider]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertCloudProvider]
GO
IF OBJECT_ID('[Reference].[UpsertArchitecture]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertArchitecture]
GO
-- =============================================
-- Reference - Drop Tables
-- =============================================
IF OBJECT_ID('[Reference].[RFC]', 'U') IS NOT NULL
  DROP TABLE [Reference].[RFC]
GO

IF OBJECT_ID('[Reference].[Protocols]', 'U') IS NOT NULL
  DROP TABLE [Reference].[Protocols]
GO

IF OBJECT_ID('[Reference].[CloudProviderSubnets]', 'U') IS NOT NULL
  DROP TABLE [Reference].[CloudProviderSubnets]
GO


IF OBJECT_ID('[Reference].[CloudProviders]', 'U') IS NOT NULL
  DROP TABLE [Reference].[CloudProviders]
GO

IF OBJECT_ID('[Reference].[Architectures]', 'U') IS NOT NULL
  DROP TABLE [Reference].[Architectures]
GO

IF OBJECT_ID('[Reference].[KeyTypes]', 'U') IS NOT NULL
  DROP TABLE [Reference].[KeyTypes]
GO

-- =============================================
-- Reference - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Reference')
    DROP SCHEMA [Reference]
GO

CREATE SCHEMA [Reference]
GO
