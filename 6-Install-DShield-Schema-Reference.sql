USE [DShield]
GO

-- =============================================
-- Reference Schema
--  Relatively static, 
--  source of a lot of FK constraints
-- =============================================
-- =============================================
-- Reference - Drop Views
-- =============================================
IF OBJECT_ID('[Reference].[CloudProviderSubnetOwnership]', 'V') IS NOT NULL
    DROP VIEW [Reference].[CloudProviderSubnetOwnership]
GO
-- =============================================
-- Reference - Drop Procedures
-- =============================================
IF OBJECT_ID('[Reference].[UpsertKeyTypes]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertKeyTypes]
GO
IF OBJECT_ID('[Reference].[UpsertCloudProviderSubnet]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertCloudProviderSubnet]
GO
IF OBJECT_ID('[Reference].[UpsertCloudProvider]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertCloudProvider]
GO
IF OBJECT_ID('[Reference].[UpsertArchitecture]', 'P') IS NOT NULL
    DROP PROCEDURE [Reference].[UpsertArchitecture]
GO
-- =============================================
-- Reference - Drop Tables
-- =============================================
IF OBJECT_ID('[Reference].[RFC]', 'U') IS NOT NULL
  DROP TABLE [Reference].[RFC]
GO

IF OBJECT_ID('[Reference].[Protocols]', 'U') IS NOT NULL
  DROP TABLE [Reference].[Protocols]
GO

IF OBJECT_ID('[Reference].[CloudProviderSubnets]', 'U') IS NOT NULL
  DROP TABLE [Reference].[CloudProviderSubnets]
GO


IF OBJECT_ID('[Reference].[CloudProviders]', 'U') IS NOT NULL
  DROP TABLE [Reference].[CloudProviders]
GO

IF OBJECT_ID('[Reference].[Architectures]', 'U') IS NOT NULL
  DROP TABLE [Reference].[Architectures]
GO

IF OBJECT_ID('[Reference].[KeyTypes]', 'U') IS NOT NULL
  DROP TABLE [Reference].[KeyTypes]
GO

-- =============================================
-- Reference - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Reference')
    DROP SCHEMA [Reference]
GO

CREATE SCHEMA [Reference]
GO

USE [DShield]
GO

-- =============================================
-- Reference - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceManager' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceManager', 'CoreManager'
	EXEC sp_droprolemember 'ReferenceManager', 'UtilityManager'
	EXEC sp_droprole [ReferenceManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceManager' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceManager] 
	AUTHORIZATION db_securityadmin;

EXEC sp_addrolemember 'ReferenceManager', 'CoreManager'
EXEC sp_addrolemember 'ReferenceManager', 'UtilityManager'
GO
-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceWriter' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceWriter', 'CoreWriter'
	EXEC sp_droprolemember 'ReferenceWriter', 'UtilityWriter'
	EXEC sp_droprole [ReferenceWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceWriter' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceWriter] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceWriter', 'CoreWriter'
EXEC sp_addrolemember 'ReferenceWriter', 'UtilityWriter'
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceExecutor', 'CoreExecutor'
	EXEC sp_droprolemember 'ReferenceExecutor', 'UtilityExecutor'
	EXEC sp_droprole [ReferenceExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceExecutor] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceExecutor', 'CoreExecutor'
EXEC sp_addrolemember 'ReferenceExecutor', 'UtilityExecutor'
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceReader' AND 
		type = 'R'
		)
	EXEC sp_droprolemember 'ReferenceReader', 'CoreReader'
	EXEC sp_droprolemember 'ReferenceReader', 'UtilityReader'
	EXEC sp_droprole [ReferenceReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'ReferenceReader' AND 
		type = 'R'
		)
	CREATE ROLE [ReferenceReader] 
	AUTHORIZATION db_securityadmin;
EXEC sp_addrolemember 'ReferenceReader', 'CoreReader'
EXEC sp_addrolemember 'ReferenceReader', 'UtilityReader'
GO


-- =============================================
-- Title:       IPAddress Permissions
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Role
-- Description:
--	Map Permissions for IPAddress Schema
-- =============================================
EXEC sp_addrolemember 'IPAddressManager', 'ReferenceManager'
EXEC sp_addrolemember 'IPAddressWriter', 'ReferenceWriter'
EXEC sp_addrolemember 'IPAddressExecutor', 'ReferenceExecutor'
EXEC sp_addrolemember 'IPAddressReader', 'ReferenceReader'
GO
USE [DShield]
GO
-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Table
-- Description:
--  Store Quick Lookup of RFC Info (All)
-- =============================================
CREATE TABLE [Reference].[RFC] (
    [Number] INT PRIMARY KEY,
    [Name] VARCHAR(127) NOT NULL DEFAULT '',
    [Description] VARCHAR(255) NOT NULL DEFAULT '',
    CONSTRAINT UQ_Reference_RFC_Number_Name UNIQUE ([Number], [Name])
);

GO




USE [DShield]
GO

-- =============================================
-- Title:       Preload - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Data
-- Description:
--  Preload the RFC table
-- =============================================
INSERT INTO [Reference].[RFC] 
	([Number], [Name], [Description]) 
VALUES 
    (1045, 'VERSATILE MESSAGE TRANSACTION PROTOCOL', 'https://datatracker.ietf.org/doc/html/rfc1045'),
    (1112, 'Host Extensions for IP Multicasting', 'https://datatracker.ietf.org/doc/html/rfc1112'),
    (1142, 'OSI IS-IS Intra-domain Routing Protocol', 'https://datatracker.ietf.org/doc/html/rfc1142'),
    (1195, 'Use of OSI IS-IS for Routing in TCP/IP and Dual Environments', 'https://datatracker.ietf.org/doc/html/rfc1195'),
    (1190, 'Experimental Internet Stream Protocol, Version 2 (ST-II)', 'https://datatracker.ietf.org/doc/html/rfc1190'),
    (1819, 'Internet Stream Protocol Version 2 (ST2)', 'https://datatracker.ietf.org/doc/html/rfc1819'),
    (1241, 'A Scheme for an Internet Encapsulation Protocol: Version 1', 'https://datatracker.ietf.org/doc/html/rfc1241'),
    (1479, 'Inter-Domain Policy Routing Protocol Specification: Version 1', 'https://datatracker.ietf.org/doc/html/rfc1479'),
    (1735, 'NBMA Address Resolution Protocol (NARP)', 'https://datatracker.ietf.org/doc/html/rfc1735'),
    (1940, 'Source Demand Routing: Packet Format and Forwarding Specification (Version 1).', 'https://datatracker.ietf.org/doc/html/rfc1940'),
    (2003, 'IP Encapsulation within IP', 'https://datatracker.ietf.org/doc/html/rfc2003'),
    (2004, 'Minimal Encapsulation within IP', 'https://datatracker.ietf.org/doc/html/rfc2004'),
    (2189, 'Core Based Trees (CBT version 2) Multicast Routing', 'https://datatracker.ietf.org/doc/html/rfc2189'),
    (2205, 'Resource ReSerVation Protocol (RSVP)', 'https://datatracker.ietf.org/doc/html/rfc2205'),
    (2328, 'OSPF Version 2', 'https://datatracker.ietf.org/doc/html/rfc2328'),
    (2356, '', 'https://datatracker.ietf.org/doc/html/rfc2356'),
    (2473, '', 'https://datatracker.ietf.org/doc/html/rfc2473'),
    (2784, '', 'https://datatracker.ietf.org/doc/html/rfc2784'),
    (2890, '', 'https://datatracker.ietf.org/doc/html/rfc2890'),
    (3173, '', 'https://datatracker.ietf.org/doc/html/rfc3173'),
    (3175, '', 'https://datatracker.ietf.org/doc/html/rfc3175'),
    (3208, '', 'https://datatracker.ietf.org/doc/html/rfc3208'),
    (3378, '', 'https://datatracker.ietf.org/doc/html/rfc3378'),
    (3692, '', 'https://datatracker.ietf.org/doc/html/rfc3692'),
    (3828, '', 'https://datatracker.ietf.org/doc/html/rfc3828'),
    (3931, '', 'https://datatracker.ietf.org/doc/html/rfc3931'),
    (4023, '', 'https://datatracker.ietf.org/doc/html/rfc4023'),
    (5332, '', 'https://datatracker.ietf.org/doc/html/rfc5332'),
    (4302, '', 'https://datatracker.ietf.org/doc/html/rfc4302'),
    (4303, '', 'https://datatracker.ietf.org/doc/html/rfc4303'),
    (4340, '', 'https://datatracker.ietf.org/doc/html/rfc4340'),
    (4884, '', 'https://datatracker.ietf.org/doc/html/rfc4884'),
    (4443, '', 'https://datatracker.ietf.org/doc/html/rfc4443'),
    (4728, '', 'https://datatracker.ietf.org/doc/html/rfc4728'),
    (4960, '', 'https://datatracker.ietf.org/doc/html/rfc4960'),
    (5201, '', 'https://datatracker.ietf.org/doc/html/rfc5201'),
    (5237, '', 'https://datatracker.ietf.org/doc/html/rfc5237'),
    (5498, '', 'https://datatracker.ietf.org/doc/html/rfc5498'),
    (5533, '', 'https://datatracker.ietf.org/doc/html/rfc5533'),
    (5798, '', 'https://datatracker.ietf.org/doc/html/rfc5798'),
    (5840, '', 'https://datatracker.ietf.org/doc/html/rfc5840'),
    (5856, '', 'https://datatracker.ietf.org/doc/html/rfc5856'),
    (6275, '', 'https://datatracker.ietf.org/doc/html/rfc6275'),
    (741, '', 'https://datatracker.ietf.org/doc/html/rfc741'),
    (768, '', 'https://datatracker.ietf.org/doc/html/rfc768'),
    (792, '', 'https://datatracker.ietf.org/doc/html/rfc792'),
    (793, '', 'https://datatracker.ietf.org/doc/html/rfc793'),
    (8200, '', 'https://datatracker.ietf.org/doc/html/rfc8200'),
    (823, '', 'https://datatracker.ietf.org/doc/html/rfc823'),
    (869, '', 'https://datatracker.ietf.org/doc/html/rfc869'),
    (888, '', 'https://datatracker.ietf.org/doc/html/rfc888'),
    (8986, '', 'https://datatracker.ietf.org/doc/html/rfc8986'),
    (905, '', 'https://datatracker.ietf.org/doc/html/rfc905'),
    (908, '', 'https://datatracker.ietf.org/doc/html/rfc908'),
    (9347, '', 'https://datatracker.ietf.org/doc/html/rfc9347'),
    (938, '', 'https://datatracker.ietf.org/doc/html/rfc938'),
    (998, '', 'https://datatracker.ietf.org/doc/html/rfc998')
GO
USE [DShield]
GO

-- =============================================
-- DShield Reference RFC Table Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  RFC table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[RFC] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Table
-- Description:
--  Store Quick Lookup of IP Protocol Info (All)
-- =============================================
CREATE TABLE [Reference].[Protocols] (
    [Number] INT PRIMARY KEY,
    [Name] VARCHAR(255) NULL,
    [Keyword] VARCHAR(31) NOT NULL
    CONSTRAINT UQ_Reference_Protocols_Number_Keyword UNIQUE ([Number], [Keyword]),
);

GO

USE [DShield]
GO

-- =============================================
-- Title:       Preload - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Data
-- Description:
--  Preload the Protocols table (All)
-- =============================================
INSERT INTO [Reference].[Protocols] 
	([Number], [Name], [Keyword]) 
VALUES 
    (0, 'IPv6 Hop-by-Hop Option', 'HOPOPT'),
    (1, 'Internet Control Message Protocol', 'ICMP'),
    (2, 'Internet Group Management Protocol', 'IGMP'),
    (3, 'Gateway-to-Gateway Protocol', 'GGP'),
    (4, 'IP in IP (encapsulation)', 'IP-in-IP'),
    (5, 'Internet Stream Protocol', 'ST'),
    (6, 'Transmission Control Protocol', 'TCP'),
    (7, 'Core-based trees', 'CBT'),
    (8, 'Exterior Gateway Protocol', 'EGP'),
    (9, 'Interior gateway protocol (any private interior gateway, for example Ciscos IGRP)', 'IGP'),
    (10, 'BBN RCC Monitoring', 'BBN-RCC-MON'),
    (11, 'Network Voice Protocol', 'NVP-II'),
    (12, 'Xerox PUP', 'PUP'),
    (13, 'ARGUS', 'ARGUS'),
    (14, 'EMCON', 'EMCON'),
    (15, 'Cross Net Debugger', 'XNET'),
    (16, 'Chaos', 'CHAOS'),
    (17, 'User Datagram Protocol', 'UDP'),
    (18, 'Multiplexing', 'MUX'),
    (19, 'DCN Measurement Subsystems', 'DCN-MEAS'),
    (20, 'Host Monitoring Protocol', 'HMP'),
    (21, 'Packet Radio Measurement', 'PRM'),
    (22, 'XEROX NS IDP', 'XNS-IDP'),
    (23, 'Trunk-1', 'TRUNK-1'),
    (24, 'Trunk-2', 'TRUNK-2'),
    (25, 'Leaf-1', 'LEAF-1'),
    (26, 'Leaf-2', 'LEAF-2'),
    (27, 'Reliable Data Protocol', 'RDP'),
    (28, 'Internet Reliable Transaction Protocol', 'IRTP'),
    (29, 'ISO Transport Protocol Class 4', 'ISO-TP4'),
    (30, 'Bulk Data Transfer Protocol', 'NETBLT'),
    (31, 'MFE Network Services Protocol', 'MFE-NSP'),
    (32, 'MERIT Internodal Protocol', 'MERIT-INP'),
    (33, 'Datagram Congestion Control Protocol', 'DCCP'),
    (34, 'Third Party Connect Protocol', '3PC'),
    (35, 'Inter-Domain Policy Routing Protocol', 'IDPR'),
    (36, 'Xpress Transport Protocol', 'XTP'),
    (37, 'Datagram Delivery Protocol', 'DDP'),
    (38, 'IDPR Control Message Transport Protocol', 'IDPR-CMTP'),
    (39, 'TP++ Transport Protocol', 'TP++'),
    (40, 'IL Transport Protocol', 'IL'),
    (41, 'IPv6 Encapsulation (6to4 and 6in4)', 'IPv6'),
    (42, 'Source Demand Routing Protocol', 'SDRP'),
    (43, 'Routing Header for IPv6', 'IPv6-Route'),
    (44, 'Fragment Header for IPv6', 'IPv6-Frag'),
    (45, 'Inter-Domain Routing Protocol', 'IDRP'),
    (46, 'Resource Reservation Protocol', 'RSVP'),
    (47, 'Generic Routing Encapsulation', 'GRE'),
    (48, 'Dynamic Source Routing Protocol', 'DSR'),
    (49, 'Burroughs Network Architecture', 'BNA'),
    (50, 'Encapsulating Security Payload', 'ESP'),
    (51, 'Authentication Header', 'AH'),
    (52, 'Integrated Net Layer Security Protocol', 'I-NLSP'),
    (53, 'SwIPe', 'SwIPe'),
    (54, 'NBMA Address Resolution Protocol', 'NARP'),
    (55, 'IP Mobility (Min Encap)', 'MOBILE'),
    (56, 'Transport Layer Security Protocol (using Kryptonet key management)', 'TLSP'),
    (57, 'Simple Key-Management for Internet Protocol', 'SKIP'),
    (58, 'ICMP for IPv6', 'IPv6-ICMP'),
    (59, 'No Next Header for IPv6', 'IPv6-NoNxt'),
    (60, 'Destination Options for IPv6', 'IPv6-Opts'),
    (61, 'Any host internal protocol', ''),
    (62, 'CFTP', 'CFTP'),
    (63, 'Any local network', ''),
    (64, 'SATNET and Backroom EXPAK', 'SAT-EXPAK'),
    (65, 'Kryptolan', 'KRYPTOLAN'),
    (66, 'MIT Remote Virtual Disk Protocol', 'RVD'),
    (67, 'Internet Pluribus Packet Core', 'IPPC'),
    (68, 'Any distributed file system', ''),
    (69, 'SATNET Monitoring', 'SAT-MON'),
    (70, 'VISA Protocol', 'VISA'),
    (71, 'Internet Packet Core Utility', 'IPCU'),
    (72, 'Computer Protocol Network Executive', 'CPNX'),
    (73, 'Computer Protocol Heart Beat', 'CPHB'),
    (74, 'Wang Span Network', 'WSN'),
    (75, 'Packet Video Protocol', 'PVP'),
    (76, 'Backroom SATNET Monitoring', 'BR-SAT-MON'),
    (77, 'SUN ND PROTOCOL-Temporary', 'SUN-ND'),
    (78, 'WIDEBAND Monitoring', 'WB-MON'),
    (79, 'WIDEBAND EXPAK', 'WB-EXPAK'),
    (80, 'International Organization for Standardization Internet Protocol', 'ISO-IP'),
    (81, 'Versatile Message Transaction Protocol', 'VMTP'),
    (82, 'Secure Versatile Message Transaction Protocol', 'SECURE-VMTP'),
    (83, 'VINES', 'VINES'),
    --(84, 'TTP (Transaction Transport Protocol) (obsoleted March 2023)', 'TTP'),
    (84, 'Internet Protocol Traffic Manager', 'IPTM'),
    (85, 'NSFNET-IGP', 'NSFNET-IGP'),
    (86, 'Dissimilar Gateway Protocol', 'DGP'),
    (87, 'TCF', 'TCF'),
    (88, 'EIGRP', 'EIGRP'),
    (89, 'Open Shortest Path First', 'OSPF'),
    (90, 'Sprite RPC Protocol', 'Sprite-RPC'),
    (91, 'Locus Address Resolution Protocol', 'LARP'),
    (92, 'Multicast Transport Protocol', 'MTP'),
    (93, 'AX.25', 'AX.25'),
    (94, 'KA9Q NOS compatible IP over IP tunneling', 'OS'),
    (95, 'Mobile Internetworking Control Protocol', 'MICP'),
    (96, 'Semaphore Communications Sec. Pro', 'SCC-SP'),
    (97, 'Ethernet-within-IP Encapsulation', 'ETHERIP'),
    (98, 'Encapsulation Header', 'ENCAP'),
    (99, 'Any private encryption scheme', ''),
    (100, 'GMTP', 'GMTP'),
    (101, 'Ipsilon Flow Management Protocol', 'IFMP'),
    (102, 'PNNI over IP', 'PNNI'),
    (103, 'Protocol Independent Multicast', 'PIM'),
    (104, 'IBMs ARIS (Aggregate Route IP Switching) Protocol', 'ARIS'),
    (105, 'SCPS (Space Communications Protocol Standards)', 'SCPS'),
    (106, 'QNX', 'QNX'),
    (107, 'Active Networks', 'A/N'),
    (108, 'IP Payload Compression Protocol', 'IPComp'),
    (109, 'Sitara Networks Protocol', 'SNP'),
    (110, 'Compaq Peer Protocol', 'Compaq-Peer'),
    (111, 'IPX in IP', 'IPX-in-IP'),
    (112, 'Virtual Router Redundancy Protocol, Common Address Redundancy Protocol (not IANA assigned)', 'VRRP'),
    (113, 'PGM Reliable Transport Protocol', 'PGM'),
    (114, 'Any 0-hop protocol', ''),
    (115, 'Layer Two Tunneling Protocol Version 3', 'L2TP'),
    (116, 'D-II Data Exchange (DDX)', 'DDX'),
    (117, 'Interactive Agent Transfer Protocol', 'IATP'),
    (118, 'Schedule Transfer Protocol', 'STP'),
    (119, 'SpectraLink Radio Protocol', 'SRP'),
    (120, 'Universal Transport Interface Protocol', 'UTI'),
    (121, 'Simple Message Protocol', 'SMP'),
    (122, 'Simple Multicast Protocol', 'SM'),
    (123, 'Performance Transparency Protocol', 'PTP'),
    (124, 'Intermediate System to Intermediate System (IS-IS) Protocol over IPv4', 'IS-IS over IPv4'),
    (125, 'Flexible Intra-AS Routing Environment', 'FIRE'),
    (126, 'Combat Radio Transport Protocol', 'CRTP'),
    (127, 'Combat Radio User Datagram', 'CRUDP'),
    (128, 'Service-Specific Connection-Oriented Protocol in a Multilink and Connectionless Environment', 'SSCOPMCE'),
    (129, 'IPLT', ''),
    (130, 'Secure Packet Shield', 'SPS'),
    (131, 'Private IP Encapsulation within IP', 'PIPE'),
    (132, 'Stream Control Transmission Protocol', 'SCTP'),
    (133, 'Fibre Channel', 'FC'),
    (134, 'Reservation Protocol (RSVP) End-to-End Ignore', 'RSVP-E2E-IGNORE'),
    (135, 'Mobility Extension Header for IPv6', 'Mobility Header'),
    (136, 'Lightweight User Datagram Protocol', 'UDPLite'),
    (137, 'Multiprotocol Label Switching Encapsulated in IP', 'MPLS-in-IP'),
    (138, 'MANET Protocols', 'manet'),
    (139, 'Host Identity Protocol', 'HIP'),
    (140, 'Site Multihoming by IPv6 Intermediation', 'Shim6'),
    (141, 'Wrapped Encapsulating Security Payload', 'WESP'),
    (142, 'Robust Header Compression', 'ROHC'),
    (143, 'Segment Routing over IPv6', 'Ethernet'),
    (144, 'AGGFRAG Encapsulation Payload for ESP', 'AGGFRAG'),
    (145, 'Network Service Header', 'NSH'),
    (146, 'Unassigned', ''),
    (147, 'Unassigned', ''),
    (148, 'Unassigned', ''),
    (149, 'Unassigned', ''),
    (150, 'Unassigned', ''),
    (151, 'Unassigned', ''),
    (152, 'Unassigned', ''),
    (153, 'Unassigned', ''),
    (154, 'Unassigned', ''),
    (155, 'Unassigned', ''),
    (156, 'Unassigned', ''),
    (157, 'Unassigned', ''),
    (158, 'Unassigned', ''),
    (159, 'Unassigned', ''),
    (160, 'Unassigned', ''),
    (161, 'Unassigned', ''),
    (162, 'Unassigned', ''),
    (163, 'Unassigned', ''),
    (164, 'Unassigned', ''),
    (165, 'Unassigned', ''),
    (166, 'Unassigned', ''),
    (167, 'Unassigned', ''),
    (168, 'Unassigned', ''),
    (169, 'Unassigned', ''),
    (170, 'Unassigned', ''),
    (171, 'Unassigned', ''),
    (172, 'Unassigned', ''),
    (173, 'Unassigned', ''),
    (174, 'Unassigned', ''),
    (175, 'Unassigned', ''),
    (176, 'Unassigned', ''),
    (177, 'Unassigned', ''),
    (178, 'Unassigned', ''),
    (179, 'Unassigned', ''),
    (180, 'Unassigned', ''),
    (181, 'Unassigned', ''),
    (182, 'Unassigned', ''),
    (183, 'Unassigned', ''),
    (184, 'Unassigned', ''),
    (185, 'Unassigned', ''),
    (186, 'Unassigned', ''),
    (187, 'Unassigned', ''),
    (188, 'Unassigned', ''),
    (189, 'Unassigned', ''),
    (190, 'Unassigned', ''),
    (191, 'Unassigned', ''),
    (192, 'Unassigned', ''),
    (193, 'Unassigned', ''),
    (194, 'Unassigned', ''),
    (195, 'Unassigned', ''),
    (196, 'Unassigned', ''),
    (197, 'Unassigned', ''),
    (198, 'Unassigned', ''),
    (199, 'Unassigned', ''),
    (200, 'Unassigned', ''),
    (201, 'Unassigned', ''),
    (202, 'Unassigned', ''),
    (203, 'Unassigned', ''),
    (204, 'Unassigned', ''),
    (205, 'Unassigned', ''),
    (206, 'Unassigned', ''),
    (207, 'Unassigned', ''),
    (208, 'Unassigned', ''),
    (209, 'Unassigned', ''),
    (210, 'Unassigned', ''),
    (211, 'Unassigned', ''),
    (212, 'Unassigned', ''),
    (213, 'Unassigned', ''),
    (214, 'Unassigned', ''),
    (215, 'Unassigned', ''),
    (216, 'Unassigned', ''),
    (217, 'Unassigned', ''),
    (218, 'Unassigned', ''),
    (219, 'Unassigned', ''),
    (220, 'Unassigned', ''),
    (221, 'Unassigned', ''),
    (222, 'Unassigned', ''),
    (223, 'Unassigned', ''),
    (224, 'Unassigned', ''),
    (225, 'Unassigned', ''),
    (226, 'Unassigned', ''),
    (227, 'Unassigned', ''),
    (228, 'Unassigned', ''),
    (229, 'Unassigned', ''),
    (230, 'Unassigned', ''),
    (231, 'Unassigned', ''),
    (232, 'Unassigned', ''),
    (233, 'Unassigned', ''),
    (234, 'Unassigned', ''),
    (235, 'Unassigned', ''),
    (236, 'Unassigned', ''),
    (237, 'Unassigned', ''),
    (238, 'Unassigned', ''),
    (239, 'Unassigned', ''),
    (240, 'Unassigned', ''),
    (241, 'Unassigned', ''),
    (242, 'Unassigned', ''),
    (243, 'Unassigned', ''),
    (244, 'Unassigned', ''),
    (245, 'Unassigned', ''),
    (246, 'Unassigned', ''),
    (247, 'Unassigned', ''),
    (248, 'Unassigned', ''),
    (249, 'Unassigned', ''),
    (250, 'Unassigned', ''),
    (251, 'Unassigned', ''),
    (252, 'Unassigned', ''),
    (253, 'Use for experimentation and testing', 'Testing'),
    (254, 'Use for experimentation and testing', 'Testing'),
    (255, 'Reserved', '')
GO
USE [DShield]
GO

-- =============================================
-- DShield Reference Protocol Table Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Protocol table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[Protocols] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store unique Cloud Providers for
--	fast lookups
-- =============================================
CREATE TABLE [Reference].[CloudProviders](
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Value] NVARCHAR(255) NOT NULL,
	PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_Reference_CloudProviders_Name] 
		UNIQUE NONCLUSTERED ([Value] ASC)
	);
GO



USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert Cloud Provider
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cloud Provider (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertCloudProvider] @Value NVARCHAR(255),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Cloud Provider
    SELECT @ID = [Id] 
    FROM [Reference].[CloudProviders] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[CloudProviders] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
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
USE [DShield]
GO

-- =============================================
-- DShield Reference Cloud Provider Table Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Cloud Provider table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[CloudProviders] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
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
	[SubnetID]			INT NOT NULL,
	[NetMask]			INT NOT NULL,
    [CloudProviderID]   INT NOT NULL,
	[Comment]			NVARCHAR(255) NULL DEFAULT NULL,
	--CONSTRAINT UQ_Reference_CloudProviders_Ip UNIQUE ([SubnetID]),	-- Only one provider can own a range at a time...
	CONSTRAINT CK_Reference_CloudProviders_NetMask CHECK ([NetMask] >= 0 AND [NetMask] <= 128), -- Not perfect, but better than nothing
	CONSTRAINT FK_Reference_CloudProviderSubnets_Subnet FOREIGN KEY ([SubnetID]) 
		REFERENCES [IPAddress].[Subnets]([Id]),
	CONSTRAINT FK_Reference_CloudProviderSubnets_CloudProvider FOREIGN KEY ([CloudProviderID]) 
		REFERENCES [Reference].[CloudProviders]([Id])
);
GO

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


USE [DShield]
GO

-- =============================================
-- DShield Reference Cloud Provider Subnet Table Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Cloud Provider Subnet table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[CloudProviderSubnets] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       Reference - Architectures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Reference].[Architectures] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(64) NOT NULL UNIQUE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a Architecturess (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertArchitectures] @Value NVARCHAR(64),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[Architectures] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[Architectures] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Reference Architecture Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Architectures table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[Architectures] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Schema
-- Description:
--  Table to store Unique SSHClientVersions Observed
--  in the wild (All)
-- =============================================
CREATE TABLE [Reference].[KeyTypes] (
	[Id]	INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Value]	NVARCHAR(32) NOT NULL UNIQUE
);
GO

USE [DShield]
GO
-- =============================================
-- Title:       Reference - Upsert KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Stored Procedure
-- Description:
--  Upsert a KeyTypes (Single)
-- =============================================
CREATE PROCEDURE [Reference].[UpsertKeyTypes] @Value NVARCHAR(32),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Reference].[KeyTypes] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Reference].[KeyTypes] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
USE [DShield]
GO

-- =============================================
-- DShield Reference Key Types Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Reference
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Reference 
--  Key Types table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [Reference].[KeyTypes] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO

-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Reference].[RFC] TO [ReferenceManager]
GO

-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[RFC] TO [ReferenceWriter]
GO

-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[RFC] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - RFC
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================

GRANT REFERENCES, SELECT ON OBJECT::[Reference].[RFC] TO [ReferenceReader]
GO 


USE [DShield]
GO


-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Reference].[Protocols] TO [ReferenceManager]
GO

-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[Protocols] TO [ReferenceWriter]
GO

-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[Protocols] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - Protocols
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================

GRANT REFERENCES, SELECT ON OBJECT::[Reference].[Protocols] TO [ReferenceReader]
GO 


USE [DShield]
GO

-- =============================================
-- Title:       Reference - Cloud Providers
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviders] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - Cloud Providers
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviders] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Cloud Providers
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviders] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - Cloud Providers
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[CloudProviders] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - CloudProviders
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProvider] TO [ReferenceReader]
GO

USE [DShield]
GO

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviderSubnets] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviderSubnets] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviderSubnets] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - Cloud Provider Subnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[CloudProviderSubnets] TO [ReferenceReader]
GO

/*
FIXME: Theres a problem with the view...
-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[CloudProviderSubnetOwnership] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - Cloud Provider 
--                          Subnet Ownership
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[CloudProviderSubnetOwnership] TO [ReferenceReader]
GO

*/

-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - CloudProviderSubnets
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertCloudProviderSubnet] TO [ReferenceReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Reference - Architectures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[Architectures] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - Architectures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[Architectures] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Architectures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[Architectures] TO [ReferenceExecutor]; 
GO

-- =============================================
-- Title:       Reference - Architectures
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[Architectures] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceManager];
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - Architecturess
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertArchitectures] TO [ReferenceReader]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Manager with Grant
--	Grant References to Manager with Grant
--	Grant Insert to Manager with Grant
--	Grant Delete to Manager with Grant
--	Grant Update to Manager with Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [Reference].[KeyTypes] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Writer without Grant
--	Grant References to Writer without Grant
--	Grant Insert to Writer without Grant
--	Grant Delete to Writer without Grant
--	Grant Update to Writer without Grant
-- =============================================
GRANT DELETE, INSERT, REFERENCES, SELECT ON [Reference].[KeyTypes] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Executor without Grant
--	Grant References to Executor without Grant
--	Deny Insert to Executor
--	Deny Delete to Executor
--	Grant Update to Executor
-- =============================================
GRANT REFERENCES, SELECT ON OBJECT::[Reference].[KeyTypes] TO [ReferenceExecutor] 
GO

-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Select to Reader without Grant
--	Grant References to Reader without Grant
--	Deny Insert to Reader
--	Deny Delete to Reader
--	Deny Update to Reader
-- =============================================
GRANT REFERENCES, SELECT ON [Reference].[KeyTypes] TO [ReferenceReader]
GO

-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Manager with Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceManager]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Grant
-- Description:
--	Grant Execute to Writer without Grant
-- =============================================
GRANT EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceWriter]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Executor
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceExecutor]
GO
-- =============================================
-- Title:       Reference - KeyTypes
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Reference
-- Type:		Permissions Denial
-- Description:
--	Deny Execute to Reader
-- =============================================
DENY EXECUTE ON OBJECT::[Reference].[UpsertKeyTypes] TO [ReferenceReader]
GO
