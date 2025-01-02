USE [DShield]
GO

-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Scalar Function
-- Description:
--	Convert a varchar representation of a public 
--  rsa key from varchar to binary
-- =============================================
CREATE FUNCTION [PublicKey].[ToBinary]
(
    @PublicKey VARCHAR(MAX)
)
RETURNS VARBINARY(MAX)
AS
BEGIN
    -- Remove header and whitespace, then convert to binary
    DECLARE @CleanKey VARCHAR(MAX) = REPLACE(
        SUBSTRING(@PublicKey, 
            CHARINDEX(' ', @PublicKey) + 1, 
            LEN(@PublicKey)),
        ' ', '');
    
    RETURN CAST('' AS XML).value('xs:base64Binary(sql:variable("@CleanKey"))', 'VARBINARY(MAX)');
END;
GO


-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[ToBinary] TO [PublicKeyReader];
GO

-- =============================================
-- Title:		PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Scalar Function
-- Description:
--	Convert a binary representation of a 
--  fingerprint back to form 
--  '01:23:45:67:89:ab:cd:ef:01:23:45:67:89:ab:cd:ef' 
--  from binary
-- =============================================
CREATE FUNCTION [PublicKey].[FromBinary]
(
    @Binary VARBINARY(MAX),
    @KeyType VARCHAR(20)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    RETURN @KeyType + ' ' + 
        CAST('' AS XML).value('xs:base64Binary(sql:variable("@Binary"))', 'VARCHAR(MAX)');
END;
GO

-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyManager];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Executor
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyExecutor];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyWriter];
GO
-- =============================================
-- Title:       PublicKey - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		PublicKey
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Reader
-- =============================================
GRANT EXECUTE ON OBJECT::[PublicKey].[FromBinary] TO [PublicKeyReader];
GO