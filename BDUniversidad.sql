-- Base de datos Universidad
-- Matheus Tapia M. Arturo
-- 8/8/2022

-- usar Base de datos BDUniversidad
use BDUniversidad
go

if DB_ID('DBUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
go

use BDUniversidad
go


-- Eliminar tablas

if OBJECT_ID('TAlumnno') is not null
	drop table TAlumno
go


if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go



-- Crear tablas
create table TEscuela
(
	CodEscuela char(5) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

create table TAlumno
(
	CodAlumno char(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(5),
	foreign key (CodEscuela) references TEscuela
)
go


-- Inserción de datos DE TEscuela
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go


-- Inserción de datos TAlumno

insert into TAlumno values('A01','Amarillo','Patito','Cusco','02/02/2022','E01')
insert into TAlumno values('A02','Canastillo','Emerson','Arequipa','02/05/2022','E02')
insert into TAlumno values('A03','Matatus','Juana','Lima','02/05/2022','E03')
insert into TAlumno values('A04','Coajiras','Guesto','Trujillo','06/02/2022','E04')
go

select * from TEscuela
go

select * from TAlumno
go