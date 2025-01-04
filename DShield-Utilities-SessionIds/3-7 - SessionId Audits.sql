USE [DShield]
GO

-- =============================================
-- DShield Session Id Storage Audit
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		SessionId
-- Type:		Table
-- Description:
--	Create and record audit logs for INSERT, 
--  UPDATE, DELETE statements on the Session Id 
--  Storage table by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (INSERT, UPDATE, DELETE ON [SessionId].[Storage] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO