USE [DShield]
GO

-- =============================================
-- Title:       Drop Synonym
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Drop a Synonym if it exists
-- =============================================
CREATE PROCEDURE [IPAddress].[DropSynonymIfExists] 
    @TargetSchema NVARCHAR(128),
    @TargetName NVARCHAR(128)
AS
BEGIN 
    -- Check if the synonym exists and drop it if it does
    IF EXISTS (
        SELECT 1 
        FROM sys.synonyms 
        WHERE name = @TargetName AND 
        SCHEMA_NAME(schema_id) = @TargetSchema
    )
    BEGIN
        PRINT 'Dropping existing synonym... ( ' +QUOTENAME(@TargetSchema)+'.'+QUOTENAME(@TargetName) + ' )';
        DECLARE @SQLDrop NVARCHAR(MAX) = 'DROP SYNONYM '+QUOTENAME(@TargetSchema)+'.'+QUOTENAME(@TargetName)+';';
        EXEC sp_sqlexec @SQLDrop;
        PRINT 'Synonym '+QUOTENAME(@TargetSchema)+'.'+QUOTENAME(@TargetName)+' removed.';
    END
END;
GO

-- =============================================
-- Title:       Create Synonym
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Drop a Synonym if it exists
-- =============================================
CREATE PROCEDURE [IPAddress].[NewSynonymIfNotExists] 
    @TargetSchema NVARCHAR(128),
    @TargetName NVARCHAR(128),
    @ObjectName NVARCHAR(128)
AS
BEGIN 
    IF OBJECT_ID('DShield.'+QUOTENAME(@TargetSchema)+'.'+QUOTENAME(@ObjectName)) IS NOT NULL
        BEGIN
            DECLARE @SQLCreate NVARCHAR(MAX) = 'CREATE SYNONYM '+QUOTENAME(@TargetSchema)+'.'+QUOTENAME(@TargetName) + ' FOR [DShield].[IPAddress].'+QUOTENAME(@ObjectName) + ';'
            EXEC sp_sqlexec @SQLCreate;
            PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.' + QUOTENAME(@TargetName) +' created.';
        END
    ELSE
        BEGIN
            PRINT 'Base object does not exist. ([DShield].[IPAddress].'+QUOTENAME(@ObjectName)+')';
        END
END;
GO

-- =============================================
-- Title:       Apply Permissions To Synonym
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Apply Role Permissions to Synonym
-- =============================================
CREATE PROCEDURE [IPAddress].[ApplyRolePermissionsToSynonym] 
    @TargetSchema NVARCHAR(128),
    @TargetName NVARCHAR(128),
    @ObjectName NVARCHAR(128)
AS
BEGIN 
    -- Check if the synonym exists and apply appropriate permissions if it does
    IF EXISTS (
        SELECT 1 
        FROM sys.synonyms 
        WHERE name = @TargetName AND 
        SCHEMA_NAME(schema_id) = @TargetSchema
    )
        BEGIN
            DECLARE @SQLTablePermissions NVARCHAR(MAX) = '
            GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON '+QUOTENAME(@TargetSchema)+'.' + QUOTENAME(@TargetName) +' TO ['+@TargetSchema+'Manager];
            GO
            GRANT DELETE, INSERT, REFERENCES, SELECT ON '+QUOTENAME(@TargetSchema)+'.' + QUOTENAME(@TargetName) +' TO ['+@TargetSchema+'Writer];
            GO
            GRANT REFERENCES, SELECT ON '+QUOTENAME(@TargetSchema)+'.' + QUOTENAME(@TargetName) +' TO ['+@TargetSchema+'Executor];
            GO
            GRANT REFERENCES, SELECT ON '+QUOTENAME(@TargetSchema)+'.' + QUOTENAME(@TargetName) +' TO ['+@TargetSchema+'Reader];
            GO';
            EXEC sp_sqlexec @SQLTablePermissions;
            PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.' + QUOTENAME(@TargetName) +' recreated and permissions applied successfully.';
        END
    -- Otherwise, alert the user
    ELSE
        BEGIN
            PRINT 'Synonym '+QUOTENAME(@TargetSchema)+'.' + QUOTENAME(@TargetName) +' possibly recreated but permissions not applied successfully.';
        END
END;
GO

-- =============================================
-- Title:       Create Synonym - Addresses
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Create a Synonym for the IPAddress.Addresses
--	table for invisible (to the user) passthrough
-- =============================================
CREATE PROCEDURE [IPAddress].[Addresses_NewSynonym] 
    @TargetSchema NVARCHAR(128)
AS
BEGIN 
    -- Basic Addresses Table Synonyms
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IPAddresses';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IPAddresses', 
        @ObjectName= 'Addresses';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='IPAddresses', 
        @ObjectName= 'Addresses';

    -- Basic IPv4 Addresses View(s) Synonyms
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IPv4AsBinary';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv4AsBinary', 
        @ObjectName= 'IPv4AsBinary';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv4AsBinary', 
        @ObjectName= 'IPv4AsBinary';

    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IPv4AsString';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv4AsString', 
        @ObjectName= 'IPv4AsString';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv4AsString', 
        @ObjectName= 'IPv4AsString';

    -- Basic IPv6 Addresses View(s) Synonyms
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IPv6AsBinary';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv6AsBinary', 
        @ObjectName= 'IPv6AsBinary';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv6AsBinary', 
        @ObjectName= 'IPv6AsBinary';

    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IPv6AsString';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv6AsString', 
        @ObjectName= 'IPv6AsString';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='IPv6AsString', 
        @ObjectName= 'IPv6AsString';

    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'InsertIP';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='InsertIP', 
        @ObjectName= 'InsertIP';
    DECLARE @SQL_InsertIP_Permissions NVARCHAR(MAX) = '
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[InsertIP] TO ['+@TargetSchema+'Manager];
    GO
    DENY EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[InsertIP] TO ['+@TargetSchema+'Executor];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[InsertIP] TO ['+@TargetSchema+'Writer];
    GO
    DENY EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[InsertIP] TO ['+@TargetSchema+'Reader];
    GO
    ';
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'UpsertIP';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='UpsertIP', 
        @ObjectName= 'UpsertIP';
    EXEC sp_sqlexec @SQL_InsertIP_Permissions;
    PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.[UpsertIP] recreated and permissions applied successfully.';
    DECLARE @SQL_UpsertIP_Permissions NVARCHAR(MAX) = '
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[UpsertIP] TO ['+@TargetSchema+'Manager];
    GO
    DENY EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[UpsertIP] TO ['+@TargetSchema+'Executor];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[UpsertIP] TO ['+@TargetSchema+'Writer];
    GO
    DENY EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[UpsertIP] TO ['+@TargetSchema+'Reader];
    GO
    ';
    EXEC sp_sqlexec @SQL_UpsertIP_Permissions;
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'GetIPs';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='GetIPs', 
        @ObjectName= 'GetIPs';
    PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.[GetIPs] recreated and permissions applied successfully.';
    DECLARE @SQL_GetIPs_Permissions NVARCHAR(MAX) = '
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[GetIPs] TO ['+@TargetSchema+'Manager];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[GetIPs] TO ['+@TargetSchema+'Executor];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[GetIPs] TO ['+@TargetSchema+'Writer];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[GetIPs] TO ['+@TargetSchema+'Reader];
    GO
    ';
    EXEC sp_sqlexec @SQL_GetIPs_Permissions;
    PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.[GetIPs] recreated and permissions applied successfully.';
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'IsIpInSubnet';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='IsIpInSubnet', 
        @ObjectName= 'IsIpInSubnet';
    PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] recreated and permissions applied successfully.';
    DECLARE @SQL_IsIpInSubnet_Permissions NVARCHAR(MAX) = '
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] TO ['+@TargetSchema+'Manager];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] TO ['+@TargetSchema+'Executor];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] TO ['+@TargetSchema+'Writer];
    GO
    GRANT EXECUTE ON OBJECT::' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] TO ['+@TargetSchema+'Reader];
    GO
    ';
    EXEC sp_sqlexec @SQL_IsIpInSubnet_Permissions;
    PRINT 'Synonym ' + QUOTENAME(@TargetSchema) + '.[IsIpInSubnet] recreated and permissions applied successfully.';
END;
GO

-- =============================================
-- Title:       Create Synonym - Bogons
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Create a Synonym for the IPAddress.Bogons
--	table for invisible (to the user) passthrough
-- =============================================
CREATE PROCEDURE [IPAddress].[Bogons_NewSynonym] 
    @TargetSchema NVARCHAR(128)
AS
BEGIN 
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'Bogons';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='Bogons', 
        @ObjectName= 'Bogons';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='Bogons', 
        @ObjectName= 'Bogons';
    
END;
GO

-- =============================================
-- Title:       Create Synonym - Subnets
-- Author:		Curtis Dibble
-- Date:		12/31/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Create a Synonym for the IPAddress.Subnets
--	table for invisible (to the user) passthrough
-- =============================================
CREATE PROCEDURE [IPAddress].[Subnets_NewSynonym] 
    @TargetSchema NVARCHAR(128)
AS
BEGIN 
    EXEC [IPAddress].[DropSynonymIfExists] 
        @TargetSchema = @TargetSchema, 
        @TargetName= 'Subnets';
    EXEC [IPAddress].[NewSynonymIfNotExists]
        @TargetSchema = @TargetSchema, 
        @TargetName='Subnets', 
        @ObjectName= 'Subnets';
    EXEC [IPAddress].[ApplyRolePermissionsToSynonym] 
        @TargetSchema = @TargetSchema, 
        @TargetName='Subnets', 
        @ObjectName= 'Subnets';
    
END;
GO