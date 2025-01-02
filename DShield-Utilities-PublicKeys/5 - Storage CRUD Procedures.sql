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
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertBinary] TO [PublicKeyReader]
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
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyWriter]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyExecutor]
GO
-- =============================================
-- Title:       PublicKey - PublicKeys
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[PublicKey].[UpsertText] TO [PublicKeyReader]
GO