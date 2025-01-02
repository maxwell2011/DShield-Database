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