USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - Upsert Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Stored Procedure
-- Description:
--  Upsert a Fingerprint (Single)
-- =============================================
CREATE PROCEDURE [Fingerprint].[UpsertBinary] @Value VARBINARY(16),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Fingerprint].[Storage] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Fingerprint].[Storage] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO


-- =============================================
-- Title:       Fingerprint - Upsert Fingerprint
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Stored Procedure
-- Description:
--  Upsert a Fingerprint (Single)
-- =============================================
CREATE PROCEDURE [Fingerprint].[UpsertText] @Value CHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @FingerprintBin VARBINARY(16) = [Fingerprint].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Fingerprint].[Storage] 
    WHERE [Value] = @FingerprintBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Fingerprint].[Storage] ([Value]) VALUES (@FingerprintBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
