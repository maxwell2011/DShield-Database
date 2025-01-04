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