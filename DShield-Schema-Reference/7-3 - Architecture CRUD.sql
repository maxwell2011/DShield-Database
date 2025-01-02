USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a Architecturess (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertArchitectures] @Value NVARCHAR(64),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[Architectures] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[Architectures] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO