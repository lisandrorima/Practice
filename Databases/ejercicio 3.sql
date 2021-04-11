use [BBDD Final];
go 

create trigger dbo.ActualizarPolizas
on Polizas
after insert
as
begin
declare @codigo numeric;
	
	select @codigo= Codigo_asegurado from Polizas where Nro_poliza = (select MAX(Nro_poliza) as Nro_poliza from Polizas) 

	update Asegurados 
	set cantidad_polizas= Cantidad_polizas+ 1 
	where @codigo= Asegurados.Codigo

end