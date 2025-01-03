USE [DShield]
GO

-- =============================================
-- Title:       SessionId - To Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Scalar Function
-- Description:
--	Accept an MD5 hash/session id and convert 
--  to binary
-- =============================================
CREATE FUNCTION [SessionId].[ToBinary]
(
    @SessionId VARCHAR(32)
)
RETURNS VARBINARY(16)
AS
BEGIN
    -- Convert hex string to binary, removing any non-hex characters
    RETURN CAST('' AS XML).value('xs:hexBinary(sql:variable("@SessionId"))', 'VARBINARY(16)');
END;
GO

-- =============================================
-- Title:		SessionId - From Binary Storage
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		SessionId
-- Type:		Scalar Function
-- Description:
--	Accept a binary representation of an MD5 
--  hash/session id and convert back to varchar/string
-- =============================================

CREATE FUNCTION [SessionId].[FromBinary]
(
    @Binary VARBINARY(16)
)
RETURNS VARCHAR(32)
AS
BEGIN
    -- Convert binary back to lowercase hex string
    RETURN LOWER(
        CAST('' AS XML).value('xs:hexBinary(sql:variable("@Binary"))', 'VARCHAR(32)')
    );
END;
GO

