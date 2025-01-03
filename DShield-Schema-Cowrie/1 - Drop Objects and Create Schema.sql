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

IF OBJECT_ID('[Cowrie].[SessionFileDownloads]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[SessionFileDownloads]
GO
IF OBJECT_ID('[Cowrie].[SessionFileUploads]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[SessionFileUploads]
GO
IF OBJECT_ID('[Cowrie].[CommandFailedLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandFailedLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandSuccessLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandSuccessLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandInputLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandInputLogs]
GO
IF OBJECT_ID('[Cowrie].[CommandLogs]', 'V') IS NOT NULL
    DROP VIEW [Cowrie].[CommandLogs]
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
-- Cowrie - Drop Procedures - Upsert
-- =============================================

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionConnect]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionConnect]
GO

IF OBJECT_ID('[Cowrie].[UpsertSensors]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertSensors]
GO
IF OBJECT_ID('[Cowrie].[UpsertMessages]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertMessages]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogsDirectTcpIpData]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpData]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogsDirectTcpIpRequest]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsDirectTcpIpRequest]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileDownloadFailures]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloadFailures]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileDownloads]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileDownloads]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionFileUploads]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionFileUploads]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandFailed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandFailed]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandSuccess]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandSuccess]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsCommandInput]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsCommandInput]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsLoginSuccess]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsLoginSuccess]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsLoginFailed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsLoginFailed]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientSize]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientSize]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientFingerprint]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientFingerprint]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientVar]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientVar]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientKeyExchange]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientKeyExchange]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsClientVersion]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsClientVersion]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionParams]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionClosed]
GO

IF OBJECT_ID('[Cowrie].[UpsertLogsSessionClosed]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogsSessionClosed]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogs]
GO
IF OBJECT_ID('[Cowrie].[UpsertDirectTcpIpDataValues]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertDirectTcpIpDataValues]
GO

IF OBJECT_ID('[Cowrie].[UpsertInputCommands]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertInputCommands]
GO
IF OBJECT_ID('[Cowrie].[UpsertLogs]', 'P') IS NOT NULL
    DROP PROCEDURE [Cowrie].[UpsertLogs]
GO
-- =============================================
-- Cowrie - Drop Procedures - CRUD
-- =============================================



-- =============================================
-- Cowrie - Drop Tables
-- =============================================
IF OBJECT_ID('[Cowrie].[DirectTcpIpData]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpData]
GO

IF OBJECT_ID('[Cowrie].[DirectTcpIpRequest]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpRequest]
GO

IF OBJECT_ID('[Cowrie].[SessionFileDownloadFailures]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionFileDownloadFailures]
GO

IF OBJECT_ID('[Cowrie].[SessionFiles]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionFiles]
GO

IF OBJECT_ID('[Cowrie].[Command]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Command]
GO

IF OBJECT_ID('[Cowrie].[Login]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Login]
GO

IF OBJECT_ID('[Cowrie].[ClientSize]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientSize]
GO

IF OBJECT_ID('[Cowrie].[ClientFingerprint]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientFingerprint]
GO

IF OBJECT_ID('[Cowrie].[ClientVar]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientVar]
GO

IF OBJECT_ID('[Cowrie].[ClientKeyExchange]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientKeyExchange]
GO

IF OBJECT_ID('[Cowrie].[ClientVersion]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[ClientVersion]
GO

IF OBJECT_ID('[Cowrie].[SessionParams]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionParams]
GO

IF OBJECT_ID('[Cowrie].[SessionClosed]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionClosed]
GO

IF OBJECT_ID('[Cowrie].[SessionConnect]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[SessionConnect]
GO

IF OBJECT_ID('[Cowrie].[Logs]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Logs]
GO

IF OBJECT_ID('[Cowrie].[DirectTcpIpDataValues]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[DirectTcpIpDataValues]
GO

IF OBJECT_ID('[Cowrie].[InputCommands]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[InputCommands]
GO

IF OBJECT_ID('[Cowrie].[Sensors]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Sensors]
GO

IF OBJECT_ID('[Cowrie].[Messages]', 'U') IS NOT NULL
  DROP TABLE [Cowrie].[Messages]
GO

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
