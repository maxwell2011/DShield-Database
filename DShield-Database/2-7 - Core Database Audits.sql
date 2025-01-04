USE [DShield]
GO

-- =============================================
-- DShield Database Activity Audit
--  Drops the Database Activity audit objects
-- =============================================
IF EXISTS (SELECT name FROM [sys].[database_audit_specifications] WHERE name = N'DShield_Database_Activity_Audit_Specification')
    ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification
    WITH (STATE = OFF);
GO
IF EXISTS (SELECT name FROM [sys].[database_audit_specifications] WHERE name = N'DShield_Database_Activity_Audit_Specification')
    DROP DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification;  
GO  
USE [master]
GO
-- =============================================
-- DShield Database Server Activity Audit
--  Drops the Database Activity server audit objects
-- =============================================

IF EXISTS (SELECT name FROM [sys].[server_audits] WHERE name = N'DShield_Activity_Server_Audit')
    ALTER SERVER AUDIT DShield_Activity_Server_Audit
    WITH (STATE = OFF);
GO
IF EXISTS (SELECT name FROM [sys].[server_audits] WHERE name = N'DShield_Activity_Server_Audit')
    DROP SERVER AUDIT DShield_Activity_Server_Audit;
GO

-- =============================================
-- Title:       Audit - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create a server level audit for the database
--	And assign to non-default location for
--  ease of access + avoiding versions conflicts
-- Reason:
--  This database will capture live scripts and
--  other nastiness from the open internet. Using
--  extensive built-in auditing features is one 
--  way to ensure there is a starting point
--  to find out what happened in the event of
--  something bad happening. More importantly,
--  using server level objects allows us to 
--  keep an eye on additional databases or systems
--  installed parallel to the DShield Database.
-- Note:
--  See below link for instructions to record
--  audit logs elsewhere
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql?view=sql-server-ver16
-- ============================================= 
CREATE SERVER AUDIT DShield_Activity_Server_Audit
    TO FILE (
        -- The path of the audit log. 
        -- The file name is generated based on the audit name and audit GUID
        FILEPATH = 'C:\DShield Database Audits\',   -- make sure this path exists!
        -- Specifies the maximum size to which the audit file can grow. 
        -- The max_size value must be an integer followed by MB, GB, TB, 
        -- or UNLIMITED. 
        -- The minimum size that you can specify for max_size is 2 MB 
        -- and the maximum is 2,147,483,647 TB. 
        -- When UNLIMITED is specified, the file grows until the disk is full. 
        -- (0 also indicates UNLIMITED.) Specifying a value lower than 2 MB 
        -- raises the error MSG_MAXSIZE_TOO_SMALL. 
        -- The default value is UNLIMITED.
        MAXSIZE = 16 MB,
        -- Specifies the maximum number of files to retain in the file 
        -- system in addition to the current file. 
        -- The MAX_ROLLOVER_FILES value must be an integer or UNLIMITED. 
        -- The default value is UNLIMITED. This parameter is evaluated 
        -- whenever the audit restarts (which can happen when the instance 
        -- of the Database Engine restarts or when the audit is turned off 
        -- and then on again) or when a new file is needed because the MAXSIZE is reached.
        MAX_ROLLOVER_FILES = 128,
        -- This option preallocates the file on the disk to the MAXSIZE value. 
        -- It applies only if MAXSIZE isn't equal to UNLIMITED. The default value is OFF.
        RESERVE_DISK_SPACE = ON
        )
    WITH (
    -- Determines the time, in milliseconds, 
    -- that can elapse before audit actions are forced to be processed. 
    -- A value of 0 indicates synchronous delivery. The minimum settable 
    -- query delay value is 1000 (1 second), which is the default. 
    -- The maximum is 2147483647 
    -- (2,147,483.647 seconds or 24 days, 20 hours, 31 minutes, 23.647 seconds). 
    -- Specifying an invalid number raises the MSG_INVALID_QUEUE_DELAY error.
    QUEUE_DELAY = 15000,
    -- Indicates whether the instance writing to the target should 
    -- fail, continue, or stop SQL Server if the target can't write to the audit log. 
    -- The default value is CONTINUE.
    ON_FAILURE = CONTINUE
    );
GO
USE [DShield]
GO
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Core
-- Type:		Database
-- Description:
--	Create and record audit logs for UPDATE, DELETE  
--  statements on the Core Schema by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
CREATE DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (UPDATE, DELETE ON SCHEMA::[Core] BY PUBLIC)  
    WITH (STATE=ON);   
GO  


