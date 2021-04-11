use [BBDD Final];

go

--devuelve 1 si la poliza esta vencida
 create function verificarVencida (@numeroPoliza numeric)
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
go

begin try
	declare @polizaId numeric, @codigoSeccion numeric, @codigoAsegurado numeric, @estadoPoliza numeric;
	declare @fechaEmision date, @fechaDesde date, @fechaHasta date, @suma numeric, @productor numeric;
	declare @huboCambio bit;
	set @huboCambio=0
	Declare ActualizacionPoliza cursor for

	select Nro_poliza, 
	Codigo_seccion, 
	Codigo_asegurado,
	Estado_poliza,
	Fecha_emision,
	Fecha_vigencia_desde,
	Fecha_vigencia_hasta,
	Suma_asegurada,
	Productor
	from dbo.Polizas


	open ActualizacionPoliza 
	fetch next from ActualizacionPoliza
	into @polizaId, @codigoSeccion, @codigoAsegurado, @estadoPoliza, @fechaEmision, @fechaDesde, @fechaHasta, @suma, @productor


	while @@FETCH_STATUS=0

		begin
		--select Nro_poliza from Polizas where Nro_poliza = @polizaId
			begin transaction
				if (select dbo.verificarVencida(@polizaId)) = 1  and @estadoPoliza = 1 
				begin
			
					if (select dbo.GetCantidadSiniestros(@codigoAsegurado)) >0 
					begin
					set @estadoPoliza = 3
					end
					else
					begin
					set @estadoPoliza = 1
					end
			
			
					insert into Polizas (Codigo_seccion, Codigo_asegurado,Estado_poliza,Fecha_emision,Fecha_vigencia_desde,Fecha_vigencia_hasta,Suma_asegurada,Productor)
					values
					(@codigoSeccion, @codigoAsegurado, @estadoPoliza, getdate(), dateadd(dd,1,@fechaHasta),dateadd(dd,366,@fechaHasta), @suma*1.2, @productor)

					update Polizas set Estado_poliza=4 where Nro_poliza =@polizaId

					set @huboCambio =1
				end
			commit transaction
			
			fetch next from ActualizacionPoliza into @polizaId, @codigoSeccion, @codigoAsegurado, @estadoPoliza, @fechaEmision, @fechaDesde, @fechaHasta, @suma, @productor
		end

		if @huboCambio=0
		begin
		select 'No hay polizas vencidas' as resultado
		end
	close ActualizacionPoliza
	deallocate ActualizacionPoliza
end try
begin catch
	SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  

	if @@TRANCOUNT > 0	
		begin
			Rollback transaction;
		end

	close ActualizacionPoliza
	deallocate ActualizacionPoliza
end catch
go
