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
			SELECT message = 'El registro se ha incresado corrnextnte',  beforeId = IDENT_CURRENT('Medico'), currentId = IDENT_CURRENT('Medico') + IDENT_INCR('Medico'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Medico(codigo_medico, dni_persona)
			VALUES (CONVERT(int, @CodigoMedico), @DniPersona)
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
			SELECT message = 'El registro se ha incresado corrnextnte',  beforeId = IDENT_CURRENT('Unidad'), currentId = IDENT_CURRENT('Unidad') + IDENT_INCR('Unidad'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Unidad(nombre_unidad, numero_planta, id_medico)
			VALUES (@Nombre, CONVERT(int, @numero_planta), @Id_Medico)
			SET CONTEXT_INFO 0x0
		END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Sintoma
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF (EXISTS(SELECT nombre_sintoma FROM Sintoma WHERE nombre_sintoma = @Nombre))
		BEGIN
			SELECT message = 'El sintoma ya habia sido registrado anteriormente', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correcnexte',  beforeId = IDENT_CURRENT('Sintoma'), currentId = IDENT_CURRENT('Sintoma') + IDENT_INCR('Sintoma'), ok = 1
			INSERT INTO Sintoma(nombre_sintoma)
			VALUES (@Nombre)
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Paciente(
	@Numero_seguro_social VARCHAR(8),
	@FechaIngreso VARCHAR(12),
	@DniPersona VARCHAR(12),
	@Id_Usuario VARCHAR(12)
)
AS
	IF(@Numero_seguro_social = '' OR @FechaIngreso = '' OR @DniPersona = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@Numero_seguro_social) = 0)
		BEGIN
			SELECT message = 'El numero de seguro social debe ser formato numero', ok = 0
		END
	ELSE IF EXISTS(SELECT numero_seguro_social FROM Paciente WHERE numero_seguro_social = @Numero_seguro_social)
		BEGIN
			SELECT message = 'El numero de seguro social ya habia registrado anteriormente', ok = 0
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
			SELECT message = 'El registro se ha incresado correctanext',  beforeId = IDENT_CURRENT('Paciente'), currentId = IDENT_CURRENT('Paciente') + IDENT_INCR('Paciente'), ok = 1
			DECLARE @Id_Usuario_Hexa VARBINARY(128)
			SET @Id_Usuario_Hexa = CAST(@Id_Usuario AS VARBINARY(128))
			SET CONTEXT_INFO @Id_Usuario_Hexa
			INSERT INTO Paciente(numero_seguro_social, fecha_ingreso, dni_persona)
			VALUES (CONVERT(int, @Numero_seguro_social), CONVERT(varchar, @FechaIngreso, 5), @DniPersona)
			SET CONTEXT_INFO 0x0
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Consulta
	@FechaConsulta VARCHAR(12),
	@IdPaciente VARCHAR(5),
	@IdUnidad VARCHAR(5)
AS
	IF(@FechaConsulta = '' OR @IdPaciente = '' OR @IdUnidad = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISDATE(@FechaConsulta) = 0)
		BEGIN
			SELECT message = 'La fecha de consulta debe ser un formato fecha valido', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdUnidad) = 0)
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
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctanext',  beforeId = IDENT_CURRENT('Consulta'), currentId = IDENT_CURRENT('Consulta') + IDENT_INCR('Consulta'), ok = 1
			INSERT INTO Consulta(fecha_consulta, id_paciente, id_unidad)
			VALUES (CONVERT(date, @FechaConsulta), CONVERT(int, @IdPaciente), CONVERT(int, @IdUnidad))
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Presenta
	@IdConsulta VARCHAR(5),
	@IdSintoma VARCHAR(5),
	@Descripcion VARCHAR(50)
AS
	IF(@IdConsulta = '' OR @IdSintoma = '' OR @Descripcion = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END  
	ELSE IF(ISNUMERIC(@IdConsulta) = 0 OR ISNUMERIC(@IdSintoma) = 0)
		BEGIN
			SELECT message = 'No se permiten caracteres', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			SELECT message = 'El id de la consulta no existe', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @IdSintoma))
		BEGIN
			SELECT message = 'El id del sintoma no existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado correctanext',  beforeId = IDENT_CURRENT('Presenta'), currentId = IDENT_CURRENT('Presenta') + IDENT_INCR('Presenta'), ok = 1
			INSERT INTO Presenta(id_consulta, id_sintoma, descripcion_presenta)
			VALUES (CONVERT(int, @IdConsulta), CONVERT(int, @IdSintoma), @Descripcion)
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
	@IdEnfermedad varchar(5)
AS
	IF(@IdPaciente = '' OR @IdEnfermedad = '')
		BEGIN
			SELECT message = 'No se permiten campos vacios', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdEnfermedad) = 0)
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
	ELSE
		BEGIN
			SELECT message = 'El registro se ha incresado corrnextnte',  beforeId = IDENT_CURRENT('Padece'), currentId = IDENT_CURRENT('Padece') + IDENT_INCR('Padece'), ok = 1
			INSERT INTO Padece(id_paciente, id_enfermedad)
			VALUES (CONVERT(int, @IdPaciente), CONVERT(int, @IdEnfermedad))
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
	@Descripcion VARCHAR(12)
AS
  
GO