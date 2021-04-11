Use [BBDD Final];
go

create procedure InsertarAsegurado 
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
go

exec InsertarAsegurado 'Rima', 'Lautaro', '2000-10-11', 11111111

