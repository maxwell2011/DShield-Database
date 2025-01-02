USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert Password
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Password (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertPassword] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Passwords] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Passwords] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO