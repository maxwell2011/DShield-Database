USE [DShield]
GO

-- =============================================
-- Title:       Fingerprint - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Scalar Function
-- Description:
--	Convert a fingerprint of form 
--	'01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--	to binary
-- =============================================
CREATE FUNCTION [Fingerprint].[ToBinary]
(
    @Fingerprint VARCHAR(255)
)
RETURNS VARBINARY(16)
AS
BEGIN
    DECLARE @Clean VARCHAR(32);
    -- Remove colons and ensure lowercase
    SET @Clean = LOWER(REPLACE(@Fingerprint, ':', ''));
    
    -- Convert hex string to binary
    RETURN CAST('' AS XML).value('xs:hexBinary(sql:variable("@Clean"))', 'VARBINARY(16)');
END;
GO

-- =============================================
-- Title:		Fingerprint - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Fingerprint
-- Type:		Scalar Function
-- Description:
--	Convert a binary representation of a 
--  fingerprint back to form 
--  '01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--  from binary
-- =============================================
CREATE FUNCTION [Fingerprint].[FromBinary]
(
    @Binary VARBINARY(16)
)
RETURNS VARCHAR(47)
AS
BEGIN
    DECLARE @HexString VARCHAR(32);
    -- Convert binary to hex string
    SET @HexString = LOWER(
        CAST('' AS XML).value('xs:hexBinary(sql:variable("@Binary"))', 'VARCHAR(32)')
    );
    
    -- Insert colons every 2 characters
    RETURN STUFF(
        (
            SELECT ':' + SUBSTRING(@HexString, Number, 2)
            FROM (
                SELECT ROW_NUMBER() OVER (ORDER BY object_id)
                FROM sys.objects
            ) AS Numbers(Number)
            WHERE Number % 2 = 1 
            AND Number <= LEN(@HexString)
            FOR XML PATH('')
        ), 1, 1, ''
    );
END;
GO
