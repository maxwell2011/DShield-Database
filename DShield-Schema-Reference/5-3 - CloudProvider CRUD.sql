USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert Cloud Provider
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cloud Provider (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertCloudProvider] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Cloud Provider
    SELECT @ID = [Id] 
    FROM [Reference].[CloudProviders] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[CloudProviders] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO