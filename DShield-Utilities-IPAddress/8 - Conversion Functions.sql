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