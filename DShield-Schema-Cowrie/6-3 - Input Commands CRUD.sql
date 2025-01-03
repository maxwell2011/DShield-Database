USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - InputCommands
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Command Input Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertInputCommands] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[EventIds] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[InputCommands] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO