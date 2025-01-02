USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a KeyTypes (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertKeyTypes] @Value NVARCHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[KeyTypes] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[KeyTypes] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO