use [BBDD Final];
go

alter procedure DarBajaPoliza 
@numero_Poliza numeric

as
begin transaction
begin try

	declare @codAseg numeric;

	select @codAseg =  Codigo_asegurado from Polizas where Nro_poliza=@numero_Poliza


	update Polizas
	set Estado_poliza=2 where Nro_poliza=@numero_Poliza
		
	update Asegurados set Cantidad_polizas = (Cantidad_polizas-1) where Codigo = @codAseg

	if (select Cantidad_polizas from Asegurados where Codigo = @codAseg) <0 

	begin 
	RAISERROR ( 'La cantidad de polizas no pueden ser negativas',17,1)
	end

	commit transaction
end try
begin catch

	if @@TRANCOUNT > 0	
		begin
			Rollback transaction;
		end

 DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
  
    -- Use RAISERROR inside the CATCH block to return error  
    -- information about the original error that caused  
    -- execution to jump to the CATCH block.  
    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               );  

		
end catch
go

exec DarBajaPoliza 33