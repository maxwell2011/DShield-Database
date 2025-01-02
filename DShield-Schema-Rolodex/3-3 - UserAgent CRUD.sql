USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert UserAgent
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a User Agent (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUserAgent] @Value NVARCHAR(1023),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing User Agent
    SELECT @ID = [Id] 
    FROM [Rolodex].[UserAgents] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[UserAgents] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO