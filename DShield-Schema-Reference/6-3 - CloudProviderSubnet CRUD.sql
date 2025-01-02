USE [DShield]
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