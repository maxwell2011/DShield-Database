USE [DShield]
GO
-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Table
-- Description:
--  Store Quick Lookup of IP Protocol Info (All)
-- =============================================
CREATE TABLE [Reference].[Protocols] (
    [Number] INT PRIMARY KEY,
    [Name] VARCHAR(255) NULL,
    [Keyword] VARCHAR(31) NOT NULL
    CONSTRAINT UQ_Reference_Protocols_Number_Keyword UNIQUE ([Number], [Keyword]),
);

GO
