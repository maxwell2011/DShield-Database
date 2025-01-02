USE [DShield]
GO

-- =============================================
-- Title:       Preload - Cloud Providers
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Data
-- Description:
--  Preload the Cloud Providers lookup table (All)
-- =============================================
INSERT INTO [Reference].[CloudProviders] ([Value]) VALUES 
	('alibaba'),
	('amazon'),
	('baidu'),
	('cloudflare'),
	('digitalocean'),
	('dropbox'),
	('github'),
	('google'),
	('gotomeeting'),
	('huawei'),
	('oracle'),
	('salesforce'),
	('tencent');

GO