USE [DShield]
GO
-- =============================================
-- Title:       Rolodex - Upsert UserAgent
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a User Agent (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUserAgent] @Value NVARCHAR(1023),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing User Agent
    SELECT @ID = [Id] 
    FROM [Rolodex].[UserAgents] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[UserAgents] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - UserAgents
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUserAgent] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Upsert Username
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Username (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUsername] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Usernames] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Usernames] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Usernames
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUsername] TO [RolodexReader]
GO


-- =============================================
-- Title:       Rolodex - Upsert Password
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Password (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertPassword] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Passwords] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Passwords] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Passwords
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertPassword] TO [RolodexReader]
GO
-- =============================================
-- Title:       Rolodex - Upsert Url
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Url (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertUrl] @Value NVARCHAR(2048),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Urls] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Urls] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Urls
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertUrl] TO [RolodexReader]
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
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - SSHClientVersions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertSSHClientVersion] TO [RolodexReader]
GO

-- =============================================
-- Title:       Rolodex - Upsert Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Stored Procedure
-- Description:
--  Upsert a Hasshs (Single)
-- =============================================
CREATE PROCEDURE [Rolodex].[UpsertHassh] @Value CHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Rolodex].[Hassh] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Rolodex].[Hassh] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexManager];
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexWriter]
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexExecutor]
GO
-- =============================================
-- Title:       Rolodex - Hasshs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Rolodex
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Rolodex].[UpsertHassh] TO [RolodexReader]
GO


