create schema "guia_1";

set search_path to "guia_1";

/* Tablas de Nivel 1 */

create table provincia(
cod_provincia smallint not null,
nombre_provincia varchar(50) not null,
constraint pk_provincia primary key (cod_provincia)
);


create table especialidad(
cod_especialidad smallint not null,
nombre_especialidad varchar(50) not null,
constraint pk_especialidad primary key (cod_especialidad)
);

create table cargo(
cod_cargo smallint not null,
nombre_cargo varchar(50) not null,
constraint pk_cargo primary key (cod_cargo)
);

create table seccion(
cod_seccion smallint not null,
nombre_seccion varchar(50) not null,
constraint pk_seccion primary key (cod_seccion)
);

/* Tablas de nivel 2 */

create table localidad(
cod_localidad smallint not null,
cod_provincia smallint not null,
nombre_localidad varchar(50) not null,
constraint pk_localidad primary key (cod_localidad,cod_provincia),
constraint fk_provincia foreign key (cod_provincia) references provincia(cod_provincia) 
);

drop table sector

create table sector(
cod_sector smallint not null,
cod_seccion smallint not null,
nombre_sector varchar(50) not null,
constraint pk_sector primary key (cod_sector,cod_seccion),
constraint fk_seccion foreign key (cod_seccion) references seccion(cod_seccion)
);



/* Tablas de nivel 3 */

create table persona(
tipo_doc varchar(30) not null default 'DNI' check (tipo_doc in ('DNI','Pasaporte', 'LC', 'otro')),
nro_doc smallint not null,
sexo_persona boolean not null,
nombre_persona varchar(50) null,
apellido_persona varchar(50) null,
fecha_nacimiento date null,
viveEn_codProvincia smallint not null, --foreign1
viveEn_codLocalidad smallint not null, --foreign1
nacioEn_codProvincia smallint not null, --foreign2
nacioEn_codLocalidad smallint not null, --foreign2
padre_tipoDoc varchar(30) not null, --foreign3
padre_nroDoc smallint not null,--foreign3
padre_sexo boolean not null,--foreign3
madre_tipoDoc varchar(30) not null,--foreign4
madre_nroDoc smallint not null,--foreign4
madre_sexo boolean not null,--foreign4
constraint pk_persona primary key (tipo_doc,nro_doc,sexo_persona),
constraint fk1_localidad_N foreign key (viveEn_codProvincia, viveEn_codLocalidad) references localidad(cod_provincia, cod_localidad),
constraint fk2_locaclidad_V foreign key (nacioEn_codProvincia, nacioEn_codLocalidad) references localidad(cod_provincia, cod_localidad),
constraint fk3_esPadreDe foreign key  (padre_tipoDoc,padre_nroDoc,padre_sexo) references persona(tipo_doc,nro_doc,sexo_persona),
constraint fk4_esMadreDe foreign key  (madre_tipoDoc,madre_nroDoc,madre_sexo) references persona(tipo_doc,nro_doc,sexo_persona)
);

/* Tablas de nivel 4 */

create table medico(
matricula smallint not null,
tipo_doc varchar(30) not null,
nro_doc smallint not null,
sexo_persona boolean not null,
cod_especialidad smallint not null,
constraint pk_medico primary key (matricula),
constraint fk1_persona foreign key (tipo_doc, nro_doc, sexo_persona) references persona(tipo_doc,nro_doc,sexo_persona),
constraint fk2_especialidad foreign key (cod_especialidad) references especialidad(cod_especialidad)
);

create table empleado(
cod_empleado smallint not null,
tipo_doc varchar(30) not null,
nro_doc smallint not null,
sexo boolean not null,
fecha_ingreso date not null,
constraint pk_empleado primary key(cod_empleado),
constraint fk_persona foreign key(tipo_doc, nro_doc, sexo) references persona(tipo_doc,nro_doc,sexo_persona)
);


/* Tablas de nivel 5 */
create table historial(
fecha_inicio date not null,
cod_empleado smallint not null,
cod_cargo smallint not null,
fecha_fin date null,
constraint pk_historial primary key (fecha_fin),
constraint fk1_empleado foreign key (cod_empleado) references empleado (cod_empleado),
constraint fk2_cargo foreign key (cod_cargo) references cargo(cod_cargo)
);

create table sala(
nro_sala smallint not null,
cod_especialidad smallint not null,
cod_sector smallint not null,
cod_seccion smallint not null,
cod_empleado smallint not null,
nombre_sala varchar(50) null,
capacidad smallint null,
constraint pk_sala primary key (nro_sala,cod_sector,cod_seccion),
constraint fk1_sector foreign key (cod_sector,cod_seccion) references sector (cod_sector,cod_seccion),
constraint fk2_empleado foreign key (cod_empleado) references empleado (cod_empleado)
);

/* Tablas de nivel 6 */

create table trabajaEn(
cod_empleado smallint not null,
nro_sala smallint not null,
cod_sector smallint not null,
cod_seccion smallint not null,
constraint pk_trabajaEn primary key (cod_empleado,nro_sala,cod_sector,cod_seccion),
constraint fk1_empleado foreign key (cod_empleado) references empleado(cod_empleado),
constraint fk2_seccion foreign key (nro_sala,cod_sector, cod_seccion) references sala(nro_sala,cod_sector,cod_seccion)
);
