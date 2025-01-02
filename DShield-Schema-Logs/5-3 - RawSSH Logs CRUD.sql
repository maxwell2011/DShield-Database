USE [DShield]
GO
-- =============================================
-- Title:       Logs - Insert RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Insert RawSSH Logs (Single)
-- =============================================
CREATE PROCEDURE [Logs].[InsertRawSSHLogs]
    @Date DATE,
    @Time TIME,
    @Source VARCHAR(45),
    @Username NVARCHAR(255),
    @Password NVARCHAR(255)
AS BEGIN
    SET NOCOUNT ON;
    DECLARE @SourceID BIGINT;
    DECLARE @UsernameID INT;
    DECLARE @PasswordID INT;
    DECLARE @LogTimestamp datetime2(7);    
    SET @LogTimestamp = CAST(
        CAST(@Time AS binary(6)) + 
        CAST(@Date AS binary(3)) 
        AS DATETIME2(7)
    );
    EXEC [IPAddresses].[UpsertIP] @Source, @SourceID OUTPUT;
    EXEC [Rolodex].[UpsertUsername] @Username, @UsernameID OUTPUT;
    EXEC [Rolodex].[UpsertPassword] @Password, @PasswordID OUTPUT;
    INSERT INTO [Logs].[RawSSH] (
        [LogTimestamp],
        [SourceID],
        [UsernameID],
        [PasswordID]
    )
    VALUES (
        @LogTimestamp,
        @SourceID,
        @UsernameID,
        @PasswordID
    );
END;
GO

-- =============================================
-- Title:       Logs - Get RawSSH Logs
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Get Raw SSH Logs (All)
-- =============================================
CREATE PROCEDURE [Logs].[GetRawSSHLogs]
AS BEGIN
    SELECT 
        FORMAT(rs.[LogTimestamp], 'yyyy-MM-dd') as [Date],
        FORMAT(rs.[LogTimestamp], 'HH:mm:ss.fffffff') as [Time],
        [Rolodex].[IPToString](addr.[Value]) as [Source],
        un.[Value] AS [Username],
        pw.[Value] AS [Password]
    FROM [Logs].[RawSSH] rs
    JOIN [IPAddress].[Addresses] addr ON rs.[SourceID] = addr.[Id]
    JOIN [Rolodex].[Usernames] un ON rs.[UsernameID] = un.[Id]
    JOIN [Rolodex].[Passwords] pw ON rs.[PasswordID] = pw.[Id];
END;
GO