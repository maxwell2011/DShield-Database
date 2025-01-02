USE [DShield]
GO
-- =============================================
-- Title:       Cowrie - Direct TcpIp Data Values
-- Author:		Curtis Dibble
-- Date:		12/14/2024
-- Schema:		Logs
-- Type:		Stored Procedure
-- Description:
--  Upsert a Cowrie Logged Direct TcpIp Data Entry (Single)
-- =============================================
CREATE PROCEDURE [Cowrie].[UpsertDirectTcpIpDataValues] @Value NVARCHAR(MAX),@ID INT OUTPUT AS
BEGIN
    SET NOCOUNT ON;
    -- Try to find existing Username
    SELECT @ID = [Id] 
    FROM [Cowrie].[EventIds] 
    WHERE [Value] = @Value;
    -- Insert if not found
    IF @ID IS NULL
    BEGIN
        INSERT INTO [Cowrie].[DirectTcpIpDataValues] ([Value]) VALUES (@Value);
        SET @ID = SCOPE_IDENTITY();
    END
END;
GO
