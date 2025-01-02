USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Sensors
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Sensors Name Value (Single) 
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertSensors] @Value NVARCHAR(128),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[Sensors] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[Sensors] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO