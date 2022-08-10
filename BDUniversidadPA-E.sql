-- Procedimientos almacenados TEscuela
-- Matheus Tapia M. Arturo
-- 8/8/2022

-- PA para TEscuela
use BDUniversidad 
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go


if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
	@CodEscuela char(5), 
	@Escuela varchar(50), 
	@Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		-- Escuela no puede ser duplicado
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError = 0, Mensaje= 'Se inserto correctamente escuela'
			end
		else select CodError= 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go


exec spAgregarEscuela 'E06','Civil','Ingenieria' --duplicado
go

exec spAgregarEscuela 'E06','Psicologia','Ingenieria' -- new
go

exec spListarEscuela
go

--  Actividad: Eliminar, Actualizar, Buscar, Listar

--------------------------------------
---Procedimiento eliminado
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(5)
as begin
	--1. CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		--2. No exista alummnos en la escuela que quiero eliminar
		if not exists(select CodEscuela from TAlumno where CodEscuela = @CodEscuela)
		begin 
			delete from TEscuela WHERE CodEscuela =  @CodEscuela
			select CodError = 0, Mensaje = 'Escuela eliminada correctamente'
		end

		else select CodError = 1, Mensaje = 'Error: No se puede eliminar por que existe alumnos en la escuela'
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spEliminarEscuela 'E06'

 
exec spEliminarEscuela 'E05'


exec spListarEscuela
go




-- Procedimiento Actualizar escuela


if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go

create proc spActualizarEscuela
@CodEscuela char(5), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		-- 2.- No exista alumnos en la escuela que quiero actualizar
		if not exists(select Escuela, Facultad from TEscuela where Escuela = @Escuela and Facultad = @Facultad)
			begin
				update TEscuela set Escuela = @Escuela,
					Facultad = @Facultad  
					where CodEscuela = @CodEscuela
				select CodError = 0, Mensaje = 'Escuela actualizada correctamente'
			end
		else select CodError=1, Mensaje = 'Error: La escuela es duplicada'
	else select CodError = 1, Mensaje = 'Error: Codigo de Escuela no existe'

end


exec spActualizarEscuela 'E01', 'Derecho','Derecho y Ciencia Política'  -- no existe
go

exec spActualizarEscuela 'E04', 'Psicologia','Derecho y Ciencia Política' -- Nuevo
go

exec spActualizarEscuela 'E05', 'Psicologia','Derecho y Ciencia Política' -- duplicada
go


exec spListarEscuela
go



--Buscar en la Tabla Escuela

if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go

create proc spBuscarEscuela
@CodEscuela varchar(50)
--@Criterio varchar(10)
as 
begin
	--if(@Criterio = 'CodEscuela')--Busqueda exacta
		select CodEscuela, Escuela, Facultad 
		from TEscuela 
		where CodEscuela = @CodEscuela
	--else if(@Criterio = 'Escuela')-- Busqueda sensitiva
		--select Escuela, CodEscuela 
		-- from TEscuela 
		-- where Escuela Like '%' + @Texto + '%'	
end
go




exec spBuscarEscuela 'E01'

exec spBuscarEscuela 'E02'

--exec spBuscarEscuela 'Sis' 

go






