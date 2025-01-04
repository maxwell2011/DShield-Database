USE [DShield]
GO

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		View
-- Description:
--  View to Select Subnets and their Owners
-- FIXME: I made an oopsies with JOIN [Reference].[IPAddresses]
-- =============================================
/*
CREATE VIEW [Reference].[CloudProviderSubnetOwnership] AS
SELECT
      [IPAddress].[FromBinary](ipa.[Value]) AS [Subnet]
      ,cld.[NetMask]
      ,cps.[Value] AS [Provider]
      ,cld.[Comment]
  FROM [Reference].[CloudProviderSubnets] cld
  JOIN [Reference].[CloudProviders] cps ON cps.[Id] = cld.[CloudProviderID]
  JOIN [Reference].[IPAddresses] ipa ON ipa.[Id] = cld.[SubnetID]
GO
*/

