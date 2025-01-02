USE [DShield]
GO
-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Table
-- Description:
--  Store Quick Lookup of RFC Info (All)
-- =============================================
CREATE TABLE [Reference].[RFC] (
    [Number] INT PRIMARY KEY,
    [Name] VARCHAR(127) NOT NULL DEFAULT '',
    [Description] VARCHAR(255) NOT NULL DEFAULT '',
    CONSTRAINT UQ_Reference_RFC_Number_Name UNIQUE ([Number], [Name])
);

GO



