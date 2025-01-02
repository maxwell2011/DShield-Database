USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Insert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Insert a (Single) VARCHAR(45) IPv4 or 
--	IPv6 Address to the IP Address table and
--	store it as a VARBINARY(16) item
-- =============================================

CREATE PROCEDURE [IPAddress].[InsertIP] @IPString VARCHAR(45) AS
BEGIN 
    INSERT INTO [IPAddress].[Storage] ([Value]) VALUES ([IPAddress].[ToBinary](@IPString));
    SELECT SCOPE_IDENTITY() AS NewID;
END;
GO

-- =============================================
-- Title:       IPAddress - Insert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[InsertIP] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Insert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[IPAddress].[InsertIP] TO [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress - Insert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[InsertIP] TO [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress - Insert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[IPAddress].[InsertIP] TO [IPAddressReader];
GO

-- =============================================
-- Title:       IPAddress - Upsert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Upsert a (Single) VARCHAR(45) IPv4 or 
--	IPv6 Address to the IP Address table and
--	store it as a VARBINARY(16) item
-- =============================================

CREATE PROCEDURE [IPAddress].[UpsertIP] @Value VARCHAR(45),@ID INT OUTPUT AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @IPBinary VARBINARY(16) = [IPAddress].[ToBinary](@Value);
    -- Try to find existing IP
    SELECT @ID = [Id] 
    FROM [IPAddress].[Storage] 
    WHERE [Value] = @IPBinary;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [IPAddress].[Storage] ([Value]) VALUES (@IPBinary);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO

-- =============================================
-- Title:       IPAddress - Upsert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[UpsertIP] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Upsert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[IPAddress].[UpsertIP] TO [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress - Upsert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[UpsertIP] TO [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress - Upsert IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[IPAddress].[UpsertIP] TO [IPAddressReader];
GO

-- =============================================
-- Title:       IPAddress - Get IPs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Retrieve IP Addresses (All)
-- =============================================
CREATE PROCEDURE [IPAddress].[GetIPs] AS
BEGIN
    SELECT 
        [Id],
        [IPAddress].[FromBinary]([Value]) AS [IPAddress]
    FROM [IPAddress].[IPAddresses];
END;
GO
-- =============================================
-- Title:       IPAddress - Get IPs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[GetIPs] TO [IPAddressManager]
GO
-- =============================================
-- Title:       IPAddress - Get IPs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[GetIPs] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - Get IPs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[GetIPs] TO [IPAddressExecutor]
GO
-- =============================================
-- Title:       IPAddress - Get IPs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[GetIPs] TO [IPAddressReader]
GO

-- =============================================
-- Title:       IPAddress - IP is in Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Stored Procedure
-- Description:
--	Takes a VARBINARY(16) IP address, subnet, 
--		and CIDR mask as inputs
--	Creates a binary mask based on the CIDR value
--	Applies the mask to both the IP and subnet 
--		using bitwise AND
--	Returns 1 if the IP is in the subnet, 0 if not
--	Example: 
--		with a /24 CIDR mask (like 192.168.1.0/24), 
--		it will check if an IP address belongs to 
--		that subnet by comparing the first 24 bits.
-- =============================================
CREATE FUNCTION [IPAddress].[IsIpInSubnet] (
    @IpAddress VARBINARY(16),
    @Subnet VARBINARY(16),
    @CidrMask INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 1;
    DECLARE @ByteIndex INT = 1;
    DECLARE @BytesToCheck INT = @CidrMask / 8;
    
    WHILE @ByteIndex <= @BytesToCheck
    BEGIN
        -- Compare one byte at a time using SUBSTRING
        IF CAST(SUBSTRING(@IpAddress, @ByteIndex, 1) AS INT) & 
           CAST(SUBSTRING(@Subnet, @ByteIndex, 1) AS INT) !=
           CAST(SUBSTRING(@Subnet, @ByteIndex, 1) AS INT)
        BEGIN
            SET @Result = 0;
            BREAK;
        END
        SET @ByteIndex = @ByteIndex + 1;
    END
    
    RETURN @Result;
END;
GO
-- =============================================
-- Title:       IPAddress - IP is in Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[IsIpInSubnet] TO [IPAddressManager]
GO
-- =============================================
-- Title:       IPAddress - IP is in Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[IsIpInSubnet] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - IP is in Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[IsIpInSubnet] TO [IPAddressExecutor]
GO
-- =============================================
-- Title:       IPAddress - IP is in Subnet
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[IsIpInSubnet] TO [IPAddressReader]
GO