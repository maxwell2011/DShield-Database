USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Upsert Url
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Url (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUrl] @Value NVARCHAR(2048),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Urls] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Urls] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO