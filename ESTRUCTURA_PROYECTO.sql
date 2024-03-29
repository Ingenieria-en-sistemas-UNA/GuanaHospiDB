USE MASTER
GO 
	CREATE DATABASE  GUANA_HOSPI
	ON PRIMARY
	(NAME = 'GUANA_HOSPIL_Data',
	FILENAME= 'C:\Data\GUANA_HOSPI_Data.Mdf',
	SIZE = 5MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 1Mb)
	LOG ON
	(NAME = 'GUANA_HOSPI_Log',
	FILENAME= 'C:\Log\GUANA_HOSPI_Log.Ldf',
	SIZE = 5MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 1Mb)
GO

USE	GUANA_HOSPI
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

USE	GUANA_HOSPI
GO
CREATE TABLE Medico(
    id_medico INT IDENTITY(1,1),
	codigo_medico INT NOT NULL,
	dni_persona VARCHAR(12) NOT NULL,
	estado BIT NOT NULL,
	CONSTRAINT PK_id_medico PRIMARY KEY (id_medico),
	CONSTRAINT FK_dni_persona_medico FOREIGN KEY (dni_persona) REFERENCES Persona(dni_persona),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Roles(
    id_role INT IDENTITY (1,1),
	nombre_role VARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT PK_id_role PRIMARY KEY (id_role),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE users(
    id INT IDENTITY (1,1),
	email VARCHAR(100) NOT NULL UNIQUE,
	password VARCHAR(100) NOT NULL,
	id_medico INT,
	id_role INT
	CONSTRAINT PK_id_usuario PRIMARY KEY (id),
	CONSTRAINT FK_user_role FOREIGN KEY (id_role) REFERENCES Roles (id_role),
	CONSTRAINT FK_id_medico_usuario FOREIGN KEY (id_medico) REFERENCES Medico (id_medico) ON DELETE CASCADE
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Especialidad(
	id_especialidad INT IDENTITY (1,1),
	nombre_especialdad VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_especialidad PRIMARY KEY (id_especialidad),	
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Medico_Especialidad(
	id_medico_especialidad	INT IDENTITY(1,1),
	id_medico INT,
	id_especialidad INT,
	CONSTRAINT PK_id_medico_especialidad PRIMARY KEY (id_medico_especialidad),
	CONSTRAINT FK_id_medico_medico_especialidad FOREIGN KEY (id_medico) REFERENCES Medico (id_medico),
	CONSTRAINT  FK_id_especialidad_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Unidad(
	id_unidad INT IDENTITY (1,1),
	nombre_unidad VARCHAR(50) NOT NULL,
	numero_planta INT NOT NULL,
	id_medico INT
	CONSTRAINT PK_id_unidad PRIMARY KEY (id_unidad),
	CONSTRAINT FK_id_medico FOREIGN KEY (id_medico) REFERENCES Medico (id_medico)
)	
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Paciente (
	id_paciente INT IDENTITY (1,1),
	numero_seguro_social INT NOT NULL,
	fecha_ingreso DATE NOT NULL,
	dni_persona VARCHAR(12),
	estado_paciente BIT NOT NULL,
	CONSTRAINT PK_id_paciente PRIMARY KEY (id_paciente),
	CONSTRAINT FK_dni_persona_paciente FOREIGN KEY (dni_persona) REFERENCES Persona(dni_persona),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Consulta(
	id_consulta INT IDENTITY (1,1),
	fecha_consulta DATETIME2 NOT NULL,
	descripcion VARCHAR(150),
	id_paciente INT NOT NULL,
	id_unidad INT NOT NULL, 
	id_medico INT NOT NULL,
	estado_consulta BIT NOT NULL,
	CONSTRAINT PK_id_consulta PRIMARY KEY (id_consulta),
	CONSTRAINT FK_id_paciente_consulta FOREIGN KEY(id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE,
	CONSTRAINT FK_id_unidad_consulta FOREIGN KEY(id_unidad) REFERENCES Unidad(id_unidad) ON DELETE CASCADE,
	CONSTRAINT FK_id_medico_consulta FOREIGN KEY(id_medico) REFERENCES Medico(id_medico),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Enfermedad(
	id_enfermedad INT IDENTITY (1,1),
	nombre_enfermedad VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_enfermedad PRIMARY KEY (id_enfermedad),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Padece(
	id_padece INT IDENTITY (1,1),
	id_paciente INT NOT NULL,
	id_enfermedad INT NOT NULL,
	id_consulta INT NOT NULL,
	CONSTRAINT PK_id_padece PRIMARY KEY (id_padece),
	CONSTRAINT FK_id_paciente_padece FOREIGN  KEY (id_paciente) REFERENCES Paciente (id_paciente) ON DELETE CASCADE,
	CONSTRAINT FK_id_enfermedad_padece FOREIGN KEY (id_enfermedad) REFERENCES Enfermedad(id_enfermedad),
	CONSTRAINT FK_id_consulta_padece FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
)
GO

USE	GUANA_HOSPI
GO	
CREATE TABLE Tipo_Intervencion(
	id_tipo_intervencion INT IDENTITY (1,1),
	nombre_tipo_intervencion VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_tipo_intervension PRIMARY KEY (id_tipo_intervencion),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Intervenciones(
	id_intervencion INT IDENTITY (1,1),
	tratamiento VARCHAR(150) NOT NULL,
	id_tipo_intervencion INT NOT NULL,
	id_consulta INT NOT NULL,
	CONSTRAINT PK_id_intervencion PRIMARY KEY (id_intervencion),
	CONSTRAINT FK_id_tipo_intervenciones FOREIGN KEY (id_tipo_intervencion) REFERENCES Tipo_Intervencion(id_tipo_intervencion),
	CONSTRAINT FK_id_consulta_intervenciones FOREIGN KEY (id_consulta) REFERENCES Consulta (id_consulta) ON DELETE CASCADE,
)
GO

USE GUANA_HOSPI
GO 
	CREATE TABLE Auditoria(
		IdAuditoria INT IDENTITY (1,1) NOT NULL,
		Usuario VARCHAR(50),
		Fecha DATETIME2,
		Descripcion VARCHAR(50)
		CONSTRAINT PK_IdAuditoria PRIMARY KEY (IdAuditoria)
)
GO
