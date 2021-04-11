use [BBDD Final];
go

alter procedure Emitir_Poliza
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
go




alter function GetCodAsegurado (@dni numeric)
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

go

alter function GetCantidadSiniestros (@CodigoAsegurado numeric)
returns numeric
as
begin
	declare @CantidadSiniestro numeric;

	select @CantidadSiniestro = Cantidad_siniestros from Asegurados where Asegurados.Codigo= @CodigoAsegurado

	return @CantidadSiniestro;
end;
go

--error no existe dni asegurado
exec Emitir_Poliza 1,'rima','Lisandro', '1994-07-07', 111111111, '2020-07-07', 1;

--error posee siniestro
exec Emitir_Poliza 1,'rima','Lisandro', '1994-07-07', 12345679, '2020-07-07', 1;

--Emite Poliza
exec Emitir_Poliza 1,'rima','Lisandro', '1994-07-07', 11111111, '2020-07-07', 2;