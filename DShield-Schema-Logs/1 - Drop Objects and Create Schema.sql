USE [DShield]
GO

-- =============================================
-- Logs Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================
-- =============================================
-- Logs - Drop Views
-- =============================================
IF OBJECT_ID('[Logs].[LastFirewallLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastFirewallLogDate]
GO
IF OBJECT_ID('[Logs].[LastHoneypotLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastHoneypotLogDate]
GO
IF OBJECT_ID('[Logs].[LastRawSSHLogDate]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LastRawSSHLogDate]
GO

IF OBJECT_ID('[Logs].[FirewallObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[FirewallObservations]
GO
IF OBJECT_ID('[Logs].[HoneypotObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[HoneypotObservations]
GO
IF OBJECT_ID('[Logs].[RawSSHObservations]', 'V') IS NOT NULL
    DROP VIEW [Logs].[RawSSHObservations]
GO

IF OBJECT_ID('[Logs].[UrlsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[UrlsObserved]
GO
IF OBJECT_ID('[Logs].[IpAddressesObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[IpAddressesObserved]
GO
IF OBJECT_ID('[Logs].[UserAgentsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[UserAgentsObserved]
GO
IF OBJECT_ID('[Logs].[LoginsObserved]', 'V') IS NOT NULL
    DROP VIEW [Logs].[LoginsObserved]
GO
-- =============================================
-- Logs - Drop Procedures
-- =============================================
IF OBJECT_ID('[Logs].[InsertFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertFirewallLogs]
GO
IF OBJECT_ID('[Logs].[GetFirewallLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetFirewallLogs]
GO
IF OBJECT_ID('[Logs].[InsertHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertHoneypotLogs]
GO
IF OBJECT_ID('[Logs].[GetHoneypotLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetHoneypotLogs]
GO
IF OBJECT_ID('[Logs].[InsertRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[InsertRawSSHLogs]
GO
IF OBJECT_ID('[Logs].[GetRawSSHLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Logs].[GetRawSSHLogs]
GO
-- =============================================
-- Logs - Drop Tables
-- =============================================
IF OBJECT_ID('[Logs].[Firewall]', 'U') IS NOT NULL
  DROP TABLE [Logs].[Firewall]
GO

IF OBJECT_ID('[Logs].[Honeypot]', 'U') IS NOT NULL
  DROP TABLE [Logs].[Honeypot]
GO

IF OBJECT_ID('[Logs].[RawSSH]', 'U') IS NOT NULL
  DROP TABLE [Logs].[RawSSH]
GO

-- =============================================
-- Logs - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Logs')
    DROP SCHEMA [Logs]
GO

CREATE SCHEMA [Logs]
GO
