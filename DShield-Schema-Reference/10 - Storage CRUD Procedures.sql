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
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - Upsert Cloud Provider 
--                        Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert Cloud Provider Subnet Address (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertCloudProviderSubnet]
    @Subnet			VARCHAR(45),
    @NetMask		INT,
    @CloudProvider	NVARCHAR(255),
    @Comment		NVARCHAR(255) NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SubnetID INT, @CloudProviderID INT;
    -- Get or create Provider Subnet
    EXEC [IPAddress].[UpsertIP] @Subnet, @SubnetID OUTPUT;
    -- Get or create Provider
    EXEC [Reference].[UpsertCloudProvider] @CloudProvider, @CloudProviderID OUTPUT;
    -- Insert Provider Subnet Entry
    INSERT INTO [Reference].[CloudProviderSubnets] (
        [SubnetID],
        [NetMask],
        [CloudProviderID],
        [Comment]
    )
    VALUES (
        @SubnetID,
        @NetMask,
        @CloudProviderID,
        @Comment
    );
END;
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - Upsert Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a Architecturess (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertArchitectures] @Value NVARCHAR(64),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[Architectures] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[Architectures] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - Upsert KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a KeyTypes (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertKeyTypes] @Value NVARCHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[KeyTypes] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[KeyTypes] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceReader]
GO
