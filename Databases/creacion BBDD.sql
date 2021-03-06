USE [master]
GO
/****** Object:  Database [BBDD Final]    Script Date: 5/7/2020 20:31:50 ******/
CREATE DATABASE [BBDD Final]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BBDD Final', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BBDD Final.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BBDD Final_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BBDD Final_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BBDD Final] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BBDD Final].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BBDD Final] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BBDD Final] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BBDD Final] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BBDD Final] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BBDD Final] SET ARITHABORT OFF 
GO
ALTER DATABASE [BBDD Final] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BBDD Final] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BBDD Final] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BBDD Final] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BBDD Final] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BBDD Final] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BBDD Final] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BBDD Final] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BBDD Final] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BBDD Final] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BBDD Final] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BBDD Final] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BBDD Final] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BBDD Final] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BBDD Final] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BBDD Final] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BBDD Final] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BBDD Final] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BBDD Final] SET  MULTI_USER 
GO
ALTER DATABASE [BBDD Final] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BBDD Final] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BBDD Final] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BBDD Final] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BBDD Final] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BBDD Final] SET QUERY_STORE = OFF
GO
USE [BBDD Final]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCantidadSiniestros]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetCantidadSiniestros] (@CodigoAsegurado numeric)
returns numeric
as
begin
	declare @CantidadSiniestro numeric;

	select @CantidadSiniestro = Cantidad_siniestros from Asegurados where Asegurados.Codigo= @CodigoAsegurado

	return @CantidadSiniestro;
end;
GO
/****** Object:  UserDefinedFunction [dbo].[GetCodAsegurado]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetCodAsegurado] (@dni numeric)
returns numeric
as
begin
	declare @codigo numeric;

	select @codigo = Codigo from dbo.Asegurados where Asegurados.Nro_docimento =@dni

	if @codigo is null
	begin
		select @codigo = -1
	end

	return @codigo
end;

GO
/****** Object:  UserDefinedFunction [dbo].[GetPolizasByProductor]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[GetPolizasByProductor] (@codigo_productor numeric)
returns numeric
as
begin
declare @cantidad_polizas numeric

if not exists(SELECT Productores.Codigo FROM Productores WHERE Productores.Codigo = @codigo_productor) 
begin
	set @cantidad_polizas =-1
end
else
begin

	

	select @cantidad_polizas = count(Nro_poliza) from Polizas 
	where Productor in (select * from dbo.GetJefes(@codigo_productor)) or Productor=@codigo_productor and
	Getdate() between fecha_vigencia_desde and
	fecha_vigencia_hasta  and estado_poliza=1.
end
	return @cantidad_polizas
end

GO
/****** Object:  UserDefinedFunction [dbo].[verificarVencida]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[verificarVencida] (@numeroPoliza numeric)
returns bit
as
begin
	declare @vencida bit;

	if getDate() > (select Fecha_vigencia_hasta from dbo.Polizas where Nro_poliza = @numeroPoliza) 
	begin
	set @vencida=1
	end
	else
	begin
	set @vencida=0
	end
	

	return @vencida
end;

GO
/****** Object:  Table [dbo].[Productores]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productores](
	[Codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Productor,Jefe] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Productores] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetJefes]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetJefes] (@cod_productor numeric)
returns table 
as
return
	select Codigo from Productores where [Productor,Jefe] = @cod_productor
GO
/****** Object:  Table [dbo].[Asegurados]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asegurados](
	[Codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Apellido] [nvarchar](100) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Fecha_nacimiento] [date] NOT NULL,
	[Nro_docimento] [numeric](8, 0) NOT NULL,
	[Cantidad_polizas] [numeric](18, 0) NOT NULL,
	[Cantidad_siniestros] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Asegurados] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Polizas]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polizas](
	[Nro_poliza] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Codigo_seccion] [numeric](18, 0) NOT NULL,
	[Codigo_asegurado] [numeric](18, 0) NOT NULL,
	[Estado_poliza] [numeric](18, 0) NOT NULL,
	[Fecha_emision] [date] NOT NULL,
	[Fecha_vigencia_desde] [date] NOT NULL,
	[Fecha_vigencia_hasta] [date] NOT NULL,
	[Suma_asegurada] [numeric](18, 0) NOT NULL,
	[Productor] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Polizas] PRIMARY KEY CLUSTERED 
(
	[Nro_poliza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Secciones]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Secciones](
	[Codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NULL,
 CONSTRAINT [PK_Secciones] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Polizas]  WITH CHECK ADD  CONSTRAINT [FK_Polizas_Asegurados] FOREIGN KEY([Codigo_asegurado])
REFERENCES [dbo].[Asegurados] ([Codigo])
GO
ALTER TABLE [dbo].[Polizas] CHECK CONSTRAINT [FK_Polizas_Asegurados]
GO
ALTER TABLE [dbo].[Polizas]  WITH CHECK ADD  CONSTRAINT [FK_Polizas_Productores] FOREIGN KEY([Productor])
REFERENCES [dbo].[Productores] ([Codigo])
GO
ALTER TABLE [dbo].[Polizas] CHECK CONSTRAINT [FK_Polizas_Productores]
GO
ALTER TABLE [dbo].[Polizas]  WITH CHECK ADD  CONSTRAINT [FK_Polizas_Secciones] FOREIGN KEY([Codigo_seccion])
REFERENCES [dbo].[Secciones] ([Codigo])
GO
ALTER TABLE [dbo].[Polizas] CHECK CONSTRAINT [FK_Polizas_Secciones]
GO
ALTER TABLE [dbo].[Productores]  WITH CHECK ADD  CONSTRAINT [FK_Productores_Productores] FOREIGN KEY([Productor,Jefe])
REFERENCES [dbo].[Productores] ([Codigo])
GO
ALTER TABLE [dbo].[Productores] CHECK CONSTRAINT [FK_Productores_Productores]
GO
ALTER TABLE [dbo].[Secciones]  WITH CHECK ADD  CONSTRAINT [CK_Secciones] CHECK  (([Nombre]='Automotores' OR [Nombre]='Hogar' OR [Nombre]='Accidentes Personales'))
GO
ALTER TABLE [dbo].[Secciones] CHECK CONSTRAINT [CK_Secciones]
GO
/****** Object:  StoredProcedure [dbo].[Emitir_Poliza]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Emitir_Poliza]
@codSeccion numeric, @apellido nvarchar(100), @nombre nvarchar(100), @fechaNac date, @dni numeric, @VigenciaDesde date, @productor numeric
as
begin
	begin transaction;
		begin try
			declare @CodAseg numeric;
			select @CodAseg = dbo.GetCodAsegurado(@dni)
			declare @error bit;
			select @error = 0;

			if @CodAseg = -1
			begin
				select 'El asegurado no existe'
				select @error=1
			end
			 if dbo.GetCantidadSiniestros(@CodAseg) >0
				begin
					select 'El asegurado posee un siniestro'
					select @error=1
				end

		if @error = 0
			begin
				insert into Polizas(Codigo_seccion, Codigo_asegurado, Estado_poliza, Fecha_emision, Fecha_vigencia_desde,Fecha_vigencia_hasta, Suma_asegurada, Productor ) values
				(@codSeccion
				,@CodAseg
				,1
				,GETDATE()
				,@VigenciaDesde
				,dateadd(dd, 365, @VigenciaDesde)
				,100
				,@productor)
				Select 'Poliza emitida';
			end
			
		commit Transaction
	end try

	begin catch

		if @@TRANCOUNT > 0	
		begin
			Rollback transaction;
		end
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[InsertarAsegurado]    Script Date: 5/7/2020 20:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[InsertarAsegurado] 
@apellido nvarchar(100), @nombre nvarchar(100), @nacimiento date, @DNI numeric
as
begin try
insert into Asegurados(Apellido, Nombre, Fecha_nacimiento, Nro_docimento, Cantidad_polizas,Cantidad_siniestros ) values
(@apellido, @nombre, @nacimiento, @DNI, 0,0)

end try

begin catch
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
end catch
GO
USE [master]
GO
ALTER DATABASE [BBDD Final] SET  READ_WRITE 
GO
