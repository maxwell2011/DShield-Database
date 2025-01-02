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
		b.	Repeat for project DShield-Schema-Reference
		c.	Repeat for project DShield-Schema-Rolodex
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

-- =============================================
-- Core Schema
--  Relatively static, essentially a way to
--	keep permissions out of dbo
-- =============================================

-- =============================================
-- Core - Drop Objects
-- =============================================

-- =============================================
-- Core - Handle Schema Definition
-- =============================================

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Core')
    DROP SCHEMA [Core]
GO

CREATE SCHEMA [Core]
GO