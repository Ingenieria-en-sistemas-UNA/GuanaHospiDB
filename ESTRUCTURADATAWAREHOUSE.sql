USE MASTER
GO 
	CREATE DATABASE  DW_GUANA_HOSPI
	ON PRIMARY
	(NAME = 'DW_GUANA_HOSPI_Data',
	FILENAME= 'C:\data\DW_GUANA_HOSPI_Data.Mdf',
	SIZE = 5Mb,
	MAXSIZE = 10Mb,
	FILEGROWTH = 1Mb)
	LOG ON
	(NAME = 'DW_GUANA_HOSPI_Log',
	FILENAME= 'C:\log\DW_GUANA_HOSPI_Log.Ldf',
	SIZE = 5Mb,
	MAXSIZE = 10Mb,
	FILEGROWTH = 1Mb)
GO


USE	DW_GUANA_HOSPI
GO
CREATE TABLE Persona(
    dni_persona VARCHAR(12) NOT NULL,
	nombre_persona VARCHAR(40) NOT NULL,
	apellido_1 VARCHAR(40) NOT NULL,
	apellido_2 VARCHAR(40)NOT NULL,
	edad INT NOT NULL,
	CONSTRAINT PK_dni PRIMARY KEY (dni_persona),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Medico(
    id_medico INT,
	codigo_medico INT NOT NULL,
	dni_persona VARCHAR(12) NOT NULL,
	CONSTRAINT PK_id_medico PRIMARY KEY (id_medico)
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Unidad(
	id_unidad INT,
	nombre_unidad VARCHAR(50) NOT NULL,
	numero_planta INT NOT NULL,
	id_medico INT,
	CONSTRAINT PK_id_unidad PRIMARY KEY (id_unidad),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Consulta(
	id_consulta INT,
	fecha_consulta DATE,
	id_paciente INT,
	id_unidad INT,
	CONSTRAINT PK_id_consulta PRIMARY KEY (id_consulta)
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Enfermedad(
	id_enfermedad INT,
	nombre_enfermedad VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_enfermedad PRIMARY KEY (id_enfermedad),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Padece(
	id_padece INT,
	id_paciente INT NOT NULL,
	id_enfermedad INT NOT NULL,
	CONSTRAINT PK_id_padece PRIMARY KEY (id_padece)
)

USE	DW_GUANA_HOSPI
GO	
CREATE TABLE Tipo_Intervencion(
	id_tipo_intervencion INT,
	nombre_tipo_intervencion VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_tipo_intervension PRIMARY KEY (id_tipo_intervencion),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Intervenciones(
	id_intervencion INT,
	tratamiento VARCHAR(150) NOT NULL,
	id_tipo_intervencion INT NOT NULL,
	id_consulta INT NOT NULL,
	CONSTRAINT PK_id_intervencion PRIMARY KEY (id_intervencion)
)
GO

use GUANA_HOSPI
go
select * from Consulta

use DW_GUANA_HOSPI
go
select * from Consulta