USE MASTER
GO 
	CREATE DATABASE  GUANA_HOSPI
	ON PRIMARY
	(NAME = 'GUANA_HOSPIL_Data',
	FILENAME= 'D:\SQLData\GUANA_HOSPI_Data.Mdf',
	SIZE = 5MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 1Mb)
	LOG ON
	(NAME = 'GUANA_HOSPI_Log',
	FILENAME= 'D:\SQLLog\GUANA_HOSPI_Log.Ldf',
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

----------------------------------------------------------------------------

USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Persona
	@Dni VARCHAR(12),
	@Nombre VARCHAR(30),
	@Apellido1 VARCHAR(40),
	@Apellido2 VARCHAR(40),
	@Edad VARCHAR(20)
AS
	IF ((@Dni = '') OR (@Nombre = '') OR ( @Apellido1 = '') OR (@Apellido2 = '') OR (@Edad = ''))
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@Edad) = 0)
	    BEGIN
            SELECT message = 'La edad debe ser de tipo numerico', ok = 0
        END
	ELSE IF (EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona= @Dni))
		BEGIN
			SELECT message = 'Este id ya habia sido registrado anteriormente', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha ingresado correctamente', ok = 1
			INSERT INTO Persona( dni_persona, nombre_persona, apellido_1, apellido_2, edad)
			VALUES (@Dni, @Nombre, @Apellido1, @Apellido2, CONVERT(int, @Edad));
		END
GO

----------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Especialidad
	@NombreEspecialidad VARCHAR(30),
	@Id_Usuario VARCHAR(12)
AS
	IF(@NombreEspecialidad = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(EXISTS(SELECT nombre_especialdad FROM Especialidad WHERE nombre_especialdad = @NombreEspecialidad))
		BEGIN
			SELECT message = 'La especialidad ya existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente', beforeId = IDENT_CURRENT('Especialidad'), currentId = IDENT_CURRENT('Especialidad') + IDENT_INCR('Especialidad'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Especialidad(nombre_especialdad)
			VALUES (@NombreEspecialidad)
			SET CONTEXT_INFO 0x0
		END
GO
-----------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Medico
	@CodigoMedico varchar(5),
	@DniPersona varchar(12),
	@Id_Usuario varchar(12)
AS
	IF(@CodigoMedico = '' OR @DniPersona = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@CodigoMedico) = 0)
		BEGIN
			SELECT message = 'El codigo medico debe ser de tipo numerico', ok = 0
		END
	ELSE IF (NOT EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona=@DniPersona))
		BEGIN
			SELECT message = 'El id de la persona no existe', ok = 0
		END
	ELSE IF (EXISTS(SELECT dni_persona FROM Medico WHERE dni_persona=@DniPersona))
		BEGIN
			SELECT message = 'Esta persona ya es un medico', ok = 0
		END
	ELSE IF (EXISTS(SELECT codigo_medico FROM Medico WHERE codigo_medico = @CodigoMedico))
		BEGIN
			SELECT message = 'El codigo medico ya ha sido registrado anteriormente', ok = 0
		END
	ELSE 
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Medico'), currentId = IDENT_CURRENT('Medico') + IDENT_INCR('Medico'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa

			INSERT INTO Medico(codigo_medico, dni_persona, estado)
			VALUES (CONVERT(int, @CodigoMedico), @DniPersona, 1)

			SET CONTEXT_INFO 0x0
		END
GO

-------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO

CREATE PROC SP_Crear_Role
	@NombreRole VARCHAR(20)
AS
	IF(@NombreRole = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF (EXISTS(SELECT nombre_role FROM Roles WHERE nombre_role = @NombreRole))
		BEGIN
			SELECT message = 'El role ya existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado conextmente',  beforeId = IDENT_CURRENT('Roles'), currentId = IDENT_CURRENT('Roles') + IDENT_INCR('Roles'), ok = 1
			INSERT INTO ROLES(nombre_role) VALUES (@NombreRole)
		END
GO
-------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Medico_Especialidad
	@IdMedico varchar(5),
	@IdEspecialidad varchar(5)
AS
	IF(@IdMedico = '' OR @IdEspecialidad = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdMedico) = 0 OR ISNUMERIC(@IdEspecialidad) = 0)
		BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @IdMedico))
		BEGIN
			SELECT message = 'El id medico no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @IdEspecialidad))
		BEGIN
			SELECT message = 'El id de la especialidad no existe', ok = 0
		END
	ELSE IF(EXISTS(SELECT id_medico, id_especialidad FROM Medico_Especialidad WHERE id_especialidad = @IdEspecialidad AND id_medico = @IdMedico))
		BEGIN
			SELECT message = 'El medico ya tiene la especialidad', ok = 0
		END
	ELSE 
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Medico_Especialidad'), currentId = IDENT_CURRENT('Medico_Especialidad') + IDENT_INCR('Medico_Especialidad'), ok = 1
			INSERT INTO Medico_Especialidad(id_medico, id_especialidad)
			VALUES (CONVERT(int, @IdMedico), CONVERT(int, @IdEspecialidad))
		END
GO
--------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Unidad
	@Nombre varchar(50),
	@Numero_planta varchar(5),
	@Id_Medico varchar(5) = NULL,
	@Id_Usuario varchar(12)
AS
	IF (@Nombre = '' OR @Numero_planta = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@Numero_planta) = 0 OR @Id_Medico <> '' AND ISNUMERIC(@Id_Medico) = 0)
	    BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
        END
	ELSE IF (EXISTS(SELECT nombre_unidad, numero_planta FROM Unidad WHERE nombre_unidad = @Nombre AND numero_planta = CONVERT(int, @Numero_planta)))
		BEGIN
			SELECT message = 'Esta unidad ya habia sido reistrada anteriormente', ok = 0
		END
	ELSE IF(EXISTS(SELECT id_medico FROM Unidad WHERE id_medico = @Id_Medico))
		BEGIN
			SELECT message = 'El medico ya cuenta con una unidad a cargo', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Unidad'), currentId = IDENT_CURRENT('Unidad') + IDENT_INCR('Unidad'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Unidad(nombre_unidad, numero_planta, id_medico)
			VALUES (@Nombre, CONVERT(int, @numero_planta), @Id_Medico)
			SET CONTEXT_INFO 0x0
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Paciente(
	@Numero_seguro_social VARCHAR(8),
	@FechaIngreso VARCHAR(30),
	@DniPersona VARCHAR(12),
	@Id_Usuario VARCHAR(12)
)
AS
	IF(@Numero_seguro_social = '' OR @DniPersona = '' OR @FechaIngreso = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@Numero_seguro_social) = 0)
		BEGIN
			SELECT message = 'El numero de seguro social debe ser formato numero', ok = 0
		END
	ELSE IF(ISDATE(@FechaIngreso) = '')
		BEGIN
			SELECT message = 'Debe ser una fecha valida'
		END
	ELSE IF EXISTS(SELECT numero_seguro_social FROM Paciente WHERE numero_seguro_social = @Numero_seguro_social)
		BEGIN
			SELECT message = 'El numero de seguro social ya habia registrado anteriormente', ok = 0
		END
	ELSE IF EXISTS(SELECT dni_persona FROM Paciente WHERE dni_persona = @DniPersona)
		BEGIN
			SELECT message = 'La persona ya fue registrada', ok = 0
		END
	ELSE IF NOT EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona = @DniPersona)
		BEGIN
			SELECT message = 'La persona no existe', ok = 0
		END
	ELSE IF EXISTS(SELECT dni_persona FROM Paciente WHERE dni_persona = @DniPersona)
		BEGIN
			SELECT message = 'El paciente ya habia sido registrado anteriormente', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Paciente'), currentId = IDENT_CURRENT('Paciente') + IDENT_INCR('Paciente'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Paciente(numero_seguro_social, fecha_ingreso, dni_persona, estado_paciente)
			VALUES (CONVERT(int, @Numero_seguro_social), CONVERT(date, @FechaIngreso), @DniPersona, 1)
			SET CONTEXT_INFO 0x0
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Consulta
	@descripcion VARCHAR(150),
	@IdPaciente VARCHAR(5),
	@IdUnidad VARCHAR(5),
	@IdMedico VARCHAR(12),
	@Id_Usuario VARCHAR(12)
AS
	IF(@IdPaciente = '' OR @IdUnidad = '' OR @IdMedico = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdUnidad) = 0 OR ISNUMERIC(@IdMedico) = 0)
		BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			SELECT message = 'El paciente no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @IdUnidad))
		BEGIN
			SELECT message = 'La unidad no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @IdMedico))
		BEGIN
			SELECT message = 'El medico no existe', ok = 0
		END
	ELSE IF EXISTS(SELECT id_medico FROM Unidad WHERE id_unidad = @IdUnidad AND id_medico IS NULL OR id_medico = '')
		BEGIN
			SELECT message = 'No se puede crear una consulta sin un medico a cargo', ok = 0 
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Consulta'), currentId = IDENT_CURRENT('Consulta') + IDENT_INCR('Consulta'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Consulta(fecha_consulta, descripcion, id_paciente, id_unidad, id_medico,estado_consulta)
			VALUES (CONVERT(datetime2(0), SYSDATETIME()), @descripcion, CONVERT(int, @IdPaciente), CONVERT(int, @IdUnidad), CONVERT(int, @IdMedico),1)
			SET CONTEXT_INFO 0x0
		END
GO


-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Enfermedad
	@Nombre varchar(50),
	@Id_Usuario VARCHAR(12)
AS
	IF(@Nombre = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF (EXISTS(SELECT nombre_enfermedad FROM Enfermedad WHERE nombre_enfermedad = @Nombre))
		BEGIN
			SELECT message = 'La enfermedad ya existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Enfermedad'), currentId = IDENT_CURRENT('Enfermedad') + IDENT_INCR('Enfermedad'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Enfermedad(nombre_enfermedad)
			VALUES (@Nombre)
			SET CONTEXT_INFO 0x0
		END
GO
--------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Padece
	@IdPaciente varchar(5),
	@IdEnfermedad varchar(5),
	@IdConsulta varchar(5)
AS
	IF(@IdPaciente = '' OR @IdEnfermedad = '' OR @IdConsulta = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdEnfermedad) = 0 OR ISNUMERIC(@IdConsulta) = 0)
		BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			SELECT message = 'El id del paciente no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @IdEnfermedad))
		BEGIN
			SELECT message = 'El id de la enfermedad no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			SELECT message = 'El id de la consulta no existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Padece'), currentId = IDENT_CURRENT('Padece') + IDENT_INCR('Padece'), ok = 1
			INSERT INTO Padece(id_paciente, id_enfermedad, id_consulta)
			VALUES (CONVERT(int, @IdPaciente), CONVERT(int, @IdEnfermedad), CONVERT(int, @IdConsulta))
		END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Tipo_Intervencion
	@Nombre varchar(50),
	@Id_Usuario VARCHAR(12)
AS
	IF(@Nombre = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF (EXISTS(SELECT nombre_tipo_intervencion FROM Tipo_Intervencion WHERE nombre_tipo_intervencion = @Nombre))
		BEGIN
			SELECT message = 'El tipo de intervencion ya existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Tipo_Intervencion'), currentId = IDENT_CURRENT('Tipo_Intervencion') + IDENT_INCR('Tipo_Intervencion'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Tipo_Intervencion(nombre_tipo_intervencion)
			VALUES (@Nombre)
			SET CONTEXT_INFO 0x0
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Intervencion
	@Tratamiento VARCHAR(150),
	@IdTipoIntervencion VARCHAR(5),
	@IdConsulta VARCHAR(5)
AS
	IF(@Tratamiento = '' OR @IdTipoIntervencion = '' OR @IdConsulta = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdTipoIntervencion) = 0 OR ISNUMERIC(@IdConsulta) = 0)
		BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @IdTipoIntervencion))
		BEGIN
			SELECT message = 'El id del tipo de intervencion no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			SELECT message = 'El id de la consulta no existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctamente',  beforeId = IDENT_CURRENT('Intervenciones'), currentId = IDENT_CURRENT('Intervenciones') + IDENT_INCR('Intervenciones'), ok = 1
			INSERT INTO Intervenciones(tratamiento, id_tipo_intervencion, id_consulta)
			VALUES (@Tratamiento, CONVERT(int, @IdTipoIntervencion), CONVERT(int, @IdConsulta))
		END
GO
---------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_User
	@Email VARCHAR(100),
	@Password VARCHAR(100),
	@IdRole VARCHAR(5),
	@IdMedico VARCHAR(5) = NULL,
	@Id_Usuario VARCHAR(12)
AS
	IF(@Email = '' OR @Password = '' OR @IdRole = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdRole) = 0 OR CONVERT(int, @IdRole) < 0)
		BEGIN
			SELECT message = 'El id del role debe ser de tipo numerico y mayor a cero', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_role FROM Roles WHERE id_role = @IdRole))
		BEGIN
			SELECT message = 'El id del role no existe', ok = 0
		END
	ELSE IF(EXISTS(SELECT email FROM users WHERE LOWER(email) = LOWER(@Email)))
		BEGIN
			SELECT message = 'El email ya fue registrado', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha ingresado correctamente', currentId = IDENT_CURRENT('users') + IDENT_INCR('users'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO users(email, password, id_medico, id_role)
			VALUES(@Email, @Password, CONVERT(int, @IdMedico), CONVERT(int, @IdRole))
			SET CONTEXT_INFO 0x0
		END
GO
----------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Auditoria
	@Id_Usuario VARCHAR(12),
	@Descripcion VARCHAR(50)
AS
	SELECT message = 'La Auditoria se ha creado correctamente', ok = 1
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
    INSERT INTO Auditoria (Usuario, Fecha, Descripcion) 
    VALUES (@Email, CONVERT(datetime2(0), SYSDATETIME()), @Descripcion)
GO

----------------------------------------------------------------------------------------------------------
-----------------------------ELIMINAR PERSONA-----------------------------------------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Persona (@dni_persona VARCHAR(12))
AS
	IF (@dni_persona = '') 
		BEGIN
			SELECT message ='El id de persona de la perosna no puede ser vacio', ok = 0
		END
	ELSE IF EXISTS (SELECT dni_persona FROM Persona WHERE dni_persona = @dni_persona)
		BEGIN
	        IF EXISTS (SELECT dni_persona  FROM Medico where dni_persona = @dni_persona)
				BEGIN
					SELECT message ='Se ha eliminado el medico', ok = 0
					DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
				END
			ELSE IF EXISTS (SELECT @dni_persona FROM Paciente WHERE dni_persona = @dni_persona)
				BEGIN
				    SELECT message ='Se ha eliminado el paciente', ok = 1
					DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
				END
			SELECT message ='Se ha eliminado la persona', ok = 1
			DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
		END
	ELSE
		BEGIN
			SELECT message = 'El id de persona no existe', ok = 0
		END
GO
---------------------------------SP_ELIMINAR_ESPECIALIDAD-------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Especialidad (@id_especialidad VARCHAR(10), @Id_USuario VARCHAR(12))
AS
	IF (@id_especialidad = '') 
		BEGIN
			SELECT message ='El id de especialidad no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_especialidad) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_especialidad FROM Especialidad WHERE Especialidad.id_especialidad = @id_especialidad)
		BEGIN
		    DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			SELECT message = 'Se ha eliminado la especalidad', ok = 1
			DELETE FROM Especialidad WHERE Especialidad.id_especialidad = @id_especialidad
			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'El id de especialidad no existe', ok = 0
		END
GO
-------------------------------------------------Eliminar Medico------------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Medico (@id_medico VARCHAR, @Id_Usuario VARCHAR(12))

AS
	IF (@id_medico = '') 
		BEGIN
			SELECT message = 'El id de médico no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_medico FROM Medico WHERE id_medico  = @id_medico )
		BEGIN
			SELECT message = 'El medico esta inactivo', ok = 1
			IF(EXISTS (SELECT id_medico FROM Unidad WHERE id_medico = @id_medico))
				BEGIN
					UPDATE Unidad
					SET id_medico = NULL
					WHERE id_medico = @id_medico
				END
			DECLARE @idPersonaMedico VARCHAR(12)
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			SET @idPersonaMedico = (SELECT dni_persona FROM Medico WHERE id_medico = @id_medico)
			
			---Cambia el estado del medico
			UPDATE Medico
			SET estado = 0
			WHERE id_medico = @id_medico

			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'El medico no existe', ok = 0
		END
GO

---------------------------------------------ELIMINAR UNIDAD-----------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Unidad (@id_unidad VARCHAR(10), @Id_Usuario VARCHAR(12))
AS
	IF (@id_unidad = '') 
		BEGIN
			SELECT message = 'El id de unidad no puede ser vacio'
		END
	ELSE IF(ISNUMERIC(@id_unidad) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad)
		BEGIN
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			SELECT message = 'Se ha eliminado unidad', ok = 1
			DELETE FROM Unidad WHERE Unidad.id_unidad = @id_unidad
			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'La unidad no existe', ok = 0
		END
GO

-----------------------------ELIMINAR Paciente-----------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Paciente (@id_paciente INT, @Id_Usuario VARCHAR(12))
AS
	IF (@id_paciente = '') 
		BEGIN
			SELECT message = 'El id de paciente no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_paciente FROM Paciente WHERE id_paciente  = @id_paciente )
		BEGIN
			DECLARE @idPersonaPaciente VARCHAR(12)
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			SET @idPersonaPaciente = (SELECT dni_persona FROM Paciente WHERE id_paciente = @id_paciente)
			SELECT message = 'Se ha eliminado el paciente', ok = 1
			
			--Cambia el estado del paciente
			UPDATE Paciente
			SET estado_paciente = 0
			WHERE id_paciente = @id_paciente

			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'El paciente no existe', ok = 0
		END
GO

------------------------------------------ELIMINAR CONSULTA------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Elimina_Consulta (@id_consulta INT, @Id_Usuario VARCHAR(12))
AS
	IF (@id_consulta = '') 
		BEGIN
			SELECT message = 'El id de consulta no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_consulta FROM Consulta WHERE Consulta.id_consulta = @id_consulta)
		BEGIN
		    SELECT message = 'Se ha eliminado la consulta', ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
            ---Cambia el estado del consulta
			UPDATE Consulta
			SET estado_consulta = 0
			WHERE id_consulta = @id_consulta

			SET CONTEXT_INFO 0x0	
		END
	ELSE
		BEGIN
			SELECT message = 'La consulta no existe', ok = 0
		END
GO

-----------------------------------ELIMINAR ENFERMEDAD-----------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Enfermedad (@id_enfermedad INT, @Id_Usuario VARCHAR (12))
AS
	IF (@id_enfermedad = '') 
		BEGIN
			SELECT message = 'El id de enfermedad no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_enfermedad) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS(SELECT id_enfermedad FROM Padece WHERE id_enfermedad = @id_enfermedad)
		BEGIN
			SELECT message = 'Hay pacientes registrados con esta enfermedad', ok = 0
		END
	ELSE IF EXISTS (SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad)
		BEGIN
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			SELECT message = 'Se ha eliminado la enfermedad', ok = 1
			DELETE FROM Enfermedad WHERE Enfermedad.id_enfermedad = @id_enfermedad
			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'El id de enfermedad no existe', ok = 0
		END
GO
----------------------------------------ELIMINAR PADECIMIETNO------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Padecimiento (@id_padece INT)
AS
	IF (@id_padece = '') 
		BEGIN
			SELECT message = 'El id de padecimiento no uede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_padece) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_padece FROM Padece WHERE id_padece  = @id_padece )
		BEGIN
			SELECT message = 'El id de padecimiento se ha eliminado existosamente!', ok = 1
			DELETE FROM Padece WHERE id_padece = @id_padece
	    END    
	ELSE
		BEGIN
			SELECT message = 'El id de padecimiento no existe', ok = 0
		END
GO

----------------------------------------ELIMINAR PADECIMIETNO POR ID PACIENTE-IDCONSULTA------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Padecimiento_Id_Paciente_Consulta (@id_paciente INT, @id_consulta INT)
AS
	IF (@id_paciente = '' OR @id_consulta = '') 
		BEGIN
			SELECT message = 'El id de padecimiento no uede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0 OR ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_padece FROM Padece WHERE id_paciente = @id_paciente AND id_consulta = @id_consulta)
		BEGIN
		    SELECT message = 'Se ha eliminado el id del paciente', ok = 1
			DELETE FROM Padece WHERE id_paciente = @id_paciente AND id_consulta = @id_consulta
	    END    
	ELSE
		BEGIN
			SELECT message = 'El id de padecimiento no existe', ok = 0
		END
GO
---------------------------------------------ELIMINAR TIPO INTERVENcION-----------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Tipo_Intervension(@id_tipo_intervencion INT, @Id_Usuario VARCHAR (12))
AS
	IF (@id_tipo_intervencion = '') 
		BEGIN
			SELECT message = 'El id del tipo de intervencion no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_tipo_intervencion) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS(SELECT id_tipo_intervencion FROM Intervenciones WHERE id_tipo_intervencion = @id_tipo_intervencion)
		BEGIN
			SELECT message = 'Hay intervenciones relacionadas con este tipo de intervención', ok = 0
		END
	ELSE IF EXISTS (SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @id_tipo_intervencion)
		BEGIN
			SELECT message = 'Se ha eliminado el tipo de intervencion', ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			DELETE FROM Tipo_Intervencion WHERE Tipo_Intervencion.id_tipo_intervencion = @id_tipo_intervencion
			SET CONTEXT_INFO 0X0
		END
	ELSE
		BEGIN
			SELECT message =  'El id de tipo intervencion no existe', ok = 0
		END
GO
------------------------------------ELIMINAR INTERVENCIONES------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Intervencion (@id_intervencion INT)
AS
	IF (@id_intervencion = '') 
		BEGIN
			SELECT message = 'El id de intervencion no existe', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_intervencion) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS(SELECT id_intervencion FROM Intervenciones WHERE id_intervencion  = @id_intervencion )
		BEGIN
			SELECT message = 'Se ha eliminado la intervencion', ok = 1
			DELETE FROM Intervenciones WHERE Intervenciones.id_tipo_intervencion = @id_intervencion
	    END
	ELSE
		 BEGIN
			SELECT message = 'El id de la intervencion no existe', ok = 0
		END
GO


------------------------------------------ELIMINAR MEDICO ESPECIALIDAD----------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Medico_Especialidad (@Id_Medico INT)
AS
	IF (@Id_Medico = '') 
		BEGIN
			SELECT message = 'El id medico no puede ser vacio', ok = 0
		END
	ELSE IF EXISTS (SELECT id_medico FROM Medico_Especialidad WHERE id_medico = @Id_Medico)
		BEGIN
			SELECT message = 'Se ha eliminado las especialidades del medico', ok = 1
			DELETE FROM Medico_Especialidad WHERE id_medico = @Id_Medico
		END
	ELSE
		BEGIN
			SELECT message = 'El medico no cuenta con ninguna especialidad', ok = 0
		END
GO
--------------eliminar intervencion por id consulta-------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Intervencion_Id_Consulta(@Id_Consulta INT)
AS
	IF (@Id_Consulta = '') 
		BEGIN
			SELECT message = 'El id de la consulta no puede ser vacio', ok = 0
		END
	ELSE IF EXISTS (SELECT id_consulta FROM Intervenciones WHERE id_consulta = @Id_Consulta)
		BEGIN
			SELECT message = 'Se han eliminado las intervenciones', ok = 1
			DELETE FROM Intervenciones WHERE id_consulta = @Id_Consulta
		END
	ELSE
		BEGIN
			SELECT message =  'La consulta no tiene intervenciones', ok = 0
		END
GO
------------------------------eliminar todos los padece por el id de paciente-------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Padece_Id_Paciente(@Id_Paciente INT)
AS
	IF (@Id_Paciente = '') 
		BEGIN
			SELECT message = 'El id de paciente no puede ser vacio', ok = 0
		END
	ELSE IF EXISTS (SELECT id_paciente FROM Padece WHERE id_paciente = @Id_Paciente)
		BEGIN
			SELECT message = 'Se han eliminado el o los padecimiento', ok = 1
			DELETE FROM Padece WHERE id_paciente = @Id_Paciente
		END
	ELSE
		BEGIN
			SELECT message =  'El paciente no tiene padecimientos', ok = 0
		END
GO


------------------------------------Eliminar Usuario----------------------------------
USE GUANA_HOSPI
GO 
CREATE PROC SP_Eliminar_User(@id VARCHAR(100), @Id_Usuario VARCHAR(12))
	AS
	IF (@id = '') 
		BEGIN
			SELECT message = 'El id no existe', ok = 0
		END
	ELSE IF EXISTS(SELECT id FROM users WHERE id = @id )
	BEGIN
			SELECT message = 'Se ha eliminado un usuario', ok = 1
		    DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa	
			DELETE FROM users WHERE id = @id
			SET CONTEXT_INFO 0x0
		END
	ELSE
		BEGIN
			SELECT message = 'El usuario no existe', ok = 0
		END

GO
--------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO

CREATE PROC SP_Obtener_Personas
AS
	SELECT 'Cedula_Persona' = dni_persona , 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
		'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1
	FROM Persona
	ORDER BY dni_persona ASC;
GO

CREATE PROC SP_Obtener_Persona_Por_Dni
	(@dni_persona VARCHAR(12))
AS
	IF(@dni_persona = '')
		BEGIN
			SELECT message = 'El campo dni viene vacio', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Cedula_Persona' = dni_persona , 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
				'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1
			FROM Persona
			WHERE dni_persona = @dni_persona
			ORDER BY dni_persona ASC;
		END
GO


CREATE PROC SP_Obtener_Pacientes
AS
	SELECT 'Id_Paciente' = id_paciente, 'Numero_Seguro_Social' = numero_seguro_social , 'Fecha_Ingreso' = fecha_ingreso, 'Cedula_Persona' = Paciente.dni_persona, 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
	'Segundo_Apellido' = apellido_2, ok = 1
	FROM Paciente
	INNER JOIN Persona
	ON Persona.dni_persona = Paciente.dni_persona
	WHERE estado_paciente = 1
	ORDER BY id_paciente ASC;
GO

CREATE PROC SP_Obtener_Paciente_Por_Id
	(@id_paciente VARCHAR(12))
AS
	IF(@id_paciente = '')
		BEGIN
			SELECT message = 'El campo id_paciente viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0)
		BEGIN
			SELECT message = 'El campo id_paciente no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Paciente' = id_paciente, 'Numero_Seguro_Social' = numero_seguro_social , 'Fecha_Ingreso' = fecha_ingreso, 'Cedula_Persona' = Paciente.dni_persona, 
			'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1, 'Segundo_Apellido' = apellido_2, 'Edad' = edad , ok = 1
			FROM Paciente
			INNER JOIN Persona
			ON Persona.dni_persona = Paciente.dni_persona
			WHERE id_paciente = @id_paciente
			ORDER BY id_paciente ASC;
		END
GO


CREATE PROC SP_Obtener_Unidades
AS
	SELECT 'Id_Unidad' = id_unidad, 'Nombre_Unidad' = nombre_unidad , 'Numero_Planta' = numero_planta, ok = 1
	FROM Unidad
	ORDER BY id_unidad ASC;
GO

CREATE PROC SP_Obtener_Unidade_Por_Id
	(@id_unidad VARCHAR(12))
AS
	IF(@id_unidad = '')
		BEGIN
			SELECT message = 'El campo id_unidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_unidad) = 0)
		BEGIN
			SELECT message = 'El campo id_unidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Unidad' = id_unidad, 'Nombre_Unidad' = nombre_unidad , 'Numero_Planta' = numero_planta, 'Id_Medico' = id_medico, ok = 1
			FROM Unidad
			WHERE id_unidad = @id_unidad
			ORDER BY id_unidad ASC;
		END
GO

CREATE PROC SP_Obtener_Medicos
AS
	SELECT 'Id_Medico' = id_medico, 'Codigo_Medico' = codigo_medico , 'Cedula_Persona' = Medico.dni_persona, 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
	'Segundo_Apellido' = apellido_2, 'Edad' = edad, 'Estado' = estado ,ok = 1	FROM Medico
	INNER JOIN Persona
	ON Persona.dni_persona = Medico.dni_persona
	WHERE estado = 1
	ORDER BY id_medico ASC;
GO


CREATE PROC SP_Obtener_Medicos_Por_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id_medico viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id_medico no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Medico' = id_medico, 'Codigo_Medico' = codigo_medico , 'Cedula_Persona' = Medico.dni_persona, 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
			'Segundo_Apellido' = apellido_2, 'Edad' = edad, 'Estado' = estado ,ok = 1
			FROM Medico
			INNER JOIN Persona
			ON Persona.dni_persona = Medico.dni_persona
			WHERE id_medico = @id_medico
			ORDER BY id_medico ASC;
		END
GO

CREATE PROC SP_Obtener_Roles
AS
	SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
	FROM Roles
	ORDER BY id_role ASC;
GO

CREATE PROC SP_Obtener_Role_Por_ID
	(@IdRole VARCHAR)
AS
	IF(@IdRole = '')
		BEGIN
			SELECT message = 'El campo id_role viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdRole) = 0)
		BEGIN
			SELECT message = 'El campo id_role no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
			FROM Roles
			WHERE id_role = @IdRole
			ORDER BY id_role ASC;
		END
GO

CREATE PROC SP_Obtener_Role_Por_Nombre
	(@NombreRole VARCHAR(100))
AS
	IF(@NombreRole = '')
		BEGIN
			SELECT message = 'El campo nombre_role viene vacio', ok = 0
		END
	ELSE IF EXISTS(SELECT nombre_role FROM Roles WHERE Roles.nombre_role = @NombreRole)
		BEGIN
			SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
			FROM Roles
			WHERE nombre_role = @NombreRole
			ORDER BY id_role ASC;
		END
	ELSE
		BEGIN
			SELECT message = 'No existe el role', ok = 0
		END
GO

CREATE PROC SP_Obtener_Consultas
AS
	SELECT 'Id_Consulta' = id_consulta, 'Fehca_Consulta' = fecha_consulta , descripcion , 'Id_Paciente' = id_paciente, 
	'Id_Medico' = id_medico, 'Id_Unidad' = id_unidad ,'Estado_Consulta'=estado_consulta,ok = 1
	FROM Consulta
	WHERE estado_consulta = 1
	ORDER BY id_consulta ASC;
GO


CREATE PROC SP_Obtener_Consultas_Por_Paciente_Id
	(@Id_paciente VARCHAR(5))
AS
	SELECT 'Id_Consulta' = id_consulta, 'Fehca_Consulta' = fecha_consulta , descripcion , 'Id_Paciente' = id_paciente, 
	'Id_Medico' = id_medico, 'Id_Unidad' = id_unidad ,ok = 1
	FROM Consulta
	WHERE id_paciente = @Id_paciente 
	ORDER BY id_consulta ASC;
GO

USE GUANA_HOSPI
GO
CREATE PROC SP_Obtener_Consulta_Por_Id
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
		BEGIN
			SELECT message = 'El campo id_consulta viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'El campo id_consulta no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Consulta' = id_consulta, 'Id_Unidad' = id_unidad, 'Fehca_Consulta' = fecha_consulta , 'Descripcion' = Consulta.descripcion, 'Id_Paciente' = Paciente.id_paciente,
			'Nombre_Persona' = Persona.nombre_persona, 'Apellido_Uno' = Persona.apellido_1, 'Apellido_Dos' = Persona.apellido_2,ok = 1
			FROM Consulta 
			INNER JOIN Paciente ON Consulta.id_paciente = Paciente.id_paciente
			INNER JOIN Persona ON Persona.dni_persona = Paciente.dni_persona
			WHERE id_consulta = @id_consulta
			ORDER BY id_consulta ASC;
		END
GO


CREATE PROC SP_Obtener_Enfermedades
AS
	SELECT 'Id_Enfermedad' = id_enfermedad, 'Nombre_Enfermedad' = nombre_enfermedad, ok = 1
	FROM Enfermedad
	ORDER BY id_enfermedad ASC;
GO

CREATE PROCEDURE SP_Obtener_Enfermedades_Por_Id_Paciente_Y_Consulta_Id
	(@id_paciente VARCHAR(12), @id_consulta VARCHAR(12))
AS
	IF(@id_paciente = '')
		BEGIN
			SELECT MESSAGE = 'El id del paciente esta vacio', ok = 0
		END
	ELSE IF(@id_consulta = '')
		BEGIN
			SELECT MESSAGE = 'El id de la consulta esta vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0)
		BEGIN
			SELECT message = 'El campo del id paciente no es numerico'
		END
	ELSE IF(ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'El campo del id consulta no es numerico'
		END
	ELSE
		BEGIN
			SELECT 'Id_Enfermedad' = Enfermedad.id_enfermedad, 'Nombre_Enfermedad' = Enfermedad.nombre_enfermedad, 'Id_Consulta' = Padece.id_consulta, ok = 1
			FROM Enfermedad INNER JOIN Padece ON Enfermedad.id_enfermedad = Padece.id_enfermedad
			WHERE id_paciente = @id_paciente AND id_consulta = @id_consulta
			ORDER BY id_enfermedad ASC;
		END
GO

CREATE PROC SP_Obtener_Enfermedades_Por_Id
	(@id_enfermedad VARCHAR(12))
AS
	IF(@id_enfermedad = '')
		BEGIN
			SELECT message = 'El campo id_enfermedad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_enfermedad) = 0)
		BEGIN
			SELECT message = 'El campo id_enfermedad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Enfermedad' = id_enfermedad, 'Nombre_Enfermedad' = nombre_enfermedad, ok = 1
			FROM Enfermedad
			WHERE id_enfermedad = @id_enfermedad
			ORDER BY id_enfermedad ASC;
		END
GO

CREATE PROC SP_Obtener_Intervenciones
AS
	SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta, ok = 1
	FROM Intervenciones
	ORDER BY id_intervencion ASC;
GO

CREATE PROC SP_Obtener_Interv_Por_Id_Consulta
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta est? vac?o', ok = 0
	END
		ELSE IF(ISNUMERIC(@id_consulta) = 0)
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta no es n?merico'
	END
		ELSE
	BEGIN
		SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = Intervenciones.id_tipo_intervencion, 'Id_Consulta' = id_consulta, 'Nombre_Tipo_Intervencion' = Tipo_Intervencion.nombre_tipo_intervencion, ok = 1
		FROM Intervenciones
		INNER JOIN Tipo_Intervencion ON Tipo_Intervencion.id_tipo_intervencion = Intervenciones.id_tipo_intervencion
		WHERE id_consulta = @id_consulta
		ORDER BY id_intervencion ASC;
	END
GO


CREATE PROC SP_Obtener_Intervenciones_Por_Id
	(@id_intervencion VARCHAR(12))
AS
	IF(@id_intervencion = '')
		BEGIN
			SELECT message = 'El campo id_intervencion viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_intervencion) = 0)
		BEGIN
			SELECT message = 'El campo id_intervencion no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta, ok = 1
			FROM Intervenciones
			WHERE id_intervencion = @id_intervencion
			ORDER BY id_intervencion ASC;
		END
GO

CREATE PROC SP_Obtener_Especialidades
AS
	SELECT 'Id_Especialidad' = id_especialidad, 'Nombre_Especialidad' = nombre_especialdad, ok = 1
	FROM Especialidad
	ORDER BY id_especialidad ASC;
GO

CREATE PROC SP_Obtener_Especialidades_Por_Id
	(@id_especialidad VARCHAR(12))
AS
	IF(@id_especialidad = '')
		BEGIN
			SELECT message = 'El campo id_especialidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_especialidad) = 0)
		BEGIN
			SELECT message = 'El campo id_especialidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Especialidad' = id_especialidad, 'Nombre_Especialidad' = nombre_especialdad, ok = 1
			FROM Especialidad
			WHERE id_especialidad = @id_especialidad
			ORDER BY id_especialidad ASC;
		END
GO

CREATE PROC SP_Obtener_Especialidades_Por_Medico_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id medico viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id medico no es numerico', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			SELECT message = 'El id del medico no existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Especialidad' = e.id_especialidad, 'Nombre_Especialidad' = e.nombre_especialdad, ok = 1
			FROM Especialidad e
			INNER JOIN Medico_Especialidad me ON e.id_especialidad = me.id_especialidad
			WHERE me.id_medico = @id_medico
			ORDER BY e.id_especialidad ASC;
		END
GO

CREATE PROC SP_Obtener_Padece
AS
	SELECT 'Id_Padece' = id_padece, 'Id_Paciente' = id_paciente, 'Id_Enfermedad' = id_enfermedad, 'Id_Consulta' = id_consulta, ok = 1
	FROM Padece
	ORDER BY id_padece ASC;
GO

CREATE PROC SP_Obtener_Padece_Por_Id
	(@id_padece VARCHAR(12))
AS
	IF(@id_padece = '')
		BEGIN
			SELECT message = 'El campo id_padece viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_padece) = 0)
		BEGIN
			SELECT message = 'El campo id_padece no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Padece' = id_padece, 'Id_Paciente' = id_paciente, 'Id_Enfermedad' = id_enfermedad,'Id_Consulta' id_consulta,ok = 1
			FROM Padece
			WHERE id_padece = @id_padece
			ORDER BY id_padece ASC;
		END
GO

CREATE PROC SP_Obtener_Tipos_Intervenciones
AS
	SELECT 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = nombre_tipo_intervencion, ok = 1
	FROM Tipo_Intervencion
	ORDER BY id_tipo_intervencion ASC;
GO

CREATE PROC SP_Obtener_Tipo_Intervencion_Por_Id_Consulta
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta est? vac?o', ok = 0
	END
		ELSE IF(ISNUMERIC(@id_consulta) = 0)
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta no es n?merico'
	END
		ELSE
	BEGIN
		SELECT 'Id_Tipo_Intervencion' = Tipo_Intervencion.id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = Tipo_Intervencion.nombre_tipo_intervencion, ok = 1
		FROM Tipo_Intervencion INNER JOIN Intervenciones ON Tipo_Intervencion.id_tipo_intervencion = Intervenciones.id_tipo_intervencion
		WHERE id_consulta = @id_consulta
		ORDER BY id_tipo_intervencion ASC;
	END
GO

CREATE PROC SP_Obtener_Tipos_Intervencione_Por_Id
	(@id_tipo_intervencion VARCHAR(12))
AS
	IF(@id_tipo_intervencion = '')
		BEGIN
			SELECT message = 'El campo id_tipo_intervencion viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_tipo_intervencion) = 0)
		BEGIN
			SELECT message = 'El campo id_tipo_intervencion no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = nombre_tipo_intervencion, ok = 1
			FROM Tipo_Intervencion
			WHERE id_tipo_intervencion = @id_tipo_intervencion
			ORDER BY id_tipo_intervencion ASC;
		END
GO

CREATE PROC SP_Obtener_Medico_Especialidad
AS
	SELECT 'Id_Medico_Especialidad' = id_medico_especialidad, 'Id_Medico' = id_medico, 'Id_Especialidad' = id_especialidad, ok = 1
	FROM Medico_Especialidad
	ORDER BY id_medico_especialidad ASC;
GO

USE GUANA_HOSPI
GO
CREATE PROC SP_Obtener_Medico_Especialidad_Por_Medico_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id_medico_especialidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id_medico_especialidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Medico_Especialidad' = id_medico_especialidad, 'Id_Medico' = id_medico, 'Id_Especialidad' = id_especialidad, ok = 1
			FROM Medico_Especialidad
			WHERE id_medico = @id_medico
			ORDER BY id_medico_especialidad ASC;
		END
GO

CREATE PROC SP_Obtener_Auditoria
AS
	SELECT 'Email' = Usuario, 'Fecha' = Fecha, 'Accion' = Descripcion, ok = 1
	FROM Auditoria
	ORDER BY Fecha ASC;
GO
-----------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPersona
    @Dni VARCHAR(12),
	@Nombre VARCHAR(30),
	@Apellido1 VARCHAR(40),
	@Apellido2 VARCHAR(40),
	@Edad VARCHAR(20),
	@Id_Usuario VARCHAR(12)
AS
	IF (@Dni = '')
		BEGIN
			SELECT message = 'El DNI no puede ser nulo', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona = @Dni))
		BEGIN
			IF ((@Nombre = '') OR ( @Apellido1 = '') OR (@Apellido2 = '') OR (@Edad = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La persona se a editado exitosamente!', ok = 1
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Persona
						Set	nombre_persona = @Nombre,
							apellido_1 = @Apellido1,
							apellido_2 = @Apellido2,
							edad = CONVERT(int, @Edad)
						WHERE dni_persona = @Dni
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN
			SELECT message = 'La cedula de la persona no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarMedico
	@id_medico VARCHAR(12),
	@codigo_medico INT,
	@dni_persona VARCHAR(12),
	@Id_Usuario VARCHAR(12)
	AS
	IF (@id_medico = '')
		BEGIN
			SELECT message = 'El id del medico no puede ser nulo', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico', ok = 0;
		END
	ELSE IF EXISTS(SELECT Medico.dni_persona FROM Medico WHERE Medico.dni_persona = @dni_persona)
		BEGIN
			SELECT message = 'El DNI de persona ya esta registrado', ok = 0
		END
	ELSE IF EXISTS(SELECT Medico.codigo_medico FROM Medico WHERE Medico.codigo_medico = @codigo_medico)
		BEGIN
			SELECT message = 'El codigo medico ya esta registrado', ok = 0
		END
	ELSE IF ( EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			IF ((@codigo_medico = '') OR (@dni_persona = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El medico se ha actualizado exitosamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Medico
						Set	codigo_medico = @codigo_medico,
							dni_persona = @dni_persona
						WHERE id_medico = convert(int,@id_medico)
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN
			SELECT message = 'El id del medico no existe', ok = 0;
		END
GO

USE GUANA_HOSPI
GO

CREATE PROC SP_Actualizar_Role
	@Id INT,
	@NombreRole VARCHAR
AS
	IF(@NombreRole = '' OR @Id = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF (EXISTS(SELECT nombre_role FROM Roles WHERE nombre_role = @NombreRole))
		BEGIN
			SELECT message = 'El role se ha actualizado correctamente', ok = 1
			UPDATE Roles
				SET nombre_role = @NombreRole
			WHERE id_role = @Id
		END
	ELSE
		BEGIN
			SELECT message = 'No existe el role', ok = 0
		END
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarEspecialidad
	@id_especialidad VARCHAR(12),
	@nombreEspecialdad VARCHAR(50),
	@Id_Usuario VARCHAR(12)
AS
	IF(@id_especialidad = '')
		BEGIN
			SELECT message = 'El id de la especialidad no puede ser vacio ', ok = 0;			
		END
	ELSE IF (ISNUMERIC(@id_especialidad) = 0)
		BEGIN
			SELECT message = 'El id de la especialidad debe ser numerico', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @id_especialidad))
		BEGIN
			IF (@nombreEspecialdad = '')
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La especialidad ha sido editada exitosamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Especialidad
						Set	nombre_especialdad = @nombreEspecialdad
						WHERE id_especialidad = convert(int,@id_especialidad)
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN
		SELECT message = 'El id de la especialidad no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarUnidad
	@id_unidad Varchar(12),
	@nombre VARCHAR(50),
	@numeroPlanta INT,
	@Id_Medico varchar = NULL,
	@Id_Usuario Varchar(12)
	AS
	IF (@id_unidad = '')
		BEGIN
			SELECT message = 'El id de la Unidad no puede ser vacio', ok = 0;
		END
	ELSE IF((ISNUMERIC(@id_unidad) = 0) OR @Id_Medico <> NULL AND ISNUMERIC(@Id_Medico) = 0)
		BEGIN
			SELECT message = 'El id debe ser un dato numerico', ok = 0; 
		END
	ELSE IF ( EXISTS(SELECT Unidad.id_medico FROM Unidad WHERE Unidad.id_medico = @Id_Medico))
		BEGIN
			SELECT message = 'El medico ya tiene una unidad a cargo', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad))
		BEGIN
			IF ((@nombre = '') OR (@numeroPlanta = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La unidad ha sido editada con exito', ok = 1;
				    DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Unidad
						Set	nombre_unidad = @nombre,
						    numero_planta = @numeroPlanta,
							id_medico = @id_medico
						WHERE id_unidad = convert(int,@id_unidad)
						SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN
			SELECT message = 'El id de la Unidad no existe', ok = 0;
		END
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPaciente
	@id_paciente VARCHAR(12),
	@numeroSeguroSocial INT,
	@fecha_ingreso DATE,
	@dni_persona VARCHAR(12),
	@Id_Usuario VARCHAR(12)
	AS
	IF (@id_paciente = '')
		BEGIN
			SELECT message = 'El id del paciente no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
		END
	ELSE IF EXISTS(SELECT numero_seguro_social FROM Paciente WHERE numero_seguro_social = @numeroSeguroSocial)
		BEGIN
			SELECT message = 'El numero de seguro social ya habia registrado anteriormente', ok = 0
		END
	ELSE IF EXISTS(SELECT Paciente.dni_persona FROM Paciente WHERE Paciente.dni_persona = @dni_persona)
		BEGIN
			SELECT message = 'El DNI de persona ya esta registrado', ok = 0
		END
	ELSE IF ( EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @id_paciente))
		BEGIN
			IF ((@numeroSeguroSocial = '') OR (@fecha_ingreso='')OR (@dni_persona ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El Paciente ha sido editado correctamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Paciente
						Set	numero_seguro_social = @numeroSeguroSocial,
						fecha_ingreso = @fecha_ingreso,
						dni_persona = @dni_persona
						WHERE id_paciente = convert(int,@id_paciente)
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del Paciente no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarConsulta
	@id_consulta VARCHAR(12) ,
	@descripcion varchar(150),
	@id_paciente INT,
	@id_unidad INT,
	@id_medico INT,
	@Id_Usuario VARCHAR(12)
	AS
	IF (@id_consulta = '')
		BEGIN
			SELECT message = 'El id de la consulta no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico', ok = 0; 
		END
	ELSE IF ( EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @id_consulta))
		BEGIN
			IF(@id_paciente='')
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico)
				BEGIN
		    		SELECT message = 'El id de medico no existe', ok = 0;
				END
			ELSE IF NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @id_paciente)
				BEGIN
					SELECT message = 'El id de paciente no existe', ok = 0;
				END
			ELSE IF NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad)
				BEGIN
					SELECT message = 'El id de la consulta no existe', ok = 0;
				END
		ELSE 
		BEGIN
			SELECT message = 'La consulta ha sido editada correctamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Consulta
						Set	fecha_consulta = GETDATE(),
						descripcion = @descripcion,
						id_paciente = @id_paciente,
						id_unidad = @id_unidad,
						id_medico = @id_medico
						WHERE id_consulta = convert(int,@id_consulta)
					SET CONTEXT_INFO 0x0
		END
	END
	ELSE
        BEGIN	
			SELECT message = 'El id de la consulta no existe', ok = 0;
		END
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarEnfermedad
	@id_enfermedad VARCHAR(12),
	@nombre VARCHAR(50),
	@Id_Usuario VARCHAR(12)
	AS
	IF (@id_enfermedad = '')
		BEGIN
			SELECT message = 'El id de la enfermedad no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_enfermedad) = 0)
		BEGIN
			SELECT message = 'El id debe ser positivo', ok = 0; 
		END
	ELSE IF ( EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La enfermedad ha sido editada correctamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Enfermedad
						Set	nombre_enfermedad = @nombre
						WHERE id_enfermedad = convert(int,@id_enfermedad)
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de la enfermedad no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPadece
	@id_padece varchar(10),
	@id_paciente INT,
	@id_enfermedad INT,
	@id_consulta varchar(10)
	AS
	IF (@id_padece = '')
		BEGIN
			SELECT message = 'El id del padecimiento no puede ser vacio', ok = 0;
		END
	ELSE IF((ISNUMERIC(@id_padece) = 0) OR (ISNUMERIC(@id_consulta) = 0))
		BEGIN
			SELECT message = 'El id debe ser numerico', ok = 0;
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @id_paciente))
		BEGIN
			SELECT message = 'El id del paciente no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad))
		BEGIN
			SELECT message = 'El id de la enfermedad no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @id_consulta))
		BEGIN
			SELECT message = 'El id de la consulta no existe', ok = 0
		END
	ELSE IF ( EXISTS(SELECT id_padece FROM Padece WHERE id_padece = @id_padece))
		BEGIN
			IF ((@id_paciente = '') OR (@id_enfermedad='') OR (@id_consulta = '')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
					SELECT message = 'El padecimiento ha sido editado correctamente', ok = 1;
					UPDATE Padece
						Set	id_paciente = @id_paciente,
						id_enfermedad = @id_enfermedad,
						id_consulta = convert(int,@id_consulta)
						WHERE id_padece = convert(int,@id_padece)
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del Padecimiento no existe', ok = 0;
		END
GO




USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarTipoIntervension
	@id_tipo_Intervencion VARCHAR(50),
	@nombre VARCHAR(50),
	@Id_Usuario VARCHAR(12)
	AS
	IF (@id_tipo_Intervencion = '')
		BEGIN
			SELECT message = 'El id del tipo de intervencion no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_tipo_Intervencion) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
		END
	ELSE IF ( EXISTS(SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @id_tipo_Intervencion))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El tipo de intervencion ha sido editado correctamente', ok = 1;
					DECLARE @Id_Usuario_Hexa VARBINARY(128)
					SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
					SET CONTEXT_INFO @Id_Usuario_Hexa
					UPDATE Tipo_Intervencion
						Set	nombre_tipo_intervencion = @nombre
						WHERE id_tipo_intervencion = convert(int,@id_tipo_Intervencion)
					SET CONTEXT_INFO 0x0
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del tipo-intervencion no existe', ok = 0;
		END
GO






USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarIntervencion
	@id_intervencion varchar(12),
	@tratamiento VARCHAR(150),
	@id_tipo_intervencion INT,
	@id_consulta INT
	AS
	IF (@id_intervencion = '')
		BEGIN
			SELECT message = 'El id de la intervenci?n no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_intervencion) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico', ok = 0;
		END
	ELSE IF (NOT EXISTS(SELECT Intervenciones.id_consulta FROM Intervencion WHERE Intervenciones.id_consulta = @id_consulta))
		BEGIN
			SELECT message = 'El id de la consulta no existe', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_intervencion FROM Intervencion WHERE id_intervencion = @id_intervencion))
		BEGIN
			IF ((@tratamiento = '')OR(@id_tipo_intervencion ='')OR(@id_consulta ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La intevencion ha sido editada correctamente', ok = 1;
					UPDATE Intervencion
						Set	tratamiento = @tratamiento,
						id_tipo_intervencion = @id_tipo_intervencion,
						id_consulta = @id_consulta
						WHERE id_intervencion = convert(int,@id_intervencion)
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de la intervencion no existe', ok = 0;
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarMedicoEspecialidad
	@id_medico_especialidad varchar(12),
	@id_medico INT,
	@id_especialidad INT
	AS
	IF (@id_medico_especialidad = '')
		BEGIN
			SELECT message = 'El id del Medico-especialidad no puede ser vacio', ok = 0;
		END
	ELSE IF(ISNUMERIC(@id_medico_especialidad) = 0)
		BEGIN
			SELECT message = 'El id debe ser numerico', ok = 0;
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			SELECT message = 'El id medico no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @id_especialidad))
		BEGIN
			SELECT message = 'El id de la especialidad no existe', ok = 0
		END
	ELSE IF(EXISTS(SELECT id_medico, id_especialidad FROM Medico_Especialidad WHERE id_especialidad = @id_especialidad AND id_medico = @id_medico))
		BEGIN
			SELECT message = 'El medico ya tiene una especialidad', ok = 0
		END
	ELSE IF ( EXISTS(SELECT id_medico_especialidad FROM Medico_Especialidad WHERE id_medico_especialidad = @id_medico_especialidad))
		BEGIN
			IF ((@id_medico = '')OR(@id_especialidad ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El medico-especialidad ha sido editada correctamente', ok = 1;
					UPDATE Medico_Especialidad
						Set	id_medico = @id_medico,
						id_especialidad = @id_especialidad
						WHERE id_medico_especialidad = convert(int,@id_medico_especialidad)
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de medico-especialidad no existe', ok = 0;
		END
GO

USE GUANA_HOSPI 
GO
CREATE PROC SP_Actaulizar_User
	@email VARCHAR(100),
	@password VARCHAR(100),
	@Id_Usuario VARCHAR(12)
    AS
	IF(@email = '')
	 BEGIN
		SELECT message = 'El email no puede ser vacio', ok = 0;
	 END
	 ELSE IF( EXISTS(SELECT email from users WHERE @email=email))
		BEGIN
		  SELECT message = 'El usuario se ha actualizado correctamente', ok = 1;
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
		    SET CONTEXT_INFO @Id_Usuario_Hexa
			UPDATE users
				Set email = @email,
				password = @password
				WHERE email = @email
			SET CONTEXT_INFO 0x0
		END
	 ELSE
		BEGIN
			SELECT message = 'El usuario no exite', ok = 0;
		END

GO


USE GUANA_HOSPI 
GO
CREATE PROC SP_Actaulizar_User_Correo
	@id INT,
	@email VARCHAR(100),
	@Id_Usuario VARCHAR(12)
    AS
	IF(@id = '')
	 BEGIN
		SELECT message = 'El id no puede ser vacio', ok = 0;
	 END
	 ELSE IF( EXISTS(SELECT email from users WHERE @id=id))
		BEGIN
		  SELECT message = 'El usuario se ha actualizado correctamente', ok = 1;
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
		    SET CONTEXT_INFO @Id_Usuario_Hexa
			UPDATE users
				Set email = @email
				WHERE id = @id
			SET CONTEXT_INFO 0x0
		END
	 ELSE
		BEGIN
			SELECT message = 'El usuario no exite', ok = 0;
		END
GO
-------------------------------------------------------------------------------------------
USE MASTER
GO 
	CREATE DATABASE  DW_GUANA_HOSPI
	ON PRIMARY
	(NAME = 'DW_GUANA_HOSPI_Data',
	FILENAME= 'D:\SQLData\DW_GUANA_HOSPI_Data.Mdf',
	SIZE = 5Mb,
	MAXSIZE = 10Mb,
	FILEGROWTH = 1Mb)
	LOG ON
	(NAME = 'DW_GUANA_HOSPI_Log',
	FILENAME= 'D:\SQLLog\DW_GUANA_HOSPI_Log.Ldf',
	SIZE = 5Mb,
	MAXSIZE = 10Mb,
	FILEGROWTH = 1Mb)
GO


USE	DW_GUANA_HOSPI
GO
CREATE TABLE Persona(
    dni_persona VARCHAR(12),
	nombre_persona VARCHAR(40),
	apellido_1 VARCHAR(40),
	apellido_2 VARCHAR(40),
	edad INT,
	CONSTRAINT PK_dni PRIMARY KEY (dni_persona),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Medico(
    id_medico INT,
	codigo_medico INT,
	dni_persona VARCHAR(12),
	estado BIT,
	CONSTRAINT PK_id_medico PRIMARY KEY (id_medico)
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Unidad(
	id_unidad INT,
	nombre_unidad VARCHAR(50),
	numero_planta INT ,
	id_medico INT,
	CONSTRAINT PK_id_unidad PRIMARY KEY (id_unidad),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Consulta(
	id_consulta INT,
	fecha_consulta DATE,
	descripcion varchar(150),
	id_paciente INT,
	id_unidad INT,
	id_medico INT,
	estado BIT
	CONSTRAINT PK_id_consulta PRIMARY KEY (id_consulta)
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Enfermedad(
	id_enfermedad INT,
	nombre_enfermedad VARCHAR(50),
	CONSTRAINT PK_id_enfermedad PRIMARY KEY (id_enfermedad),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Padece(
	id_padece INT,
	id_paciente INT,
	id_enfermedad INT,
	id_consulta INT,
	CONSTRAINT PK_id_padece PRIMARY KEY (id_padece)
)

USE	DW_GUANA_HOSPI
GO	
CREATE TABLE Tipo_Intervencion(
	id_tipo_intervencion INT,
	nombre_tipo_intervencion VARCHAR(50),
	CONSTRAINT PK_id_tipo_intervension PRIMARY KEY (id_tipo_intervencion),
)
GO

USE	DW_GUANA_HOSPI
GO
CREATE TABLE Intervenciones(
	id_intervencion INT,
	tratamiento VARCHAR(150),
	id_tipo_intervencion INT,
	id_consulta INT,
	CONSTRAINT PK_id_intervencion PRIMARY KEY (id_intervencion)
)
GO

use GUANA_HOSPI
go
select * from Consulta

use DW_GUANA_HOSPI
go
select * from Consulta
---------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Eliminar_Tablas_DW
AS
	SELECT message = 'Se elimino los datos exitosamente', ok = 1
	DELETE FROM DW_GUANA_HOSPI..Consulta;
	DELETE FROM DW_GUANA_HOSPI..Enfermedad
	DELETE FROM DW_GUANA_HOSPI..Intervenciones
	DELETE FROM DW_GUANA_HOSPI..Medico
	DELETE FROM DW_GUANA_HOSPI..Padece
	DELETE FROM DW_GUANA_HOSPI..Persona
	DELETE FROM DW_GUANA_HOSPI..Tipo_Intervencion
	DELETE FROM DW_GUANA_HOSPI..Unidad
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_LLenarDW
AS

	SELECT message = 'Se cargaron los datos exitosamente', ok = 1
	EXEC SP_Eliminar_Tablas_DW
	
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Consulta OUT C:\BCP\Consulta.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Enfermedad OUT C:\BCP\Enfermedad.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Intervenciones OUT C:\BCP\Intervenciones.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Medico OUT C:\BCP\Medico.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Padece OUT C:\BCP\Padece.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Persona OUT C:\BCP\Persona.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Tipo_Intervencion OUT C:\BCP\Tipo_Intervencion.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Unidad OUT C:\BCP\Unidad.txt -T -c'

	BULK INSERT DW_GUANA_HOSPI.dbo.Consulta  FROM 'C:\BCP\Consulta.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Enfermedad FROM 'C:\BCP\Enfermedad.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Intervenciones FROM 'C:\BCP\Intervenciones.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Medico FROM 'C:\BCP\Medico.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Padece FROM 'C:\BCP\Padece.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Persona FROM 'C:\BCP\Persona.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Tipo_Intervencion FROM 'C:\BCP\Tipo_Intervencion.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Unidad FROM 'C:\BCP\Unidad.txt'
GO
--EXEC SP_LLenarDW
	
--EXEC SP_Eliminar_Tablas_DW

--    use GUANA_HOSPI
--	go
--	drop procedure SP_Eliminar_Tablas_DW
--	drop procedure SP_LLenarDW
---------------------------------------------------------------------------------

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Enfermedades
AS
		SELECT TOP 5 e.nombre_enfermedad, COUNT(p.id_enfermedad) AS Cantidad, 'Id_Enfermedad' = e.id_enfermedad
			FROM DW_GUANA_HOSPI.DBO.Enfermedad e 
			INNER JOIN DW_GUANA_HOSPI.DBO.Padece p
			ON e.id_enfermedad = p.id_enfermedad
		GROUP BY e.nombre_enfermedad, e.id_enfermedad
		ORDER BY COUNT(p.id_enfermedad) DESC 	
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Unidades
AS
		SELECT TOP 3 u.nombre_unidad, u.numero_planta, u.id_unidad, 'Cantidad' = COUNT(c.id_unidad)
			FROM DW_GUANA_HOSPI.DBO.Unidad u 
			INNER JOIN DW_GUANA_HOSPI.DBO.Consulta c
			ON u.id_unidad = c.id_unidad
		GROUP BY u.nombre_unidad, u.numero_planta, u.id_unidad
		ORDER BY COUNT(c.id_paciente) DESC 	
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Medico_Intervenciones
AS
	SELECT TOP 1 m.codigo_medico, p.dni_persona, p.nombre_persona, p.apellido_1, 
		p.apellido_2, 'Cantidad' = COUNT(i.id_intervencion)
		FROM DW_GUANA_HOSPI.DBO.Medico m 
		INNER JOIN DW_GUANA_HOSPI.DBO.Persona p ON m.dni_persona = p.dni_persona
		INNER JOIN DW_GUANA_HOSPI.DBO.Consulta co ON co.id_medico = m.id_medico	
		INNER JOIN DW_GUANA_HOSPI.DBO.Intervenciones i ON i.id_consulta = co.id_consulta
	GROUP BY m.codigo_medico, p.dni_persona, p.nombre_persona, p.apellido_1, p.apellido_2
	ORDER BY COUNT(i.id_intervencion) DESC
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Tipo_Intervenciones
AS
	SELECT TOP 5 ti.nombre_tipo_intervencion, i.tratamiento, ti.id_tipo_intervencion FROM DW_GUANA_HOSPI.DBO.Tipo_Intervencion ti
		INNER JOIN DW_GUANA_HOSPI.DBO.Intervenciones i ON ti.id_tipo_intervencion = i.id_tipo_intervencion
	GROUP BY ti.nombre_tipo_intervencion, i.tratamiento, ti.id_tipo_intervencion
	ORDER BY COUNT(i.id_intervencion) DESC
GO
-----------------------------------------------------------------------------------------------------------


USE GUANA_HOSPI
GO
-------------------------REGRISTRO DE INSERTAR--------------------------------
CREATE TRIGGER TR_Insertar_Medico
ON Medico AFTER INSERT
 AS
     DECLARE @Id_Usuario NVARCHAR
	 DECLARE @Email NVARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha Creado Un Medico!!')

GO

CREATE TRIGGER TR_Insertar_Paciente
On Paciente AFTER INSERT
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Agregado Un Nuevo Paciente!!')
 GO

CREATE TRIGGER TR_Insertar_Unidad
 ON Unidad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Agregado Una Nueva Unidad!!')
 GO

CREATE TRIGGER TR_Insertar_Especialidad
 ON Especialidad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Una Especialidad!!')
  GO


CREATE TRIGGER TR_Insertar_Enfermadades
ON Enfermedad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Una Enfermedad!!')
  GO




CREATE TRIGGER TR_Insetar_Tipo_Intervencion
ON Tipo_Intervencion AFTER INSERT
	AS
		DECLARE @Id_Usuario NVARCHAR
		DECLARE @Email NVARCHAR(MAX)
		SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
		SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
		INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Un Tipo De Intervención!!')
	GO



CREATE TRIGGER TR_Insertar_Consulta
ON Consulta AFTER INSERT
	AS
		DECLARE @Id_Usuario NVARCHAR
		DECLARE @Email NVARCHAR(MAX)
		SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
		SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
		INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Una Consulta a la lista!!')
	GO


CREATE TRIGGER TR_Insertar_Usuario
ON users AFTER INSERT
	AS
		DECLARE @Id_Usuario NVARCHAR
		DECLARE @Email NVARCHAR(MAX)
		SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
		SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
		INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Un Usuario!')
	GO



------------------------Registros De Actualizar-------------------------------
CREATE TRIGGER TR_Actualizar_Medico
ON Medico AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos Del Medico!!')
 GO


 CREATE TRIGGER TR_Actualizar_Paciente
ON Paciente AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos Del Paciente!!')
 GO


  CREATE TRIGGER TR_Actualizar_Enfermedad
ON Enfermedad AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos De la Enfermedad!!')
 GO

   CREATE TRIGGER TR_Actualizar_Consulta
ON Consulta AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos De la Consulta!')
 GO


     CREATE TRIGGER TR_Actualizar_Especialidad
ON Especialidad AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Una Especialidad!')
 GO


     CREATE TRIGGER TR_Actualizar_Unidad
ON Unidad AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Una Unidad!')
 GO

CREATE TRIGGER TR_Actualizar_Tipo_Intervencion
 ON Tipo_Intervencion AFTER UPDATE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Un Tipo De Intervencion!')
 GO



 CREATE TRIGGER TR_Actualizar_User
 ON users AFTER UPDATE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Un Usuario!')
 GO
 



--------------------------ELIMINAR--------------------------
CREATE TRIGGER TR_Eliminar_Medico
ON Medico AFTER DELETE
 AS
     DECLARE @Id_Usuario NVARCHAR
	 DECLARE @Email NVARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha Eliminado Un Medico De La Lista!!')

GO


CREATE TRIGGER TR_Eliminar_Paciente
On Paciente AFTER DELETE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Al Paciente!!')
 GO



 CREATE TRIGGER TR_Eliminar_Unidad
 ON Unidad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Unidad De La Lista!!')
 GO

 CREATE TRIGGER TR_Eliminar_Especialidad
 ON Especialidad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Especialidad De La Lista!!')
  GO

  CREATE TRIGGER TR_Elimina_Enfermadades
ON Enfermedad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Enfermedad!!')
  GO


    CREATE TRIGGER TR_Eliminar_Tipo_Intervension
ON Tipo_Intervencion AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Enfermedad!!')
  GO


CREATE TRIGGER TR_Eliminar_Usuario
ON users AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Un Usuario!')
  GO

CREATE TRIGGER TR_Eliminar_Consulta
ON Consulta AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Consulta!')
  GO

-- DROP TRIGGER TR_Actualizar_Persona   -- SELECT * FROM Auditoria



---------------------------------------------------------------------------------------------------------------

--use datos
--go
--Select Top 5 PROVINCIA, COUNT(PROVINCIA) AS PROVINCIA
--from rutas
--Group by PROVINCIA
--Order by count(PROVINCIA) desc

--EXEC  SP_Top_Enfermedades

--EXEC SP_Top_Unidades

--USE DW_GUANA_HOSPI
--GO
--	SELECT * FROM Unidad
--	SELECT * FROM Paciente_Unidad
--GO

--DROP PROC SP_Top_Medico_Intervenciones

--USE DW_GUANA_HOSPI
--GO
--SELECT * FROM Padece
--SELECT * FROM Enfermedad

--exec SP_Top_Medico_Intervenciones
--GO
--DROP PROCEDURE SP_Top_Enfermedades

use GUANA_HOSPI
go
----------------------------------------------------------------------
USE GUANA_HOSPI
GO
-----------------PERSONA--------------------------------
--dni_persona / nombre / apellido1 / apellido2 / edad

EXEC SP_Crear_Persona '1', 'Tatiana', 'Morales', 'Mendez', 19
EXEC SP_Crear_Persona '2', 'Luis', 'Rodriguez', 'Baltodano', 21
EXEC SP_Crear_Persona '3', 'Arlen', 'Vargas', 'Galvez', 19
EXEC SP_Crear_Persona '4', 'Ricardo', 'Morataya', 'Morataya', 20
EXEC SP_Crear_Persona '5', 'Enrique', 'Arias', 'Salgado', 20
EXEC SP_Crear_Persona '5022', 'Enrique', 'Arias', 'Salgado', 20

EXEC SP_Crear_Persona '6', 'Erick', 'Parra', 'Sequeira', 20
EXEC SP_Crear_Persona '7', 'Emilio', 'Galvez', 'Vargas', 45
EXEC SP_Crear_Persona '8', 'Daniel', 'Sequeira', 'Parra', 38
EXEC SP_Crear_Persona '9', 'Carlos', 'Salgado', 'Arias', 31
EXEC SP_Crear_Persona '10','Jafet', 'Morataya', 'Galvez', 51
EXEC SP_Crear_Persona '89','Jafet', 'Morataya', 'Galvez', 53

-----------------------Roles-------------------------------
--nombre_role

EXEC SP_Crear_Role 'Administrador'
EXEC SP_Crear_Role 'Medico'

-----------------------Usuario Administrador-------------------------------
-- La contraseña es: 12345678
--email / password / id_medico / id_role 

EXEC SP_Crear_User 'admin@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 1, null, 1
    

-----------------------MEDICO-------------------------------
--codigo_medico / dni_persona / estado(BIT 1 o 0) 

EXEC SP_Crear_Medico 1234, 1, 1
EXEC SP_Crear_Medico 2323, 2, 1
EXEC SP_Crear_Medico 5344, 3, 1
EXEC SP_Crear_Medico 6453, 4, 1
EXEC SP_Crear_Medico 4656, 5, 1
EXEC SP_Crear_Medico 4852, 89, 1

-----------------------Usuarios Medicos------------------------------

EXEC SP_Crear_User 'medico@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 1, 1
EXEC SP_Crear_User 'medico2@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 2, 1
EXEC SP_Crear_User 'medico3@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 3, 1
EXEC SP_Crear_User 'medico4@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 4, 1
EXEC SP_Crear_User 'medico5@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 5, 1


----------------------ESPECIALIDAD--------------------------
--nombre_especialidad / id_usuario 

EXEC SP_Crear_Especialidad 'Dermatologia', 1
EXEC SP_Crear_Especialidad 'Urologia', 1
EXEC SP_Crear_Especialidad 'Ginecologia', 1
EXEC SP_Crear_Especialidad 'Otorrinolaringologia', 1
EXEC SP_Crear_Especialidad 'Oftalmologia', 1

-----------------Medico Especialid--------------------------
--id_medico / id_especialidad

EXEC SP_Crear_Medico_Especialidad 1, 1
EXEC SP_Crear_Medico_Especialidad 2, 4
EXEC SP_Crear_Medico_Especialidad 2, 3
EXEC SP_Crear_Medico_Especialidad 2, 2
EXEC SP_Crear_Medico_Especialidad 3, 3
EXEC SP_Crear_Medico_Especialidad 4, 4
EXEC SP_Crear_Medico_Especialidad 5, 5

-----------------------UNIDAD-------------------------------
--nombre_unidad / numero_planta / id_medico / id_usuario

EXEC SP_Crear_Unidad 'Sala A1', 1, 1, 1
EXEC SP_Crear_Unidad 'Sala B1', 1, 2, 1
EXEC SP_Crear_Unidad 'Sala C1', 1, 3, 1
EXEC SP_Crear_Unidad 'Sala D1', 1, 4, 1
EXEC SP_Crear_Unidad 'Sala A2', 2, 5, 1
EXEC SP_Crear_Unidad 'Sala B2', 2, null, 1
EXEC SP_Crear_Unidad 'Sala C2', 2, null, 1
EXEC SP_Crear_Unidad 'Sala D2', 2, null, 1

-----------------------PACIENTE----------------------------------
--numero_seguro_social / fecha_ingreso / dni_persona / id_usuario

EXEC SP_Crear_Paciente 2332, '2020-11-08 23:22:46', '6', 1
EXEC SP_Crear_Paciente 3839, '2020-11-08 23:22:46', '7', 1
EXEC SP_Crear_Paciente 5022, '2020-11-08 23:22:46', '254', 1
EXEC SP_Crear_Paciente 4039, '2020-11-08 23:22:46', '8', 1
EXEC SP_Crear_Paciente 9284, '2020-11-08 23:22:46' ,'9', 1

-----------------------CONSULTA-----------------------------------
--descripcion / id_paciente / id_unidad / id_medico /estado_consulta/ id_usuario

EXEC SP_Crear_Consulta 'Se presentó con dolor', 1, 1, 1,1
EXEC SP_Crear_Consulta 'Pierna rota', 2, 2, 1, 1
EXEC SP_Crear_Consulta 'Brazo roto', 3, 3, 1, 2
EXEC SP_Crear_Consulta 'Dolor abdominal', 4, 4, 2, 2
EXEC SP_Crear_Consulta 'Sangrado anal', 1, 4, 2, 2
EXEC SP_Crear_Consulta 'Dolor de cabeza', 1, 4, 2, 3
----------------------ENFERMEDAD---------------------------------
--nombre_enfermedad / id_usuario / apellido1 / apellido2 / edad

EXEC SP_Crear_Enfermedad 'Cancer', 2
EXEC SP_Crear_Enfermedad 'Dengue', 2
EXEC SP_Crear_Enfermedad 'Cockbig', 2
EXEC SP_Crear_Enfermedad 'Asma', 2
EXEC SP_Crear_Enfermedad 'Ebola', 2
EXEC SP_Crear_Enfermedad 'Diabetes', 2
EXEC SP_Crear_Enfermedad 'Sida', 2
EXEC SP_Crear_Enfermedad 'Leucenia', 2

------------------------PADECE--------------------------------------
--id_paciente / id_enfermedad / id_consulta

EXEC SP_Crear_Padece 1, 1, 1
EXEC SP_Crear_Padece 2, 2, 2
EXEC SP_Crear_Padece 3, 3, 1
EXEC SP_Crear_Padece 4, 4, 3
EXEC SP_Crear_Padece 1, 1, 2
EXEC SP_Crear_Padece 2, 1, 1

--------------------------TIPO INTERVENCION--------------------------
--nombre_tipo_intervencion / id_usuario 

EXEC SP_Crear_Tipo_Intervencion 'Cirugia', 1
EXEC SP_Crear_Tipo_Intervencion 'Dieta', 1
EXEC SP_Crear_Tipo_Intervencion 'Ejercicio', 1
EXEC SP_Crear_Tipo_Intervencion 'Medicamento', 1
EXEC SP_Crear_Tipo_Intervencion 'Salud', 1

------------------------------INTERVENCION-----------------------------
--tratamiento / id_tipo_intervencion / id_consulta 

EXEC SP_Crear_Intervencion 'Tomar dos pastillas cada 6 horas', 1, 1
EXEC SP_Crear_Intervencion 'Comer frutas y tomar 2 litos de agua', 2, 2
EXEC SP_Crear_Intervencion 'Caminar 20 minutos por dia', 3, 3
EXEC SP_Crear_Intervencion 'Evitar comida chatarra', 4, 4

