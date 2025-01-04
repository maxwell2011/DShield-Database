USE [DShield]
GO

-- =============================================
-- Utility - Drop Views
-- =============================================
IF OBJECT_ID('[Utility].[OrphanedUsers]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OrphanedUsers]
GO
IF OBJECT_ID('[Utility].[OutOfMemoryErrors701]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OutOfMemoryErrors701]
GO
IF OBJECT_ID('[Utility].[VirtualMemoryUsage]', 'V') IS NOT NULL
    DROP VIEW [Utility].[VirtualMemoryUsage]
GO
IF OBJECT_ID('[Utility].[ExistingSessions]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ExistingSessions]
GO
IF OBJECT_ID('[Utility].[ProgramIOActivity]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ProgramIOActivity]
GO
IF OBJECT_ID('[Utility].[SystemMemoryConsumers]', 'V') IS NOT NULL
    DROP VIEW [Utility].[SystemMemoryConsumers]
GO
IF OBJECT_ID('[Utility].[SchemaManagerEntriesCount]', 'V') IS NOT NULL
    DROP VIEW [Utility].[SchemaManagerEntriesCount]
GO
IF OBJECT_ID('[Utility].[HighCPUQueries]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueries]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesHistorical]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesHistorical]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesMissingIndexes]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesMissingIndexes]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesFrequentExecution]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesFrequentExecution]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesSuggestIndexFixes]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesSuggestIndexFixes]
GO
IF OBJECT_ID('[Utility].[ProfilerTraceSummary]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ProfilerTraceSummary]
GO
IF OBJECT_ID('[Utility].[TraceEventDetails]', 'V') IS NOT NULL
    DROP VIEW [Utility].[TraceEventDetails]
GO
IF OBJECT_ID('[Utility].[XEventSessionDetails]', 'V') IS NOT NULL
    DROP VIEW [Utility].[XEventSessionDetails]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesDebug]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesDebug]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPatched]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPatched]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPreRelease]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPreRelease]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPrivateBuilds]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPrivateBuilds]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesSpecialBuilds]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesSpecialBuilds]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesThirdParty]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesThirdParty]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesNonEnglish]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesNonEnglish]
GO
-- =============================================
-- Utility Schema
--  Database management utilities
-- =============================================
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Utility')
    DROP SCHEMA [Utility]
GO

CREATE SCHEMA [Utility]
GO
