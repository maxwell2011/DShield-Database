USE [master]
GO
/*
	Installation Instructions
	1.	Run this script
	2.	Create a local or domain users named sans_isc_svc and grafana_svc. 
		Replace 'EXAMPLE' with either your ADSI domain name for an
		Active Directory integrated account, or local machine name 
		for a locally-bound account
		a.	Remember the passwords...
		b.	EXAMPLE\sans_isc_svc
		c.	EXAMPLE\grafana_svc
		d.	EXAMPLE can be your domain or your machine name
	3.	In order (1,2,3...n) execute the scripts in this project
		a.	Repeat for project DShield-Utilities-IPAddress
		b.	Repeat for project DShield-Utilities-Fingerprints
		c.	Repeat for project DShield-Utilities-PublicKeys
		d.	Repeat for project DShield-Utilities-SessionIds
		e.	Repeat for project DShield-Schema-Reference
		f.	Repeat for project DShield-Schema-Rolodex
		g.	Repeat for project DShield-Schema-Logs
		h.	Repeat for project DShield-Schema-Cowrie
 */
/****** Object:  Database [DShield]    Script Date: 12/4/2024 2:50:47 AM ******/
CREATE DATABASE [DShield]
	CONTAINMENT = NONE
	ON PRIMARY ( 
		NAME = N'DShield', 
		FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DShield.mdf' , 
		SIZE = 8192KB , 
		MAXSIZE = UNLIMITED, 
		FILEGROWTH = 65536KB 
	)
	LOG ON 
	( 
		NAME = N'DShield_log', 
		FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DShield_log.ldf' , 
		SIZE = 8192KB , 
		MAXSIZE = 2048GB , 
		FILEGROWTH = 65536KB 
	)
	WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
	BEGIN
		EXEC [DShield].[dbo].[sp_fulltext_database] @action = 'enable'
	END
GO

ALTER DATABASE [DShield] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DShield] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DShield] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DShield] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DShield] SET ARITHABORT OFF 
GO

ALTER DATABASE [DShield] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [DShield] SET AUTO_SHRINK ON 
GO

ALTER DATABASE [DShield] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DShield] SET CURSOR_CLOSE_ON_COMMIT ON 
GO

ALTER DATABASE [DShield] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DShield] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DShield] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DShield] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DShield] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DShield] SET  DISABLE_BROKER 
GO

ALTER DATABASE [DShield] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DShield] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DShield] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DShield] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DShield] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DShield] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DShield] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DShield] SET RECOVERY FULL 
GO

ALTER DATABASE [DShield] SET  MULTI_USER 
GO

ALTER DATABASE [DShield] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DShield] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DShield] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DShield] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DShield] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DShield] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [DShield] SET QUERY_STORE = OFF
GO

ALTER DATABASE [DShield] SET  READ_WRITE 
GO


USE [DShield]
GO
-- =============================================
-- Drop Backwards Compatible Server Roles/Schemas
-- =============================================
/*
    Source:
        https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/ownership-and-user-schema-separation?view=sql-server-ver16
    SQL Server ships with nine predefined schemas that have  
    the same names as the built-in database users and roles: 
        - db_accessadmin
        - db_backupoperator
        - db_datareader
        - db_datawriter 
        - db_ddladmin
        - db_denydatareader
        - db_denydatawriter 
        - db_owner
        - db_securityadmin
    These exist for backward compatibility. 
    The recommendation is to not use them for user objects. 
    You can drop the schemas that have the same names as the 
    fixed database roles - unless they're already in use, 
    in which case the drop-command returns an error and block 
    the drop of the used schema.
    
    If you drop these schemas from the model database, 
    they won't appear in new databases. 
    
    Schemas that contain objects can't be dropped.

    The following schemas can't be dropped:
        - dbo
        - guest
        - sys
        - INFORMATION_SCHEMA
 */
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_accessadmin')
DROP SCHEMA [db_accessadmin]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_backupoperator')
DROP SCHEMA [db_backupoperator]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datareader')
DROP SCHEMA [db_datareader]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datawriter')
DROP SCHEMA [db_datawriter]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_ddladmin')
DROP SCHEMA [db_ddladmin]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatareader')
DROP SCHEMA [db_denydatareader]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatawriter')
DROP SCHEMA [db_denydatawriter]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_owner')
DROP SCHEMA [db_owner]
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_securityadmin')
DROP SCHEMA [db_securityadmin]
GO
-- =============================================
-- Guest Account
--  Can't drop the account, but I can prevent
--  it from connecting
--  Source:
--      https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/principals-database-engine?view=sql-server-ver16
-- =============================================
REVOKE CONNECT FROM GUEST;
GO
USE [master]
GO

IF OBJECT_ID('dbo.sp_hexadecimal') IS NOT NULL
    DROP PROCEDURE dbo.sp_hexadecimal
GO
-- =============================================
-- Title:       sp_hexadecimal
-- Author:		Microsoft
-- Date:		1/3/2025
-- Database:    master
-- Schema:		dbo
-- Type:		Stored Procedure
-- Description:
--	Handles binary and hex conversions as a
--  helper method for dbo.sp_help_revlogin
-- Source:
--  https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/transfer-logins-passwords-between-instances
-- =============================================
CREATE PROCEDURE dbo.sp_hexadecimal
     @binvalue [varbinary](256)
    ,@hexvalue [nvarchar] (514) OUTPUT
AS
BEGIN
    DECLARE @i [smallint]
    DECLARE @length [smallint]
    DECLARE @hexstring [nchar](16)
    SELECT @hexvalue = N'0x'
    SELECT @i = 1
    SELECT @length = DATALENGTH(@binvalue)
    SELECT @hexstring = N'0123456789ABCDEF'
    WHILE (@i < =  @length)
    BEGIN
        DECLARE @tempint   [smallint]
        DECLARE @firstint  [smallint]
        DECLARE @secondint [smallint]
        SELECT @tempint = CONVERT([smallint], SUBSTRING(@binvalue, @i, 1))
        SELECT @firstint = FLOOR(@tempint / 16)
        SELECT @secondint = @tempint - (@firstint * 16)
        SELECT @hexvalue = @hexvalue
            + SUBSTRING(@hexstring, @firstint  + 1, 1)
            + SUBSTRING(@hexstring, @secondint + 1, 1)
        SELECT @i = @i + 1
    END
END
GO
IF OBJECT_ID('dbo.sp_help_revlogin') IS NOT NULL
    DROP PROCEDURE dbo.sp_help_revlogin
GO
-- =============================================
-- Title:       sp_help_revlogin
-- Author:		Microsoft
-- Date:		1/3/2025
-- Database:    master
-- Schema:		dbo
-- Type:		Stored Procedure
-- Description:
--	Stored procedure that will help generate 
--  necessary scripts to transfer logins and 
--  their passwords from one server to a new
--  one.
-- Help:
--  Execute the command 'EXEC sp_help_revlogin'
--  in SSMS and output results to text, and
--  in the window, a full migration script
--  will appear to migrate users, 1 for 1
--  to the new machine
-- Warning:
--  READ THE REMARKS SECTION OF THE LINK BELOW
-- Source:
--  https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/transfer-logins-passwords-between-instances
-- =============================================
CREATE PROCEDURE dbo.sp_help_revlogin
    @login_name [sysname] = NULL
AS
BEGIN
    DECLARE @name                  [sysname]
    DECLARE @type                  [nvarchar](1)
    DECLARE @hasaccess             [int]
    DECLARE @denylogin             [int]
    DECLARE @is_disabled           [int]
    DECLARE @PWD_varbinary         [varbinary](256)
    DECLARE @PWD_string            [nvarchar](514)
    DECLARE @SID_varbinary         [varbinary](85)
    DECLARE @SID_string            [nvarchar](514)
    DECLARE @tmpstr                [nvarchar](4000)
    DECLARE @is_policy_checked     [nvarchar](3)
    DECLARE @is_expiration_checked [nvarchar](3)
    DECLARE @Prefix                [nvarchar](4000)
    DECLARE @defaultdb             [sysname]
    DECLARE @defaultlanguage       [sysname]
    DECLARE @tmpstrRole            [nvarchar](4000)
    IF @login_name IS NULL
    BEGIN
        DECLARE login_curs CURSOR
        FOR
        SELECT p.[sid],p.[name],p.[type],p.is_disabled,p.default_database_name,l.hasaccess,l.denylogin,default_language_name = ISNULL(p.default_language_name,@@LANGUAGE)
        FROM sys.server_principals p
        LEFT JOIN sys.syslogins l ON l.[name] = p.[name]
        WHERE p.[type] IN ('S' /* SQL_LOGIN */,'G' /* WINDOWS_GROUP */,'U' /* WINDOWS_LOGIN */)
            AND p.[name] <> 'sa'
            AND p.[name] not like '##%'
        ORDER BY p.[name]
    END
    ELSE
        DECLARE login_curs CURSOR
        FOR
        SELECT p.[sid],p.[name],p.[type],p.is_disabled,p.default_database_name,l.hasaccess,l.denylogin,default_language_name = ISNULL(p.default_language_name,@@LANGUAGE)
        FROM sys.server_principals p
        LEFT JOIN sys.syslogins l ON l.[name] = p.[name]
        WHERE p.[type] IN ('S' /* SQL_LOGIN */,'G' /* WINDOWS_GROUP */,'U' /* WINDOWS_LOGIN */)
            AND p.[name] <> 'sa'
            AND p.[name] NOT LIKE '##%'
            AND p.[name] = @login_name
        ORDER BY p.[name]
    OPEN login_curs
    FETCH NEXT FROM login_curs INTO @SID_varbinary,@name,@type,@is_disabled,@defaultdb,@hasaccess,@denylogin,@defaultlanguage
    IF (@@fetch_status = - 1)
    BEGIN
        PRINT '/* No login(s) found for ' + QUOTENAME(@login_name) + N'. */'
        CLOSE login_curs
        DEALLOCATE login_curs
        RETURN - 1
    END
    SET @tmpstr = N'/* sp_help_revlogin script
** Generated ' + CONVERT([nvarchar], GETDATE()) + N' on ' + @@SERVERNAME + N'
*/'
    PRINT @tmpstr
    WHILE (@@fetch_status <> - 1)
    BEGIN
        IF (@@fetch_status <> - 2)
        BEGIN
            PRINT ''
            SET @tmpstr = N'/* Login ' + QUOTENAME(@name) + N' */'
            PRINT @tmpstr
            SET @tmpstr = N'IF NOT EXISTS (
    SELECT 1
    FROM sys.server_principals
    WHERE [name] = N''' + @name + N'''
    )
BEGIN'
            PRINT @tmpstr
            IF @type IN ('G','U') -- NT-authenticated Group/User
            BEGIN -- NT authenticated account/group 
                SET @tmpstr = N'    CREATE LOGIN ' + QUOTENAME(@name) + N'
    FROM WINDOWS
    WITH DEFAULT_DATABASE = ' + QUOTENAME(@defaultdb) + N'
        ,DEFAULT_LANGUAGE = ' + QUOTENAME(@defaultlanguage)
            END
            ELSE
            BEGIN -- SQL Server authentication
                -- obtain password and sid
                SET @PWD_varbinary = CAST(LOGINPROPERTY(@name, 'PasswordHash') AS [varbinary](256))
                EXEC dbo.sp_hexadecimal @PWD_varbinary, @PWD_string OUT
                EXEC dbo.sp_hexadecimal @SID_varbinary, @SID_string OUT
                -- obtain password policy state
                SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END
                FROM sys.sql_logins
                WHERE [name] = @name

                SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END
                FROM sys.sql_logins
                WHERE [name] = @name

                SET @tmpstr = NCHAR(9) + N'CREATE LOGIN ' + QUOTENAME(@name) + N'
    WITH PASSWORD = ' + @PWD_string + N' HASHED
        ,SID = ' + @SID_string + N'
        ,DEFAULT_DATABASE = ' + QUOTENAME(@defaultdb) + N'
        ,DEFAULT_LANGUAGE = ' + QUOTENAME(@defaultlanguage)

                IF @is_policy_checked IS NOT NULL
                BEGIN
                    SET @tmpstr = @tmpstr + N'
        ,CHECK_POLICY = ' + @is_policy_checked
                END

                IF @is_expiration_checked IS NOT NULL
                BEGIN
                    SET @tmpstr = @tmpstr + N'
        ,CHECK_EXPIRATION = ' + @is_expiration_checked
                END
            END
            IF (@denylogin = 1)
            BEGIN -- login is denied access
                SET @tmpstr = @tmpstr
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'DENY CONNECT SQL TO ' + QUOTENAME(@name)
            END
            ELSE IF (@hasaccess = 0)
            BEGIN -- login exists but does not have access
                SET @tmpstr = @tmpstr
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'REVOKE CONNECT SQL TO ' + QUOTENAME(@name)
            END
            IF (@is_disabled = 1)
            BEGIN -- login is disabled
                SET @tmpstr = @tmpstr
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'ALTER LOGIN ' + QUOTENAME(@name) + N' DISABLE'
            END
            SET @Prefix =
                  NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'EXEC [master].dbo.sp_addsrvrolemember @loginame = N'''
            SET @tmpstrRole = N''
            SELECT @tmpstrRole = @tmpstrRole
                + CASE WHEN sysadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''sysadmin''' ELSE '' END
                + CASE WHEN securityadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''securityadmin''' ELSE '' END
                + CASE WHEN serveradmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''serveradmin''' ELSE '' END
                + CASE WHEN setupadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''setupadmin''' ELSE '' END
                + CASE WHEN processadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''processadmin''' ELSE '' END
                + CASE WHEN diskadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''diskadmin''' ELSE '' END
                + CASE WHEN dbcreator = 1 THEN @Prefix + LoginName + N''', @rolename = N''dbcreator''' ELSE '' END
                + CASE WHEN bulkadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''bulkadmin''' ELSE '' END
            FROM (
                SELECT
                     SUSER_SNAME([sid])AS LoginName
                    ,sysadmin
                    ,securityadmin
                    ,serveradmin
                    ,setupadmin
                    ,processadmin
                    ,diskadmin
                    ,dbcreator
                    ,bulkadmin
                FROM sys.syslogins
                WHERE (    sysadmin <> 0
                        OR securityadmin <> 0
                        OR serveradmin <> 0
                        OR setupadmin <> 0
                        OR processadmin <> 0
                        OR diskadmin <> 0
                        OR dbcreator <> 0
                        OR bulkadmin <> 0
                        )
                    AND [name] = @name
                ) L
            IF @tmpstr <> '' PRINT @tmpstr
            IF @tmpstrRole <> '' PRINT @tmpstrRole
            PRINT 'END'
        END
        FETCH NEXT FROM login_curs INTO @SID_varbinary,@name,@type,@is_disabled,@defaultdb,@hasaccess,@denylogin,@defaultlanguage
    END
    CLOSE login_curs
    DEALLOCATE login_curs
    RETURN 0
END
GO
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

USE [DShield]
GO

-- =============================================
-- Core Schema
--  Long tail, update only 
--  destination of many FK constraints
-- =============================================


IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Core')
    DROP SCHEMA [Core]
GO

CREATE SCHEMA [Core]
GO



-- =============================================
-- Title:       Login - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a login for the SANS ISC Service 
--	Account using a Windows user
-- ============================================= 
CREATE LOGIN [EXAMPLE\sans_isc_svc] FROM WINDOWS WITH DEFAULT_DATABASE = DShield
GO
-- =============================================
-- Title:       User - Create
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Service Account
-- Description:
--	Create a user for login using the SANS ISC 
--	Service Account from a Windows user. Assign
--	default Schema as 'Core'
-- ============================================= 
CREATE USER [EXAMPLE\sans_isc_svc]
	FOR LOGIN [EXAMPLE\sans_isc_svc]
	WITH DEFAULT_SCHEMA = [Core]
GO
USE [DShield]
GO

-- =============================================
-- Core - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreManager' AND 
		type = 'R'
		)
	CREATE ROLE [CoreManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreWriter' AND 
		type = 'R'
		)
	CREATE ROLE [CoreWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [CoreExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [CoreReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Core
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'CoreReader' AND 
		type = 'R'
		)
	CREATE ROLE [CoreReader] 
	AUTHORIZATION db_securityadmin;
GO







-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
--	Add SANS ISC Service Account to CoreReader 
--	role with Read Permissions on Core Schema
-- =============================================
ALTER ROLE [CoreReader]
ADD MEMBER [EXAMPLE\sans_isc_svc]
GO




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



USE [DShield]
GO

-- =============================================
-- Permissions - Drop Views
-- =============================================
IF OBJECT_ID('[Permissions].[GuestUser]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[GuestUser]
GO

IF OBJECT_ID('[Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[UsersWithConnect]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithConnect]
GO

IF OBJECT_ID('[Permissions].[RolesWithConnect]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithConnect]
GO

IF OBJECT_ID('[Permissions].[UsersWithViewAnyColumnMasterKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[UsersWithViewAnyColumnMasterKeyDefinition]
GO

IF OBJECT_ID('[Permissions].[RolesWithViewAnyColumnMasterKeyDefinition]', 'V') IS NOT NULL
    DROP VIEW [Permissions].[RolesWithViewAnyColumnMasterKeyDefinition]
GO
-- =============================================
-- Permissions Schema
--  Database permissions management utilities
-- =============================================
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Permissions')
    DROP SCHEMA [Permissions]
GO

CREATE SCHEMA [Permissions]
GO

USE [DShield]
GO
-- =============================================
-- Permissions - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsManager' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsWriter' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [PermissionsReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'PermissionsReader' AND 
		type = 'R'
		)
	CREATE ROLE [PermissionsReader] 
	AUTHORIZATION db_securityadmin;
GO
USE [DShield]
GO

-- =============================================
-- DShield Permissions Schema Audit
--  Drops the Permissions Schema audit objects
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Permissions
-- Type:		Database
-- Description:
--	Create and record audit logs for UPDATE, DELETE  
--  statements on the Permissions Schema by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (UPDATE, DELETE ON SCHEMA::[Permissions] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
USE [DShield]
GO

-- =============================================
-- Utility - Drop Views
-- =============================================
IF OBJECT_ID('[Utility].[OrphanedUsers]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OrphanedUsers]
GO
IF OBJECT_ID('[Utility].[OutOfMemoryErrors701]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OutOfMemoryErrors701]
GO
IF OBJECT_ID('[Utility].[VirtualMemoryUsage]', 'V') IS NOT NULL
    DROP VIEW [Utility].[VirtualMemoryUsage]
GO
IF OBJECT_ID('[Utility].[ExistingSessions]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ExistingSessions]
GO
IF OBJECT_ID('[Utility].[ProgramIOActivity]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ProgramIOActivity]
GO
IF OBJECT_ID('[Utility].[SystemMemoryConsumers]', 'V') IS NOT NULL
    DROP VIEW [Utility].[SystemMemoryConsumers]
GO
IF OBJECT_ID('[Utility].[SchemaManagerEntriesCount]', 'V') IS NOT NULL
    DROP VIEW [Utility].[SchemaManagerEntriesCount]
GO
IF OBJECT_ID('[Utility].[HighCPUQueries]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueries]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesHistorical]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesHistorical]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesMissingIndexes]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesMissingIndexes]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesFrequentExecution]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesFrequentExecution]
GO
IF OBJECT_ID('[Utility].[HighCPUQueriesSuggestIndexFixes]', 'V') IS NOT NULL
    DROP VIEW [Utility].[HighCPUQueriesSuggestIndexFixes]
GO
IF OBJECT_ID('[Utility].[ProfilerTraceSummary]', 'V') IS NOT NULL
    DROP VIEW [Utility].[ProfilerTraceSummary]
GO
IF OBJECT_ID('[Utility].[TraceEventDetails]', 'V') IS NOT NULL
    DROP VIEW [Utility].[TraceEventDetails]
GO
IF OBJECT_ID('[Utility].[XEventSessionDetails]', 'V') IS NOT NULL
    DROP VIEW [Utility].[XEventSessionDetails]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesDebug]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesDebug]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPatched]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPatched]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPreRelease]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPreRelease]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesPrivateBuilds]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesPrivateBuilds]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesSpecialBuilds]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesSpecialBuilds]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesThirdParty]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesThirdParty]
GO
IF OBJECT_ID('[Utility].[OsLoadedModulesNonEnglish]', 'V') IS NOT NULL
    DROP VIEW [Utility].[OsLoadedModulesNonEnglish]
GO
-- =============================================
-- Utility Schema
--  Database management utilities
-- =============================================
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Utility')
    DROP SCHEMA [Utility]
GO

CREATE SCHEMA [Utility]
GO

USE [DShield]
GO

-- =============================================
-- Utility - Handle Roles
-- =============================================

-- =============================================
-- Title:       Drop Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Manager Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityManager' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityManager];
GO
-- =============================================
-- Title:       Create Role - Manager
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Manager Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityManager' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityManager] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Writer Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityWriter' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityWriter];
GO
-- =============================================
-- Title:       Create Role - Writer
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Writer Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityWriter' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityWriter] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Executor Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityExecutor' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityExecutor];
GO
-- =============================================
-- Title:       Create Role - Executor
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Executor Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityExecutor' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityExecutor] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Drop Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Drop Reader Role
-- =============================================
IF EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityReader' AND 
		type = 'R'
		)
	EXEC sp_droprole [UtilityReader];
GO
-- =============================================
-- Title:       Create Role - Reader
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Role
-- Description:
--	Create Reader Role
-- =============================================
IF NOT EXISTS (
	SELECT * FROM sys.database_principals 
	WHERE 
		name = N'UtilityReader' AND 
		type = 'R'
		)
	CREATE ROLE [UtilityReader] 
	AUTHORIZATION db_securityadmin;
GO

-- =============================================
-- Title:       Permissions - Read
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Utility
-- Type:		Permission
-- Description:
-- Description:
--	Add SANS ISC Service Account to UtilityReader 
--	role with Read Permissions on Utility Schemas
-- =============================================
ALTER ROLE [UtilityReader]
ADD MEMBER [EXAMPLE\sans_isc_svc]
GO
USE [DShield]
GO

-- =============================================
-- Title:       Errors - Out Of Memory (#701) 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	After you enable the memory-optimized 
--	tempdb metadata (HkTempDB) feature, you may 
--	see the error 701 indicating out of memory 
--	exceptions for tempdb allocations and 
--	SQL Server Service crashes. In addition, 
--	you may see that the memory clerk MEMORYCLERK_XTP 
--	for In-Memory OLTP (Hekaton) is growing 
--	gradually or rapidly and doesn't shrink back. 
--	As the XTP memory grows without an upper limit, 
--	you see the following error message in SQL Server:
--
--		Disallowing page allocations for database 
--		'tempdb' due to insufficient memory in 
--		the resource pool 'default'. 
--		See 'http://go.microsoft.com/fwlink/?LinkId=510837' 
--		for more information.
--
--	When you run a query on the DMV dm_os_memory_clerks, 
--	you can see that pages memory allocated is 
--	high for memory clerk MEMORYCLERK_XTP. 
-- Note:
--	Further Instructions for resolving issues
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/memory-optimized-tempdb-out-of-memory
-- =============================================
CREATE VIEW [Utility].[OutOfMemoryErrors701] AS
	SELECT 
		name, 
		type, 
		memory_node_id, 
		pages_kb 
	FROM sys.dm_os_memory_clerks
	WHERE type = 'MEMORYCLERK_XTP' 
GO

-- =============================================
-- Title:       Errors - Schema Manager Entries
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Get the number of Schema Manager Entries
--	currently in the database, used for
--	troubleshooting out of memory error.
--	see source link.
-- Note:
--	Further Instructions for resolving issues
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/schemamgr-store-degrades-performance
-- =============================================
CREATE VIEW [Utility].[SchemaManagerEntriesCount] AS
	SELECT 
		entries_count AS [Entries]
	FROM sys.dm_os_memory_cache_counters
	WHERE name = 'SchemaMgr Store'
GO

-- =============================================
-- Title:       Virtual Memory - Usage 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check virtual memory commitments and 
--	reservations
-- =============================================
CREATE VIEW [Utility].[VirtualMemoryUsage] AS
	SELECT 
		name, 
		type, 
		virtual_memory_reserved_kb, 
		virtual_memory_committed_kb
	FROM sys.dm_os_memory_clerks
	WHERE 
		virtual_memory_reserved_kb != 0 OR 
		virtual_memory_committed_kb != 0
GO

-- =============================================
-- Title:       CPU - Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve a top 10 list of queries currently
--	running that are using the most CPU time
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueries] AS
	SELECT TOP 10 
		s.session_id,
        r.status,
        r.cpu_time,
        r.logical_reads,
        r.reads,
        r.writes,
        r.total_elapsed_time / (1000 * 60) 'Elaps M',
        SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
        ((CASE r.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.TEXT)
            ELSE r.statement_end_offset
        END - r.statement_start_offset) / 2) + 1) AS statement_text,
        COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
        + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
        r.command,
        s.login_name,
        s.host_name,
        s.program_name,
        s.last_request_end_time,
        s.login_time,
        r.open_transaction_count
	FROM sys.dm_exec_sessions AS s
	JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
	WHERE r.session_id != @@SPID
--ORDER BY r.cpu_time DESC
GO

-- =============================================
-- Title:       CPU - Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve a top 10 list of Historical queries
--	that used the most CPU time
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesHistorical] AS
	SELECT TOP 10  
		qs.last_execution_time, 
		st.text AS batch_text,
		SUBSTRING(
			st.TEXT, 
			(qs.statement_start_offset / 2) + 1, 
			(
				(
					CASE qs.statement_end_offset 
					WHEN - 1 
					THEN DATALENGTH(st.TEXT) 
					ELSE qs.statement_end_offset 
					END - qs.statement_start_offset
				) / 2
			) + 1) AS statement_text,
		(qs.total_worker_time / 1000) / qs.execution_count AS avg_cpu_time_ms,
		(qs.total_elapsed_time / 1000) / qs.execution_count AS avg_elapsed_time_ms,
		qs.total_logical_reads / qs.execution_count AS avg_logical_reads,
		(qs.total_worker_time / 1000) AS cumulative_cpu_time_all_executions_ms,
		(qs.total_elapsed_time / 1000) AS cumulative_elapsed_time_all_executions_ms
	FROM sys.dm_exec_query_stats qs
	CROSS APPLY sys.dm_exec_sql_text(sql_handle) st
	--ORDER BY(qs.total_worker_time / qs.execution_count) DESC
GO

-- =============================================
-- Title:       CPU - Show Missing Indexes
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	View to identify queries that cause high CPU 
--	usage and that contain at least one missing 
--	index in the query plan
--	Captures the Total CPU time spent by a query 
--	along with the query plan and total executions
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesMissingIndexes] AS
	SELECT
		qs_cpu.total_worker_time / 1000 AS total_cpu_time_ms,
		q.[text],
		p.query_plan,
		qs_cpu.execution_count,
		q.dbid,
		q.objectid,
		q.encrypted AS text_encrypted
	FROM
	(
		SELECT TOP 500 
			qs.plan_handle,
			qs.total_worker_time,
			qs.execution_count 
		FROM sys.dm_exec_query_stats qs 
		ORDER BY qs.total_worker_time DESC
	) AS qs_cpu
	CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
	CROSS APPLY sys.dm_exec_query_plan(plan_handle) p
	WHERE p.query_plan.exist('declare namespace 
		qplan = "http://schemas.microsoft.com/sqlserver/2004/07/showplan";
		//qplan:MissingIndexes')=1
GO

-- =============================================
-- Title:       CPU - Frequent Expensive Queries 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Retrieve queries where Max and average CPU 
--	time exceeds 200 ms and executed more than 
--	1000 times
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesFrequentExecution] AS
	SELECT 
		qs.total_worker_time/1000 AS total_cpu_time_ms,
		qs.max_worker_time/1000 AS max_cpu_time_ms,
		(qs.total_worker_time/1000)/execution_count AS average_cpu_time_ms,
		qs.execution_count,
		q.[text]
	FROM sys.dm_exec_query_stats qs 
	CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
	WHERE (
		qs.total_worker_time/execution_count > 200*1000 OR 
		qs.max_worker_time > 200*1000 
		) AND execution_count > 1000
	--ORDER BY  qs.total_worker_time DESC 
GO

-- =============================================
-- Title:       CPU - Suggest Missing Indexes
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	check for missing indexes and apply any 
--	recommended indexes that have high improvement 
--	measure values. Start with the top 5 or 10 
--	recommendations from the output that have the 
--	highest improvement_measure value. Those 
--	indexes have the most significant positive 
--	effect on performance. Decide whether you 
--	want to apply these indexes and make sure 
--	that performance testing is done for the 
--	application. 
--	Then, continue to apply missing-index 
--	recommendations until you achieve the desired 
--	application performance results.
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[HighCPUQueriesSuggestIndexFixes] AS
	SELECT 
		CONVERT(VARCHAR(30), GETDATE(), 126) AS runtime,
		mig.index_group_handle,
		mid.index_handle,
		CONVERT(
			DECIMAL(28, 1), 
			migs.avg_total_user_cost * 
			migs.avg_user_impact * 
			(migs.user_seeks + migs.user_scans)
		) AS improvement_measure,
		'CREATE INDEX missing_index_' + 
		CONVERT(VARCHAR, mig.index_group_handle) + '_' + 
		CONVERT(VARCHAR, mid.index_handle) + ' ON ' + 
		mid.statement + 
		' (' + ISNULL(mid.equality_columns,'') + 
			CASE 
				WHEN mid.equality_columns IS NOT NULL AND 
					mid.inequality_columns IS NOT NULL 
				THEN ','
				ELSE ''
			END + 
			ISNULL(mid.inequality_columns, '') + 
		')' + 
		ISNULL(' INCLUDE (' + mid.included_columns + ')','') AS create_index_statement,
		migs.*,
		mid.database_id,
		mid.[object_id]
	FROM sys.dm_db_missing_index_groups mig
	INNER JOIN sys.dm_db_missing_index_group_stats migs 
		ON migs.group_handle = mig.index_group_handle
	INNER JOIN sys.dm_db_missing_index_details mid 
		ON mig.index_handle = mid.index_handle
	WHERE CONVERT (DECIMAL (28, 1),
               migs.avg_total_user_cost * 
			   migs.avg_user_impact * 
			   (migs.user_seeks + migs.user_scans)
			) > 10
	--ORDER BY 
		--migs.avg_total_user_cost * 
		--migs.avg_user_impact * 
		--(migs.user_seeks + migs.user_scans) DESC
GO

-- =============================================
-- Title:       Tracing - Profiler Trace Summary
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with this Profiler
--	Tracer Summary. Helps with identifying active 
--	XEvent or Server traces
-- Related:
--	[Utility].[TraceEventDetails] and 
--	[Utility].[XEventSessionDetails]
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[ProfilerTraceSummary] AS
	SELECT 
		traceid, 
		property, 
		CONVERT(VARCHAR(1024), value) AS value 
	FROM::fn_trace_getinfo(default)
GO


-- =============================================
-- Title:       Tracing - Trace Event Details
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with the details
--	related to the Profiler Tracer Summary. 
--	Helps with identifying active XEvent or 
--	Server traces
-- Related:
--	[Utility].[ProfilerTraceSummary] and 
--	[Utility].[XEventSessionDetails]
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[TraceEventDetails] AS
	SELECT 
		trace_id,
		status,
		CASE WHEN row_number = 1 THEN path ELSE NULL end AS path,
		CASE WHEN row_number = 1 THEN max_size ELSE NULL end AS max_size,
		CASE WHEN row_number = 1 THEN start_time ELSE NULL end AS start_time,
		CASE WHEN row_number = 1 THEN stop_time ELSE NULL end AS stop_time,
		max_files,
		is_rowset,
		is_rollover,
		is_shutdown,
		is_default,
		buffer_count,
		buffer_size,
		last_event_time,
		event_count,
		trace_event_id,
		trace_event_name,
		trace_column_id,
		trace_column_name,
		expensive_event
	FROM (
		SELECT 
			t.id AS trace_id, 
			row_number() 
			OVER (
				PARTITION BY t.id 
				ORDER BY 
					te.trace_event_id, 
					tc.trace_column_id
				) AS row_number,
				t.status,
				t.path,
				t.max_size,
				t.start_time,
				t.stop_time,
				t.max_files,
				t.is_rowset,
				t.is_rollover,
				t.is_shutdown,
				t.is_default,
				t.buffer_count,
				t.buffer_size,
				t.last_event_time,
				t.event_count,
				te.trace_event_id,
				te.name AS trace_event_name,
				tc.trace_column_id,
				tc.name AS trace_column_name,
				CASE 
				WHEN te.trace_event_id IN (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
				THEN CAST(1 as bit) ELSE CAST(0 AS BIT) 
			END AS expensive_event 
		FROM sys.traces t 
		CROSS APPLY::fn_trace_geteventinfo(t.id) AS e 
		JOIN sys.trace_events te 
			ON te.trace_event_id = e.eventid 
		JOIN sys.trace_columns tc 
			ON e.columnid = trace_column_id
		) AS x
GO
-- =============================================
-- Title:       Tracing - XEvent Session Details
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check for SQL Trace or XEvent tracing that 
--	affects the performance of SQL Server and 
--	causes high CPU usage with the details
--	related to the Profiler Tracer Summary. 
--	Helps with identifying active XEvent or 
--	Server traces
-- Related:
--	[Utility].[ProfilerTraceSummary] and 
--	[Utility].[TraceEventDetails] 
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues
-- =============================================
CREATE VIEW [Utility].[XEventSessionDetails] AS
	SELECT 
		sess.NAME 'session_name', 
		event_name, 
		xe_event_name, 
		trace_event_id,
		CASE 
			WHEN xemap.trace_event_id IN (23, 24, 40, 41, 44, 45, 51, 52, 54, 68, 96, 97, 98, 113, 114, 122, 146, 180) 
			THEN Cast(1 AS BIT)
			ELSE Cast(0 AS BIT)
		END AS expensive_event
	FROM sys.dm_xe_sessions sess
	JOIN sys.dm_xe_session_events evt
		ON sess.address = evt.event_session_address
	INNER JOIN sys.trace_xe_event_map xemap
		ON evt.event_name = xemap.xe_event_name
GO

-- =============================================
-- Title:       Sessions - Existing 
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check sessions and basic logged on details
-- =============================================
CREATE VIEW [Utility].[ExistingSessions] AS
	SELECT 
		session_id,
		login_time,
		host_name,
		program_name,
		status,
		nt_domain,
		nt_user_name,
		cpu_time,
		database_id,
		authenticating_database_id
	FROM sys.dm_exec_sessions 
	WHERE program_name IS NOT NULL
GO

-- =============================================
-- Title:       I/O - Utilization
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check read/write and IO stats for database
-- =============================================
CREATE VIEW [Utility].[ProgramIOActivity] AS
	SELECT 
		session_id,
		database_id,
		program_name,
		last_request_start_time,
		last_request_end_time,
		reads,
		writes,
		logical_reads
	FROM sys.dm_exec_sessions 
	WHERE 
		reads > 0 OR 
		writes > 0 OR 
		logical_reads > 0
GO

-- =============================================
-- Title:       Memory - System Consumers
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check what's using up all the memory
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/performance/memory-optimized-tempdb-out-of-memory
-- =============================================
CREATE VIEW [Utility].[SystemMemoryConsumers] AS
	SELECT 
		memory_consumer_type_desc, 
		memory_consumer_desc, 
		allocated_bytes, 
		used_bytes
	FROM sys.dm_xtp_system_memory_consumers 
GO

-- =============================================
-- Title:       OS Loaded Modules - Debug
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with Debug flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesDebug] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE debug = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Patched
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with Patched flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPatched] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE patched = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Pre-Release
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with PreRelease flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPreRelease] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE prerelease = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Private Build
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with PrivateBuild flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesPrivateBuilds] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE private_build = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - Special Build
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules with SpecialBuild flag set
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesSpecialBuilds] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE special_build = 1
GO

-- =============================================
-- Title:       OS Loaded Modules - 3rd Party
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules that are not from Microsoft
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesThirdParty] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE 
	company != 'Microsoft Corporation' AND
	language = 67699888
GO

-- =============================================
-- Title:       OS Loaded Modules - Non-English
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Check Loaded Modules that are not English Based
-- =============================================
CREATE VIEW [Utility].[OsLoadedModulesNonEnglish] AS
SELECT 
	company,
	name,
	product_version,
	file_version,
	description,
	language
FROM sys.dm_os_loaded_modules
WHERE language != 67699888
GO
USE [DShield]
GO

-- =============================================
-- Title:       Users - Orphaned
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Utility
-- Type:		View
-- Description:
--	Detect and display orphaned users in the
--	local database
-- Note:
--	Instructions for resolving orphaned users
--	can be found at the link below
-- Source:
--	https://learn.microsoft.com/en-us/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server?view=sql-server-ver16
-- =============================================
CREATE VIEW [Utility].[OrphanedUsers] AS
	SELECT 
		dp.type_desc, 
		dp.sid, 
		dp.name AS user_name  
	FROM sys.database_principals AS dp  
		LEFT JOIN sys.server_principals AS sp 
			ON dp.sid = sp.sid  
	WHERE 
		sp.sid IS NULL AND 
		dp.authentication_type_desc = 'INSTANCE';  
GO





-- =============================================
-- Title:       Users - Guest User
-- Author:		Microsoft
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Detect if guest user is enabled and
--	configured in the current database
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[GuestUser] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.name = 'guest' AND 
		perms.permission_name = 'CONNECT';

GO

-- =============================================
-- Title:       Users - View Column Encryption
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to view any column
--	encryption key definition. Or, which users in the 
--	current scope possess the VWCK permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithViewAnyColumnEncryptionKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type IN ('U','S') AND
		perms.permission_name = 'VIEW ANY COLUMN ENCRYPTION KEY DEFINITION';
GO

-- =============================================
-- Title:       Roles - View Column Encryption
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to view any column
--	encryption key definition. Or, which roles in the 
--	current scope possess the VWCK permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithViewAnyColumnEncryptionKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN ENCRYPTION KEY DEFINITION';
GO

-- =============================================
-- Title:       Users - Connect
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to connect. 
--	Or, which users in the current scope
--	possess the CO permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithConnect] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type IN ('U','S') AND
		perms.permission_name = 'CONNECT';
GO

-- =============================================
-- Title:       Roles - Connect
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to connect. 
--	Or, which roles in the current scope
--	possess the CO permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithConnect] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'CONNECT';
GO

-- =============================================
-- Title:       Users - View Column Master
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which users are allowed to view any column
--	master key definition. Or, which users in the 
--	current scope possess the VWCM permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[UsersWithViewAnyColumnMasterKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN MASTER KEY DEFINITION';
GO

-- =============================================
-- Title:       Roles - View Column Master
--							Key Definition (Any)
-- Author:		Curtis Dibble
-- Date:		1/3/2025
-- Schema:		Permissions
-- Type:		View
-- Description:
--	Display which roles are allowed to view any column
--	master key definition. Or, which roles in the 
--	current scope possess the VWCM permission type
-- Source:
--	https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/security/error-disable-guest-user
-- =============================================
CREATE VIEW [Permissions].[RolesWithViewAnyColumnMasterKeyDefinition] AS
	SELECT
		prins.name AS grantee_name, 
		perms.class,
		perms.class_desc,
		perms.major_id,
		perms.minor_id,
		perms.grantee_principal_id,
		perms.grantor_principal_id,
		perms.type,
		perms.permission_name,
		perms.state,
		perms.state_desc
	FROM sys.database_permissions AS perms
		JOIN sys.database_principals AS prins ON perms.grantee_principal_id = prins.principal_id
	WHERE 
		prins.type = 'R' AND
		perms.permission_name = 'VIEW ANY COLUMN MASTER KEY DEFINITION';
GO


USE [DShield]
GO

-- =============================================
-- DShield Utility Schema Audit
--  Drops the Utility Schema audit objects
-- =============================================
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=OFF);
GO

-- =============================================
-- Title:       Audit Specification - Modify
-- Author:		Curtis Dibble
-- Date:		1/4/2025
-- Schema:		Utility
-- Type:		Database
-- Description:
--	Create and record audit logs for UPDATE, DELETE  
--  statements on the Utility Schema by PUBLIC
-- Notes:
-- Source:
--  https://learn.microsoft.com/en-us/sql/t-sql/statements/create-database-audit-specification-transact-sql?view=sql-server-ver16
-- ============================================= 
ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  
FOR SERVER AUDIT DShield_Activity_Server_Audit  
    ADD (UPDATE, DELETE ON SCHEMA::[Utility] BY PUBLIC)  
    WITH (STATE=ON);   
GO  

ALTER DATABASE AUDIT SPECIFICATION DShield_Database_Activity_Audit_Specification  WITH (STATE=ON);
GO
