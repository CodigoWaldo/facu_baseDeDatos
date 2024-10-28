--crear schema
create schema "practica";

--eliminar schema
drop schema "practica" cascade;

-- establecer esquema de trabajo
set search_path to "practica";

--cambiar nombre schema
ALTER SCHEMA "asd" RENAME TO "practica";



---- DDL (DEFINICION DE DATOS) PARA TABLAS ---


--crear tabla
create table clients(
ID int,
firstName varchar(50),
lastName varchar(50),
BirthDate date
);

--eliminar tabla
drop table clients;

--modificar (alterar) tabla
alter table clients add Address varchar(50);



----- DML (MANIPULACION DE DATOS ) -----------

--agregar datos a una tabla
insert into clients(id,firstname,lastname,birthdate,address)
values(4, 'waldo', 'codigo','04-05-1996',null)

insert into clients(id)
values(4)

--modificar valores

--modificar un valor en especifico
update clients set address ='avenida siempre viva 123' where id = 4 and firstname = 'waldo'

--eliminar una tabla
delete from clients where id = 4
delete from clients 

--ver datos de una tabla
-- * devuelve todas las columnas de la tabla
select * from clients 

--devuelve solo lo pedido 
select id, firstname from clients

--devuelve con condiciones
select * from clients 
where id = 2



