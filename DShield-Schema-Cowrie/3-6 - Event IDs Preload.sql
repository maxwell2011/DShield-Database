USE [DShield]
GO

-- =============================================
-- Title:       Preload - Event Id's
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Cowrie
-- Type:		Data
-- Description:
--  Preload the Event Id table (All)
-- =============================================
INSERT INTO [Cowrie].[EventIds] ([Value]) VALUES 
('cowrie.session.connect'),
('cowrie.client.version'),
('cowrie.client.kex'),
('cowrie.login.failed'),
('cowrie.session.closed'),
('cowrie.login.success'),
('cowrie.session.params'),
('cowrie.command.input'),
('cowrie.command.failed'),
('cowrie.log.closed'),
('cowrie.session.file_download'),
('cowrie.direct-tcpip.request'),
('cowrie.session.file_upload'),
('cowrie.client.var'),
('cowrie.command.success'),
('cowrie.client.fingerprint'),
('cowrie.direct-tcpip.data'),
('cowrie.client.size'),
('cowrie.session.file_download.failed'),
('UNKNOWN');
GO