USE [DShield]
GO



-- =============================================
-- Title:       SessionId - Upsert SessionId
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Stored Procedure
-- Description:
--  Upsert a SessionId (Single)
-- =============================================
CREATE PROCEDURE [SessionId].[UpsertBinary] @Value VARBINARY(16),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @SessionBin VARBINARY(16) = [SessionId].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [SessionId].[Storage] 
    WHERE [Value] = @SessionBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [SessionId].[Storage] ([Value]) VALUES (@SessionBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertBinary] TO [SessionIdReader]
GO

-- =============================================
-- Title:       SessionId - Upsert SessionId
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Stored Procedure
-- Description:
--  Upsert a Logged Public Key value (Single)
-- =============================================
CREATE PROCEDURE [SessionId].[UpsertText] @Value VARCHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @SessionIdBin VARBINARY(16) = [SessionId].[ToBinary](@Value)
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [SessionId].[Storage] 
    WHERE [Value] = @SessionIdBin;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [SessionId].[Storage] ([Value]) VALUES (@SessionIdBin);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdManager];
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdWriter]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdExecutor]
GO
-- =============================================
-- Title:       SessionId - SessionIds
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[SessionId].[UpsertText] TO [SessionIdReader]
GO