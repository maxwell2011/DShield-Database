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

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON OBJECT::[Reference].[RFC] TO [ReferenceManager]
GO

GRANT REFERENCES, SELECT ON OBJECT::[Reference].[RFC] TO [ReferenceReader]
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
    (2356, NULL, 'https://datatracker.ietf.org/doc/html/rfc2356'),
    (2473, NULL, 'https://datatracker.ietf.org/doc/html/rfc2473'),
    (2784, NULL, 'https://datatracker.ietf.org/doc/html/rfc2784'),
    (2890, NULL, 'https://datatracker.ietf.org/doc/html/rfc2890'),
    (3173, NULL, 'https://datatracker.ietf.org/doc/html/rfc3173'),
    (3175, NULL, 'https://datatracker.ietf.org/doc/html/rfc3175'),
    (3208, NULL, 'https://datatracker.ietf.org/doc/html/rfc3208'),
    (3378, NULL, 'https://datatracker.ietf.org/doc/html/rfc3378'),
    (3692, NULL, 'https://datatracker.ietf.org/doc/html/rfc3692'),
    (3828, NULL, 'https://datatracker.ietf.org/doc/html/rfc3828'),
    (3931, NULL, 'https://datatracker.ietf.org/doc/html/rfc3931'),
    (4023, NULL, 'https://datatracker.ietf.org/doc/html/rfc4023'),
    (5332, NULL, 'https://datatracker.ietf.org/doc/html/rfc5332'),
    (4302, NULL, 'https://datatracker.ietf.org/doc/html/rfc4302'),
    (4303, NULL, 'https://datatracker.ietf.org/doc/html/rfc4303'),
    (4340, NULL, 'https://datatracker.ietf.org/doc/html/rfc4340'),
    (4884, NULL, 'https://datatracker.ietf.org/doc/html/rfc4884'),
    (4443, NULL, 'https://datatracker.ietf.org/doc/html/rfc4443'),
    (4728, NULL, 'https://datatracker.ietf.org/doc/html/rfc4728'),
    (4960, NULL, 'https://datatracker.ietf.org/doc/html/rfc4960'),
    (5201, NULL, 'https://datatracker.ietf.org/doc/html/rfc5201'),
    (5237, NULL, 'https://datatracker.ietf.org/doc/html/rfc5237'),
    (5498, NULL, 'https://datatracker.ietf.org/doc/html/rfc5498'),
    (5533, NULL, 'https://datatracker.ietf.org/doc/html/rfc5533'),
    (5798, NULL, 'https://datatracker.ietf.org/doc/html/rfc5798'),
    (5840, NULL, 'https://datatracker.ietf.org/doc/html/rfc5840'),
    (5856, NULL, 'https://datatracker.ietf.org/doc/html/rfc5856'),
    (6275, NULL, 'https://datatracker.ietf.org/doc/html/rfc6275'),
    (741, NULL, 'https://datatracker.ietf.org/doc/html/rfc741'),
    (768, NULL, 'https://datatracker.ietf.org/doc/html/rfc768'),
    (792, NULL, 'https://datatracker.ietf.org/doc/html/rfc792'),
    (793, NULL, 'https://datatracker.ietf.org/doc/html/rfc793'),
    (8200, NULL, 'https://datatracker.ietf.org/doc/html/rfc8200'),
    (823, NULL, 'https://datatracker.ietf.org/doc/html/rfc823'),
    (869, NULL, 'https://datatracker.ietf.org/doc/html/rfc869'),
    (888, NULL, 'https://datatracker.ietf.org/doc/html/rfc888'),
    (8986, NULL, 'https://datatracker.ietf.org/doc/html/rfc8986'),
    (905, NULL, 'https://datatracker.ietf.org/doc/html/rfc905'),
    (908, NULL, 'https://datatracker.ietf.org/doc/html/rfc908'),
    (9347, NULL, 'https://datatracker.ietf.org/doc/html/rfc9347'),
    (938, NULL, 'https://datatracker.ietf.org/doc/html/rfc938'),
    (998, NULL, 'https://datatracker.ietf.org/doc/html/rfc998')
GO