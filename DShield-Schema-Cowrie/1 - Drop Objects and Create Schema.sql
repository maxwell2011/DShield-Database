USE [DShield]
GO

-- =============================================
-- Cowrie Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================
-- =============================================
-- Cowrie - Drop Views
-- =============================================
IF OBJECT_ID('[Cowrie].[LastFirewallLogDate]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[LastFirewallLogDate]
GO
IF OBJECT_ID('[Cowrie].[LastHoneypotLogDate]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[LastHoneypotLogDate]
GO
IF OBJECT_ID('[Cowrie].[LastRawSSHLogDate]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[LastRawSSHLogDate]
GO

IF OBJECT_ID('[Cowrie].[FirewallObservations]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[FirewallObservations]
GO
IF OBJECT_ID('[Cowrie].[HoneypotObservations]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[HoneypotObservations]
GO
IF OBJECT_ID('[Cowrie].[RawSSHObservations]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[RawSSHObservations]
GO

IF OBJECT_ID('[Cowrie].[UrlsObserved]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[UrlsObserved]
GO
IF OBJECT_ID('[Cowrie].[IpAddressesObserved]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[IpAddressesObserved]
GO
IF OBJECT_ID('[Cowrie].[UserAgentsObserved]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[UserAgentsObserved]
GO
IF OBJECT_ID('[Cowrie].[LoginsObserved]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[LoginsObserved]
GO
-- =============================================
-- Cowrie - Drop Procedures
-- =============================================
IF OBJECT_ID('[Cowrie].[InsertFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertFirewallLogs]
GO
IF OBJECT_ID('[Cowrie].[GetFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetFirewallLogs]
GO
IF OBJECT_ID('[Cowrie].[InsertHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertHoneypotLogs]
GO
IF OBJECT_ID('[Cowrie].[GetHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetHoneypotLogs]
GO
IF OBJECT_ID('[Cowrie].[InsertRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[InsertRawSSHLogs]
GO
IF OBJECT_ID('[Cowrie].[GetRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[GetRawSSHLogs]
GO
-- =============================================
-- Cowrie - Drop Tables
-- =============================================


IF OBJECT_ID('[Cowrie].[EventIds]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[EventIds]
GO

-- =============================================
-- Cowrie - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Cowrie')
    DROP SCHEMA [Cowrie]
GO

CREATE SCHEMA [Cowrie]
GO
