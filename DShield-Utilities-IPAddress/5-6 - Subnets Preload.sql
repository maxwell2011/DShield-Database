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