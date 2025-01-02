USE [DShield]
GO

-- =============================================
-- Title:       Rolodex - Upsert SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a SSHClientVersions (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertSSHClientVersion] @Value NVARCHAR(1023),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[SSHClientVersions] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[SSHClientVersions] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO