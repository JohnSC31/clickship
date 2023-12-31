USE [master]
GO
/****** Object:  Database [DepartamentoVentas]    Script Date: 11/15/2023 11:14:34 AM ******/
CREATE DATABASE [DepartamentoVentas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DepartamentoVentas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DepartamentoVentas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DepartamentoVentas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DepartamentoVentas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DepartamentoVentas] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DepartamentoVentas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DepartamentoVentas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET ARITHABORT OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DepartamentoVentas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DepartamentoVentas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DepartamentoVentas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DepartamentoVentas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET RECOVERY FULL 
GO
ALTER DATABASE [DepartamentoVentas] SET  MULTI_USER 
GO
ALTER DATABASE [DepartamentoVentas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DepartamentoVentas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DepartamentoVentas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DepartamentoVentas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DepartamentoVentas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DepartamentoVentas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DepartamentoVentas', N'ON'
GO
ALTER DATABASE [DepartamentoVentas] SET QUERY_STORE = ON
GO
ALTER DATABASE [DepartamentoVentas] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DepartamentoVentas]
GO
/****** Object:  User [Admin General]    Script Date: 11/15/2023 11:14:34 AM ******/
CREATE USER [Admin General] FOR LOGIN [Admin General] WITH DEFAULT_SCHEMA=[Alberto]
GO
/****** Object:  DatabaseRole [JefeVentas]    Script Date: 11/15/2023 11:14:35 AM ******/
CREATE ROLE [JefeVentas]
GO
/****** Object:  DatabaseRole [FuncionarioVentas]    Script Date: 11/15/2023 11:14:35 AM ******/
CREATE ROLE [FuncionarioVentas]
GO
/****** Object:  DatabaseRole [CoordinadorTraslados]    Script Date: 11/15/2023 11:14:35 AM ******/
CREATE ROLE [CoordinadorTraslados]
GO
ALTER ROLE [db_owner] ADD MEMBER [Admin General]
GO
/****** Object:  Schema [Alberto]    Script Date: 11/15/2023 11:14:35 AM ******/
CREATE SCHEMA [Alberto]
GO
/****** Object:  Table [dbo].[BitacoraOrdenes]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraOrdenes](
	[BitacoraOrdenesID] [int] IDENTITY(1,1) NOT NULL,
	[OrdenID] [int] NOT NULL,
	[EstadoID] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_BitacoraOrdenes] PRIMARY KEY CLUSTERED 
(
	[BitacoraOrdenesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[EstadoID] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Estados] PRIMARY KEY CLUSTERED 
(
	[EstadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moneda]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moneda](
	[MonedaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Acronimo] [varchar](5) NOT NULL,
	[MonedaBase] [bit] NOT NULL,
	[Simbolo] [nchar](3) NOT NULL,
 CONSTRAINT [PK_Moneda] PRIMARY KEY CLUSTERED 
(
	[MonedaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ordenes]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordenes](
	[OrdenID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[CostoTotal] [decimal](18, 4) NOT NULL,
	[EstadoActualID] [int] NOT NULL,
	[PaisID] [int] NOT NULL,
	[Ubicacion] [geography] NOT NULL,
	[Direccion] [varchar](250) NOT NULL,
	[MonedaID] [int] NOT NULL,
 CONSTRAINT [PK_Ordenes] PRIMARY KEY CLUSTERED 
(
	[OrdenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[PaisID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[PaisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosXOrden]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosXOrden](
	[ProductoXOrdenID] [int] IDENTITY(1,1) NOT NULL,
	[OrdenID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Traslados]    Script Date: 11/15/2023 11:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traslados](
	[TrasladoID] [int] IDENTITY(1,1) NOT NULL,
	[BodegaOrigenID] [int] NOT NULL,
	[FechaSalida] [datetime] NOT NULL,
	[BodegaDestinoID] [int] NOT NULL,
	[FechaLlegada] [datetime] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[OrdenID] [int] NOT NULL,
 CONSTRAINT [PK_Traslados] PRIMARY KEY CLUSTERED 
(
	[TrasladoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BitacoraOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraOrdenes_Ordenes] FOREIGN KEY([OrdenID])
REFERENCES [dbo].[Ordenes] ([OrdenID])
GO
ALTER TABLE [dbo].[BitacoraOrdenes] CHECK CONSTRAINT [FK_BitacoraOrdenes_Ordenes]
GO
ALTER TABLE [dbo].[Ordenes]  WITH CHECK ADD  CONSTRAINT [FK_Ordenes_Estados] FOREIGN KEY([EstadoActualID])
REFERENCES [dbo].[Estados] ([EstadoID])
GO
ALTER TABLE [dbo].[Ordenes] CHECK CONSTRAINT [FK_Ordenes_Estados]
GO
ALTER TABLE [dbo].[Ordenes]  WITH CHECK ADD  CONSTRAINT [FK_Ordenes_Moneda] FOREIGN KEY([MonedaID])
REFERENCES [dbo].[Moneda] ([MonedaID])
GO
ALTER TABLE [dbo].[Ordenes] CHECK CONSTRAINT [FK_Ordenes_Moneda]
GO
ALTER TABLE [dbo].[Ordenes]  WITH CHECK ADD  CONSTRAINT [FK_Ordenes_Paises] FOREIGN KEY([PaisID])
REFERENCES [dbo].[Paises] ([PaisID])
GO
ALTER TABLE [dbo].[Ordenes] CHECK CONSTRAINT [FK_Ordenes_Paises]
GO
ALTER TABLE [dbo].[ProductosXOrden]  WITH CHECK ADD  CONSTRAINT [FK_ProductosXOrden_Ordenes] FOREIGN KEY([OrdenID])
REFERENCES [dbo].[Ordenes] ([OrdenID])
GO
ALTER TABLE [dbo].[ProductosXOrden] CHECK CONSTRAINT [FK_ProductosXOrden_Ordenes]
GO
ALTER TABLE [dbo].[Traslados]  WITH CHECK ADD  CONSTRAINT [FK_Traslados_Ordenes1] FOREIGN KEY([OrdenID])
REFERENCES [dbo].[Ordenes] ([OrdenID])
GO
ALTER TABLE [dbo].[Traslados] CHECK CONSTRAINT [FK_Traslados_Ordenes1]
GO
USE [master]
GO
ALTER DATABASE [DepartamentoVentas] SET  READ_WRITE 
GO
