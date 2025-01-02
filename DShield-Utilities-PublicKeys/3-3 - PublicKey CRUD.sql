USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - Upsert PublicKey
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Stored Procedure
-- Description:
--  Upsert a PublicKey (Single)
-- =============================================
CREATE PROCEDURE [PublicKey].[UpsertBinary] @Value VARBINARY(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [PublicKey].[Storage] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [PublicKey].[Storage] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO



-- =============================================
-- Title:       PublicKey - Upsert PublicKey
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Stored Procedure
-- Description:
--  Upsert a Logged Public Key value (Single)
-- =============================================
CREATE PROCEDURE [PublicKey].[UpsertText] @Value VARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @PublicKeyBin VARBINARY(MAX) = [PublicKey].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [PublicKey].[Storage] 
    WHERE [Value] = @PublicKeyBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [PublicKey].[Storage] ([Value]) VALUES (@PublicKeyBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
