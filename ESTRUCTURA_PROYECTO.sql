USE MASTER
GO 
	CREATE DATABASE  GUANA_HOSPI
	ON PRIMARY
	(NAME = 'GUANA_HOSPIL_Data',
	FILENAME= 'C:\data\GUANA_HOSPI_Data.Mdf',
	SIZE = 5000MB,
	MAXSIZE = 10000MB,
	FILEGROWTH = 1000Mb)
	LOG ON
	(NAME = 'GUANA_HOSPI_Log',
	FILENAME= 'C:\log\GUANA_HOSPI_Log.Ldf',
	SIZE = 5000MB,
	MAXSIZE = 10000MB,
	FILEGROWTH = 1000Mb)
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
	CONSTRAINT PK_id_medico PRIMARY KEY (id_medico),
	CONSTRAINT FK_dni_persona_medico FOREIGN KEY (dni_persona) REFERENCES Persona(dni_persona) ON DELETE CASCADE,
)
GO

CREATE TABLE Usuario(
    id_usuario INT IDENTITY (1,1),
	nombre_usuario VARCHAR(40) NOT NULL,
	contrasenna VARCHAR(30) NOT NULL,
	id_medico INT NOT NULL,
	CONSTRAINT PK_id_usuario PRIMARY KEY (id_usuario),
	CONSTRAINT FK_id_medico_usuario FOREIGN KEY (id_medico ) REFERENCES Medico (id_medico) ON DELETE CASCADE
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
	CONSTRAINT FK_id_medico_medico_especialidad FOREIGN KEY (id_medico) REFERENCES Medico (id_medico) ON DELETE CASCADE,
	CONSTRAINT  FK_id_especialidad_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad) ON DELETE CASCADE
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Unidad(
	id_unidad INT IDENTITY (1,1),
	nombre_unidad VARCHAR(50) NOT NULL,
	numero_planta INT NOT NULL,
	CONSTRAINT PK_id_unidad PRIMARY KEY (id_unidad),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Unidad_Medico(
   id_unidad_medico INT IDENTITY (1,1),
   id_unidad INT NOT NULL,
   id_medico INT NOT NULL,
   CONSTRAINT PK_id_unidad_medico PRIMARY KEY (id_unidad_medico),
   CONSTRAINT FK_id_unidad_unidad_medico FOREIGN KEY (id_unidad) REFERENCES Unidad (id_unidad) ON DELETE CASCADE,
   CONSTRAINT FK_id_medico_unidad_medico FOREIGN KEY (id_medico) REFERENCES Medico (id_medico) ON DELETE CASCADE
 )
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Sintoma(
	id_sintoma INT IDENTITY (1,1),
	nombre_sintoma VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_sintoma PRIMARY KEY (id_sintoma),
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Paciente (
	id_paciente INT IDENTITY (1,1),
	numero_seguro_social INT NOT NULL,
	fecha_ingreso DATE NOT NULL,
	dni_persona VARCHAR(12),
	CONSTRAINT PK_id_paciente PRIMARY KEY (id_paciente),
	CONSTRAINT FK_dni_persona_paciente FOREIGN KEY (dni_persona) REFERENCES Persona(dni_persona) ON DELETE CASCADE,
)
GO

USE	GUANA_HOSPI
GO
CREATE TABLE Consulta(
	id_consulta INT IDENTITY (1,1),
	fecha_consulta DATE NOT NULL,
	id_paciente INT NOT NULL,
	CONSTRAINT PK_id_consulta PRIMARY KEY (id_consulta),
	CONSTRAINT FK_id_paciente_consulta FOREIGN KEY(id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE,
)
GO

USE GUANA_HOSPI
GO
CREATE TABLE Consulta_Unidad(
	id_consulta_unidad INT IDENTITY (1,1),
	id_consulta INT NOT NULL,
	id_unidad INT NOT NULL, 
	CONSTRAINT PK_id_consulta_unidad PRIMARY KEY (id_consulta_unidad),
	CONSTRAINT FK_id_consulta FOREIGN KEY(id_consulta) REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
	CONSTRAINT FK_id_unidad FOREIGN KEY(id_unidad) REFERENCES Unidad(id_unidad) ON DELETE CASCADE
)
GO

CREATE TABLE Presenta (
	id_presenta INT IDENTITY (1,1),
	id_consulta INT NOT NULL,
	id_sintoma INT NOT NULL,
	descripcion_presenta VARCHAR(50) NOT NULL,
	CONSTRAINT PK_id_presenta PRIMARY KEY (id_presenta) ,
	CONSTRAINT FK_id_sintoma_presenta FOREIGN KEY (id_sintoma) REFERENCES  Sintoma(id_sintoma) ON DELETE CASCADE, 
	CONSTRAINT FK_id_consulta_presenta FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta) ON DELETE CASCADE,
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
	CONSTRAINT PK_id_padece PRIMARY KEY (id_padece),
	CONSTRAINT FK_id_paciente_padece FOREIGN  KEY (id_paciente) REFERENCES Paciente (id_paciente) ON DELETE CASCADE,
	CONSTRAINT FK_id_enfermedad_padece FOREIGN KEY (id_enfermedad) REFERENCES Enfermedad(id_enfermedad) ON DELETE CASCADE,
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

USE	GUANA_HOSPI
GO
CREATE TABLE Paciente_Unidad(
	id_paciente_unidad INT IDENTITY(1,1),
	id_paciente INT  NOT NULL,
	id_unidad INT NOT NULL,
	CONSTRAINT PK_id_paciente_unidad PRIMARY KEY (id_paciente_unidad),
	CONSTRAINT FK_id_paciente_paciente_unidad FOREIGN KEY (id_paciente) REFERENCES Paciente (id_paciente) ON DELETE CASCADE,
	CONSTRAINT FK_id_unidad_paciente_unidad FOREIGN KEY (id_unidad) REFERENCES Unidad(id_unidad) ON DELETE CASCADE,
)
GO




