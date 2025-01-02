USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Hasshs (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertHassh] @Value CHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Hassh] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Hassh] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO