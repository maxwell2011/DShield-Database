USE [DShield]
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