USE [DShield]
GO
-- =============================================
-- DShield Database Audit
--  Drops the Database audit objects
-- =============================================
IF EXISTS (SELECT name FROM [sys].[database_audit_specifications] WHERE name = N'DShield_Essential_Database_Audit_Specification')
    ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification
    WITH (STATE = OFF);
GO
IF EXISTS (SELECT name FROM [sys].[database_audit_specifications] WHERE name = N'DShield_Essential_Database_Audit_Specification')
    DROP DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification;  
GO  


USE [master]
GO
-- =============================================
-- DShield Database Server Audit
--  Drops the base server audit objects
-- =============================================
IF EXISTS (SELECT name FROM [sys].[server_audit_specifications] WHERE name = N'DShield_Essential_Server_Audit_Specification')
    ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification
    WITH (STATE = OFF);
GO
IF EXISTS (SELECT name FROM [sys].[server_audit_specifications] WHERE name = N'DShield_Essential_Server_Audit_Specification')
    DROP SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification;  
GO  


IF EXISTS (SELECT name FROM [sys].[server_audits] WHERE name = N'DShield_Essential_Server_Audit')
    ALTER SERVER AUDIT DShield_Essential_Server_Audit
    WITH (STATE = OFF);
GO
IF EXISTS (SELECT name FROM [sys].[server_audits] WHERE name = N'DShield_Essential_Server_Audit')
    DROP SERVER AUDIT DShield_Essential_Server_Audit;
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
CREATE SERVER AUDIT DShield_Essential_Server_Audit
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

-- =============================================
-- Title:       Audit - Enable
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Enable the Server Audit
-- ============================================= 
ALTER SERVER AUDIT DShield_Essential_Server_Audit WITH (STATE = ON);
GO

-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for failed login
--  attempts at the server level
-- Notes:
--  Indicates that a principal tried to log on to SQL Server and failed. 
--  Events in this class are raised by new connections or by connections 
--  that are reused from a connection pool. 
--  Equivalent to the Audit Login Failed Event Class. 
--  This audit doesn't apply to Azure SQL Database.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
CREATE SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (FAILED_LOGIN_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for application
--  role password changes at the server level
-- Notes:
--  This event is raised whenever a password is 
--  changed for an application role. 
--  Equivalent to the Audit App Role Change Password Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (APPLICATION_ROLE_CHANGE_PASSWORD_GROUP)  
    WITH (STATE=OFF);   
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for changes
--  to database permissions at the server level
-- Notes:
--  This event is raised whenever a 
--  GRANT, REVOKE, or DENY is issued for a statement 
--  permission by any principal in SQL Server 
--  (This applies to database-only events, such 
--  as granting permissions on a database).
--
--  This event is raised for any database permission 
--  change (GDR) for any database in the server. 
--  Equivalent to the Audit Database Scope GDR Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_PERMISSION_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for CRUD of
--  database principals at the server level
-- Notes:
--  This event is raised when principals, 
--  such as users, are created, altered, or 
--  dropped from a database. Equivalent to the 
--  Audit Database Principal Management Event Class. 
--  (Also equivalent to the Audit Add DB Principal 
--  Event Class, which occurs on the deprecated 
--  sp_grantdbaccess, sp_revokedbaccess, sp_addPrincipal, 
--  and sp_dropPrincipal stored procedures.)
--
--  This event is raised whenever a database role is
--  added to or removed by using the sp_addrole, 
--  sp_droprole stored procedures. 
--  This event is raised whenever any database principals 
--  are created, altered, or dropped from any database. 
--  Equivalent to the Audit Add Role Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_PRINCIPAL_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for CRUD of
--  logins for roles at the server level
-- Notes:
--  This event is raised whenever a login is 
--  added to or removed from a database role. 
--  This event class is raised for the sp_addrolemember, 
--  sp_changegroup, and sp_droprolemember stored procedures. 
--  This event is raised on any Database role 
--  member change in any database. 
--  Equivalent to the Audit Add Member to DB Role Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Create and record audit logs for changes to
--  server principals
-- Notes:
--  This event is raised when server principals are 
--  created, altered, or dropped. 
--  Equivalent to the Audit Server Principal Management Event Class.
--
--  This event is raised when a principal issues 
--  the sp_defaultdb or sp_defaultlanguage stored 
--  procedures or ALTER LOGIN statements. 
--  Equivalent to the Audit Addlogin Event Class.
--
--  This event is raised on the sp_addlogin and 
--  sp_droplogin stored procedures. 
--  Also equivalent to the Audit Login Change Property Event Class.
--
--  This event is raised for the sp_grantlogin or 
--  sp_revokelogin stored procedures. 
--  Equivalent to the Audit Login GDR Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (SERVER_PRINCIPAL_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Server
-- Description:
--	Enable the recording of custom user-defined
--  auditable events to be written to the 
--  server audit log
-- Notes:
--  This group monitors events raised by using sp_audit_write.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER SERVER AUDIT SPECIFICATION DShield_Essential_Server_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (USER_DEFINED_AUDIT_GROUP)  
    WITH (STATE=ON);  
GO  


USE [DShield]
GO

-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Create and record audit logs for application
--  role password changes at the server level
-- Notes:
--  This event is raised whenever a password is 
--  changed for an application role. 
--  Equivalent to the Audit App Role Change Password Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
CREATE DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (APPLICATION_ROLE_CHANGE_PASSWORD_GROUP)  
    WITH (STATE=OFF);   
GO  
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Create and record audit logs for changes
--  to database permissions at the server level
-- Notes:
--  This event is raised whenever a 
--  GRANT, REVOKE, or DENY is issued for a statement 
--  permission by any principal in SQL Server 
--  (This applies to database-only events, such 
--  as granting permissions on a database).
--
--  This event is raised for any database permission 
--  change (GDR) for any database in the server. 
--  Equivalent to the Audit Database Scope GDR Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_PERMISSION_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Create and record audit logs for CRUD of
--  database principals at the server level
-- Notes:
--  This event is raised when principals, 
--  such as users, are created, altered, or 
--  dropped from a database. Equivalent to the 
--  Audit Database Principal Management Event Class. 
--  (Also equivalent to the Audit Add DB Principal 
--  Event Class, which occurs on the deprecated 
--  sp_grantdbaccess, sp_revokedbaccess, sp_addPrincipal, 
--  and sp_dropPrincipal stored procedures.)
--
--  This event is raised whenever a database role is
--  added to or removed by using the sp_addrole, 
--  sp_droprole stored procedures. 
--  This event is raised whenever any database principals 
--  are created, altered, or dropped from any database. 
--  Equivalent to the Audit Add Role Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification   
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_PRINCIPAL_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Create and record audit logs for CRUD of
--  logins for roles at the server level
-- Notes:
--  This event is raised whenever a login is 
--  added to or removed from a database role. 
--  This event class is raised for the sp_addrolemember, 
--  sp_changegroup, and sp_droprolemember stored procedures. 
--  This event is raised on any Database role 
--  member change in any database. 
--  Equivalent to the Audit Add Member to DB Role Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification  
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Create and record audit logs for changes to
--  server principals
-- Notes:
--  This event is raised when server principals are 
--  created, altered, or dropped. 
--  Equivalent to the Audit Server Principal Management Event Class.
--
--  This event is raised when a principal issues 
--  the sp_defaultdb or sp_defaultlanguage stored 
--  procedures or ALTER LOGIN statements. 
--  Equivalent to the Audit Addlogin Event Class.
--
--  This event is raised on the sp_addlogin and 
--  sp_droplogin stored procedures. 
--  Also equivalent to the Audit Login Change Property Event Class.
--
--  This event is raised for the sp_grantlogin or 
--  sp_revokelogin stored procedures. 
--  Equivalent to the Audit Login GDR Event Class.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification 
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (DATABASE_PRINCIPAL_CHANGE_GROUP)  
    WITH (STATE=OFF);  
GO  
-- =============================================
-- Title:       Audit Specification - Create
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		
-- Type:		Database
-- Description:
--	Enable the recording of custom user-defined
--  auditable events to be written to the 
--  server audit log
-- Notes:
--  This group monitors events raised by using sp_audit_write.
-- Source:
--  https://learn.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-action-groups-and-actions?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Essential_Database_Audit_Specification 
FOR SERVER AUDIT DShield_Essential_Server_Audit  
    ADD (USER_DEFINED_AUDIT_GROUP)  
    WITH (STATE=ON);  
GO  
