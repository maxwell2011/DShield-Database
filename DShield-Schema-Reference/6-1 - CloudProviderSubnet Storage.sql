USE [DShield]
GO

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		IPAddress
-- Type:		Table
-- Description:
--	Store Reference Table of IP Ranges owned
--	by various major cloud providers
-- =============================================
CREATE TABLE [Reference].[CloudProviderSubnets] (
    [Id]				INT IDENTITY(1,1) PRIMARY KEY,
	[Subnet]			VARBINARY(16) NOT NULL,
	[NetMask]			INT NOT NULL,
    [CloudProviderID]   INT NOT NULL,
	[Comment]			NVARCHAR(255) NULL DEFAULT NULL,
	--CONSTRAINT UQ_Reference_CloudProviders_Ip UNIQUE ([SubnetID]),	-- Only one provider can own a range at a time...
	CONSTRAINT CK_Reference_CloudProviders_NetMask CHECK ([NetMask] >= 0 AND [NetMask] <= 128), -- Not perfect, but better than nothing
	CONSTRAINT FK_Reference_CloudProviderSubnets_Subnet FOREIGN KEY ([Subnet]) 
		REFERENCES [IPAddress].[Subnets]([Value]),
	CONSTRAINT FK_Reference_CloudProviderSubnets_CloudProvider FOREIGN KEY ([CloudProviderID]) 
		REFERENCES [Reference].[CloudProviders]([Id])
);
GO
