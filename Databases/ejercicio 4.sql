use [BBDD Final];
go 

create function GetPolizasByProductor (@codigo_productor numeric)
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

go 

select dbo.GetPolizasByProductor (2)

go



create function GetJefes (@cod_productor numeric)
returns table 
as
return
	select Codigo from Productores where [Productor,Jefe] = @cod_productor


select * from dbo.GetJefes (1)

