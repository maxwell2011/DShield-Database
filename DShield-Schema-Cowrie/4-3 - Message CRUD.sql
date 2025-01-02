USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Messages
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Message Value (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertMessages] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[Messages] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Messages] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
