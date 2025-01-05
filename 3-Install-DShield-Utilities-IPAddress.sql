USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Schema
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Manage IP Address Space as a module
-- =============================================

-- =============================================
-- IPAddress - Drop Views
-- =============================================
IF OBJECT_ID('[IPAddress].[IPv4AsBinary]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv4AsBinary]
GO
IF OBJECT_ID('[IPAddress].[IPv4AsString]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv4AsString]
GO
IF OBJECT_ID('[IPAddress].[IPv6AsBinary]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv6AsBinary]
GO
IF OBJECT_ID('[IPAddress].[IPv6AsString]', 'V') IS NOT NULL
    DROP VIEW [IPAddress].[IPv6AsString]
GO

-- =============================================
-- IPAddress - Drop Procedures
-- =============================================
IF OBJECT_ID('[IPAddress].[GetIPs]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[GetIPs]
GO
IF OBJECT_ID('[IPAddress].[InsertIP]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[InsertIP]
GO
IF OBJECT_ID('[IPAddress].[UpsertIP]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[UpsertIP]
GO
IF OBJECT_ID('[IPAddress].[Addresses_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Addresses_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[Bogons_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Bogons_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[Subnets_NewSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[Subnets_NewSynonym]
GO
IF OBJECT_ID('[IPAddress].[DropSynonymIfExists]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[DropSynonymIfExists]
GO
IF OBJECT_ID('[IPAddress].[NewSynonymIfNotExists]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[NewSynonymIfNotExists]
GO
IF OBJECT_ID('[IPAddress].[ApplyRolePermissionsToSynonym]', 'P') IS NOT NULL
    DROP PROCEDURE [IPAddress].[ApplyRolePermissionsToSynonym]
GO

-- =============================================
-- IPAddress - Drop Functions
-- =============================================
IF OBJECT_ID('[IPAddress].[FromBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[FromBinary]
GO
IF OBJECT_ID('[IPAddress].[ToBinary]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[ToBinary]
GO
IF OBJECT_ID('[IPAddress].[ToBigInt]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[ToBigInt]
GO
IF OBJECT_ID('[IPAddress].[IsIpInSubnet]', 'FN') IS NOT NULL
    DROP FUNCTION [IPAddress].[IsIpInSubnet]
GO

-- =============================================
-- IPAddress - Drop Tables
-- =============================================
IF OBJECT_ID('[IPAddress].[Subnets]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Subnets]
GO

IF OBJECT_ID('[IPAddress].[Bogons]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Bogons]
GO

IF OBJECT_ID('[IPAddress].[Addresses]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Addresses]
GO

IF OBJECT_ID('[IPAddress].[Storage]', 'U') IS NOT NULL
    DROP TABLE [IPAddress].[Storage]
GO
-- =============================================
-- IPAddress - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'IPAddress')
	DROP SCHEMA [IPAddress];
GO
CREATE SCHEMA [IPAddress]
GO
USE [DShield]
GO

-- =============================================
-- Title:       IPAddress Role Drop - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressManager', 'CoreManager'
	EXEC sp_droprolemember 'IPAddressManager', 'UtilityManager'
	EXEC sp_droprole [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress Role Create - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressManager' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressManager] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressManager', 'CoreManager'
EXEC sp_addrolemember 'IPAddressManager', 'UtilityManager'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'IPAddressExecutor', 'UtilityExecutor'
	EXEC sp_droprole [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress Role Create - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'IPAddressExecutor', 'UtilityExecutor'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressWriter', 'CoreWriter'
	EXEC sp_droprolemember 'IPAddressWriter', 'UtilityWriter'
	EXEC sp_droprole [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress Role Create - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressWriter' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressWriter', 'CoreWriter'
EXEC sp_addrolemember 'IPAddressWriter', 'UtilityWriter'
GO
-- =============================================
-- Title:       IPAddress Role Drop - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'IPAddressReader', 'CoreReader'
	EXEC sp_droprolemember 'IPAddressReader', 'UtilityReader'
	EXEC sp_droprole [IPAddressReader];
GO
-- =============================================
-- Title:       IPAddress Role Create - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Schema
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'IPAddressReader' AND 
		type = 'R'
		)
	CREATE ROLE [IPAddressReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'IPAddressReader', 'CoreReader'
EXEC sp_addrolemember 'IPAddressReader', 'UtilityReader'
GO

USE [DShield]
GO
-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store unique IP addresses as 
--  Binary (All) (VARBINARY(16))
--  Indexed on Value to prevent duplicates
-- =============================================


CREATE TABLE [IPAddress].[Storage] (
    [Id]			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Value]         VARBINARY(16) NOT NULL
);
GO
-- Index on IP Address to prevent duplicates
CREATE INDEX IX_IPAddress_Storage_Address ON [IPAddress].[Storage]([Value]);
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique IP Addresses, stored as Binary',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Storage',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Storage',
    @level2type = N'INDEX',
    @level2name = N'IX_IPAddress_Storage_Address'

GO


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
    FROM [IPAddress].[Storage];
END;
GO
USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv4 addresses from the 
--	Address table as VARBINARY(16)
-- =============================================

CREATE VIEW [IPAddress].[IPv4AsBinary]
	AS SELECT 
	[Id],
	[Value]			AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 4;
GO

-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv4 addresses from the 
--	Address table as VARCHAR(45)
-- =============================================

CREATE VIEW [IPAddress].[IPv4AsString]
	AS SELECT 
	[Id],
	[IPAddress].[FromBinary]([Value]) AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 4;
GO

-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv6 addresses from the 
--	Address table as VARBINARY(16)
-- =============================================

CREATE VIEW [IPAddress].[IPv6AsBinary]
	AS SELECT 
	[Id],
	[Value] AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 16;
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		View
-- Description:
--	View to retrieve IPv6 addresses from the 
--	Address table as VARCHAR(45)
-- =============================================

CREATE VIEW [IPAddress].[IPv6AsString]
	AS SELECT 
	[Id],
	[IPAddress].[FromBinary]([Value]) AS [Address]
	FROM [IPAddress].[Storage]
	WHERE LEN([Value]) = 16;
GO
USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - IP To String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Scalar Function
-- Description:
--	Convert a (Single) VARBINARY(16) IPv4 or 
--	IPv6 Address to a VARCHAR(45)
--	Representation for display or transport
-- =============================================

CREATE FUNCTION [IPAddress].[FromBinary] (@IPBinary VARBINARY(16)) RETURNS VARCHAR(45) AS
BEGIN
	DECLARE @Result VARCHAR(45) = '0.0.0.0';
	IF @IPBinary IS NULL RETURN NULL;
    ELSE IF DATALENGTH( @IPBinary ) = 4
        RETURN 
            CONVERT( VARCHAR(3), CONVERT(TINYINT, SUBSTRING( @IPBinary, 1, 1 ))) + '.' +
            CONVERT( VARCHAR(3), CONVERT(TINYINT, SUBSTRING( @IPBinary, 2, 1 ))) + '.' +
            CONVERT( VARCHAR(3), CONVERT(TINYINT, SUBSTRING( @IPBinary, 3, 1 ))) + '.' +
            CONVERT( VARCHAR(3), CONVERT(TINYINT, SUBSTRING( @IPBinary, 4, 1 )));
    ELSE IF DATALENGTH( @IPBinary ) = 16
        RETURN 
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary,  1, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary,  3, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary,  5, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary,  7, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary,  9, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary, 11, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary, 13, 2 ), 2 ) + ':' +
            CONVERT( VARCHAR(4), SUBSTRING( @IPBinary, 15, 2 ), 2 );
	RETURN @Result
END;
GO

-- =============================================
-- Title:		IPAddress - String To IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Scalar Function
-- Description:
--	Convert a (Single) VARCHAR(45) IPv4 or 
--	IPv6 Address to a VARBINARY(16) 
--	Representation for storage or calculations
-- =============================================

CREATE FUNCTION [IPAddress].[ToBinary] (@IPString VARCHAR(45)) RETURNS VARBINARY(16) AS
BEGIN
    IF @IPString IS NULL RETURN NULL;
	DECLARE 
		@Result					VARBINARY(16), 
		@Token					VARCHAR(4),
		@VBytes					VARBINARY(16) = 0x, 
		@VBZone					VARBINARY(2),
		@TempIPAddress			VARCHAR( 40 ),
		@ColumnIndex			TINYINT,
		@Delimiter				CHAR(1) = '.',
		@PreviousColumnIndex	TINYINT = 0,
		@Parts					TINYINT = 0, 
		@Limit					TINYINT = 4;
	-- Get position if IPV4 delimiter
	SET @ColumnIndex = CHARINDEX( @Delimiter, @IPString );
	-- If not IPV4, then assume IPV6
	IF @ColumnIndex = 0
	BEGIN
		SELECT @Delimiter = ':', @Limit = 8, @ColumnIndex = CHARINDEX( @Delimiter, @IPString );
		-- Get number of parts (delimiters)
		WHILE @ColumnIndex > 0
			SELECT 
				@Parts += 1, 
				@ColumnIndex = CHARINDEX( @Delimiter, @IPString, @ColumnIndex + 1 );
		SET @ColumnIndex = CHARINDEX( @Delimiter, @IPString );
		IF @ColumnIndex = 0 RETURN NULL;
	END
	-- Add trailing delimiter (need new variable of larger size)
	SET @TempIPAddress = @IPString + @Delimiter;
	WHILE @ColumnIndex > 0
	BEGIN
		SET @Token = SUBSTRING( @TempIPAddress, @PreviousColumnIndex + 1, @ColumnIndex - @PreviousColumnIndex - 1 );
		IF @Delimiter = ':'
			BEGIN
				SELECT 
					@VBZone = CONVERT( VARBINARY(2), 
					RIGHT( '0000' + @Token, 4 ), 2 ), 
					@VBytes += @VBZone;
				-- Handles consecutive sections of zeros representation rule (i.e. ::)(https://en.wikipedia.org/wiki/IPv6#Address_representation)
				IF @Token = ''
					WHILE @Parts + 1 < @Limit
						SELECT 
							@VBytes += @VBZone, 
							@Parts += 1;
			END
		ELSE
		BEGIN
			SELECT 
				@VBZone = CONVERT( VARBINARY(1), CONVERT( TINYINT, @Token )), 
				@VBytes += @VBZone
		END
		SELECT 
			@PreviousColumnIndex = @ColumnIndex, 
			@ColumnIndex = CHARINDEX( @Delimiter, @TempIPAddress, @ColumnIndex + 1 ) 
	END
	SET @Result =
		CASE @Delimiter WHEN ':' THEN @VBytes
        ELSE /*0x000000000000000000000000 +*/ @VBytes -- Return IPV4 addresses as 4 byte binary (uncomment leading 0s section to force 16 byte binary)
    END 
RETURN @Result
END;
GO

-- =============================================
-- Title:       IPAddress - String To Big Integer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Function
-- Description:
--	Table to store Bogon IP addresses,
--  aka: loopback or non-public ranges
-- Source:
--  https://stackoverflow.com/questions/32117763/subnet-or-cidr-ip-control-at-t-sql
-- Warning:
--  Will cause data loss when used with IPv6
-- =============================================

CREATE FUNCTION [IPAddress].[ToBigInt]
(
    @IPv4String NVARCHAR(45) -- should be in the form '123.123.123.123'
)
RETURNS BIGINT
AS
BEGIN
    DECLARE @IPBigInt AS BIGINT
    SELECT @IPBigInt =
    (16777216 * (CAST(PARSENAME(@IPv4String, 4) AS BIGINT))) + 
    (65536 * (CAST(PARSENAME(@IPv4String, 3) AS BIGINT))) +
    (256 * (CAST(PARSENAME(@IPv4String, 2) AS BIGINT))) +
    (CAST(PARSENAME(@IPv4String, 1) AS BIGINT))

    RETURN @IPBigInt
END
GO
USE [DShield]
GO

-- =============================================
-- DShield IPAddress Storage Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the IPAddress 
--  Storage table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [IPAddress].[Storage] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store unique IP addresses as 
--  Binary (All) (VARBINARY(16))
--  Indexed on Value to prevent duplicates
-- =============================================


CREATE TABLE [IPAddress].[Addresses] (
    [Id]			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Value]         VARBINARY(16) NOT NULL
);
GO
-- Index on IP Address to prevent duplicates
CREATE INDEX IX_IPAddress_Addresses_Value ON [IPAddress].[Addresses]([Value]);
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique IP Addresses, stored as Binary',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Addresses',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Addresses',
    @level2type = N'INDEX',
    @level2name = N'IX_IPAddress_Addresses_Value'

GO

USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store Subnet addresses and associated
--  Netmask values (in CIDR notation)
-- =============================================
CREATE TABLE [IPAddress].[Subnets] (
    [Id]			INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Value]         VARBINARY(16) NOT NULL,
    [CIDR]          TINYINT NOT NULL CHECK ([CIDR] <= 96),
    [Netmask]       VARBINARY(16) NOT NULL,
    [Bogon]         BIT NOT NULL DEFAULT 0,
    [Comment]       VARCHAR(128) NULL,
    CONSTRAINT UQ_IPAddress_Subnets_Address_CIDR_Netmask UNIQUE CLUSTERED ([Value], [CIDR], [Netmask]),
);
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'First address in the subnet, eg: 192.168.0.0',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'CIDR, eg: the 24 in CIDR slash 24',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'CIDR'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Netmask, eg: 255.255.0.0 for 192.168.0.0/16, in VARBINARY',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Netmask'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Bool flag to tag a subnet as a bogon (nonpublic)',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Bogon'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Comments or observations about subnet, NOT for ownership',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Subnets',
    @level2type = N'COLUMN',
    @level2name = N'Comment'

GO

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
USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - RFC 1918 Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table Update
-- Description:
--	Add essential RFC 1918 Subnets to 
--  repository
-- Source:
--  https://datatracker.ietf.org/doc/html/rfc1918
-- =============================================
INSERT INTO [IPAddress].[Subnets] 
    ([Value], [CIDR], [Netmask], [Bogon], [Comment])
VALUES 
    ([IPAddress].[ToBinary]('192.168.0.0'),16,[IPAddress].[ToBinary]('192.168.255.255'),1,'RFC 1918 - Private'),
    ([IPAddress].[ToBinary]('172.16.0.0'), 12,[IPAddress].[ToBinary]('172.31.255.255'), 1,'RFC 1918 - Business'),
    ([IPAddress].[ToBinary]('10.0.0.0'),   8, [IPAddress].[ToBinary]('10.255.255.255'), 1,'RFC 1918 - Enterprise');
GO

-- =============================================
-- Title:       IPAddress - Bogon Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table Update
-- Description:
--	Add essential IPv4 and IPv6 Bogon Subnets to
--  repository
-- Source:
--  https://ipinfo.io/bogon
-- =============================================
INSERT INTO [IPAddress].[Subnets] 
    ([Value], [CIDR], [Netmask], [Bogon], [Comment])
VALUES 
    ([IPAddress].[ToBinary]('0.0.0.0'),		8,	[IPAddress].[ToBinary]('0.255.255.255'),	1,'"This" network'),
    ([IPAddress].[ToBinary]('100.64.0.0'),	10,	[IPAddress].[ToBinary]('100.127.255.255'),  1,'Carrier-grade NAT'),
    ([IPAddress].[ToBinary]('127.0.0.0'),	8,	[IPAddress].[ToBinary]('127.255.255.255'),  1,'Loopback'),
    ([IPAddress].[ToBinary]('127.0.53.53'),	0,	[IPAddress].[ToBinary]('255.255.255.255'),  1,'Name collision occurrence'),
    ([IPAddress].[ToBinary]('169.254.0.0'),	16,	[IPAddress].[ToBinary]('169.254.255.255'),  1,'Link local'),
    ([IPAddress].[ToBinary]('192.0.0.0'),	24,	[IPAddress].[ToBinary]('192.0.0.255'),      1,'IETF protocol assignments'),
    ([IPAddress].[ToBinary]('192.0.2.0'),	24,	[IPAddress].[ToBinary]('192.0.2.255'),      1,'TEST-NET-1');
GO
USE [DShield]
GO
-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Table to store Bogon IP addresses,
--  aka: loopback or non-public ranges
-- =============================================


CREATE TABLE [IPAddress].[Bogons] (
    [Id]            INT IDENTITY(1,1) PRIMARY KEY,
    [Value]         VARBINARY(16) NOT NULL
);
GO
-- Index on Bogon IP Address to prevent duplicates
CREATE INDEX IX_IPAddress_Bogons ON [IPAddress].[Bogons]([Value]);
GO


EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Unique Bogon IP Addresses, stored as Binary',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Bogons',
    @level2type = N'COLUMN',
    @level2name = N'Value'

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Index on Unique Bogon IP Addresses to prevent duplicates',
    @level0type = N'SCHEMA',
    @level0name = N'IPAddress',
    @level1type = N'TABLE',
    @level1name = N'Bogons',
    @level2type = N'INDEX',
    @level2name = N'IX_IPAddress_Bogons'

GO


USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[Storage] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[Storage] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[Storage] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[Storage] TO [IPAddressReader]
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
-- Title:       IPAddress - IP To String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[FromBinary] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - IP To String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[FromBinary] TO [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress - IP To String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[FromBinary] TO [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress - IP To String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[FromBinary] TO [IPAddressReader];
GO

-- =============================================
-- Title:       IPAddress - String To IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBinary] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - String To IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBinary] TO [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress - String To IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBinary] TO [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress - String To IP
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBinary] TO [IPAddressReader];
GO

-- =============================================
-- Title:       IPAddress - String To Big Integer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBigInt] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - String To Big Integer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBigInt] TO [IPAddressExecutor];
GO
-- =============================================
-- Title:       IPAddress - String To Big Integer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBigInt] TO [IPAddressWriter];
GO
-- =============================================
-- Title:       IPAddress - String To Big Integer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[IPAddress].[ToBigInt] TO [IPAddressReader];
GO

-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[IPv4AsBinary] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[IPv4AsBinary] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[IPv4AsBinary] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - IPv4 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[IPv4AsBinary] TO [IPAddressReader]
GO

-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[IPv4AsString] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[IPv4AsString] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[IPv4AsString] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - IPv4 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[IPv4AsString] TO [IPAddressReader]
GO


-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[IPv6AsBinary] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[IPv6AsBinary] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[IPv6AsBinary] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - IPv6 As Binary
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[IPv6AsBinary] TO [IPAddressReader]
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[IPv6AsString] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[IPv6AsString] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[IPv6AsString] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - IPv6 As String
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[IPv6AsString] TO [IPAddressReader]
GO

USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[Addresses] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[Addresses] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[Addresses] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - Addresses
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[Addresses] TO [IPAddressReader]
GO

USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[Subnets] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[Subnets] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[Subnets] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[Subnets] TO [IPAddressReader]
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
USE [DShield]
GO

-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [IPAddress].[Bogons] TO [IPAddressManager];
GO
-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [IPAddress].[Bogons] TO [IPAddressWriter]
GO
-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[IPAddress].[Bogons] TO [IPAddressExecutor]; 
GO

-- =============================================
-- Title:       IPAddress - Bogons
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [IPAddress].[Bogons] TO [IPAddressReader]
GO

