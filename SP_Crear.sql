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
            SELECT message = 'LA EDAD DEBE SER DATOS NUMERICOS', ok = 0
        END
	ELSE IF (EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona= @Dni))
		BEGIN
			SELECT message = 'ESTE ID YA FUE REGISTRADO', ok = 0
		END
	ELSE
		BEGIN
			SELECT message = 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE', ok = 1
			INSERT INTO Persona( dni_persona, nombre_persona, apellido_1, apellido_2, edad)
			VALUES (@Dni, @Nombre, @Apellido1, @Apellido2, CONVERT(int, @Edad));
		END
GO

--------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Usuario
	@Nombre VARCHAR(40),
	@Contrasenna VARCHAR(30),
	@IdMedico VARCHAR(5)
AS
	IF(@Nombre = '' OR @Contrasenna = '' OR @IdMedico = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(EXISTS(SELECT nombre_usuario FROM Usuario WHERE nombre_usuario = @Nombre))
		BEGIN
			PRINT 'NOMBRE DE USUARIO YA EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL ID MEDICO NO EXISTE'
		END
	ELSE IF(EXISTS(SELECT id_medico FROM Usuario WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL MEDICO YA CUENTA CON UN USUARIO'
		END
	ELSE
		BEGIN
			INSERT INTO Usuario(nombre_usuario, contrasenna, id_medico)
			VALUES (@Nombre, @Contrasenna, CONVERT(int, @IdMedico))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
----------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Especialidad
	@NombreEspecialidad VARCHAR(30)
AS
	IF(@NombreEspecialidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(EXISTS(SELECT nombre_especialdad FROM Especialidad WHERE nombre_especialdad = @NombreEspecialidad))
		BEGIN
			PRINT 'LA ESPECIALIDAD YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Especialidad(nombre_especialdad)
			VALUES (@NombreEspecialidad)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Medico
	@CodigoMedico varchar(5),
	@DniPersona varchar(12)
AS
	IF(@CodigoMedico = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@CodigoMedico) = 0)
		BEGIN
			PRINT 'LOS DATOS DEBEN SER DE TIPO NUMERICO'
		END
	ELSE IF (NOT EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona=@DniPersona))
		BEGIN
			PRINT 'EL ID DE LA PERSONA NO EXISTE'
		END
	ELSE IF (EXISTS(SELECT dni_persona FROM Medico WHERE dni_persona=@DniPersona))
		BEGIN
			PRINT 'ESTA PERSONA YA ES UN MEDICO'
		END
	ELSE IF (EXISTS(SELECT codigo_medico FROM Medico WHERE codigo_medico = @CodigoMedico))
		BEGIN
			PRINT 'EL CODIGO MEDICO YA HA SIDO REGISTRADO'
		END
	ELSE 
		BEGIN
			INSERT INTO Medico(codigo_medico, dni_persona)
			VALUES (CONVERT(int, @CodigoMedico), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdMedico) = 0 OR ISNUMERIC(@IdEspecialidad) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL ID MEDICO NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @IdMedico))
		BEGIN
			PRINT 'EL ID DE LA ESPECIALIDAD NO EXISTE'
		END
	ELSE IF(EXISTS(SELECT id_medico, id_especialidad FROM Medico_Especialidad WHERE id_especialidad = @IdEspecialidad AND id_medico = @IdMedico))
		BEGIN
			PRINT 'EL MEDICO YA TIENE LA ESPECIALIDAD'
		END
	ELSE 
		BEGIN
			INSERT INTO Medico_Especialidad(id_medico, id_especialidad)
			VALUES (CONVERT(int, @IdMedico), CONVERT(int, @IdEspecialidad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
--------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Unidad
	@Nombre varchar(50),
	@Numero_planta varchar(5)
AS
	IF (@Nombre = '' OR @Numero_planta = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@Numero_planta) = 0)
	    BEGIN
            PRINT 'NO SE PERMITEN CARACTERES'
        END
	ELSE IF (EXISTS(SELECT nombre_unidad, numero_planta FROM Unidad WHERE nombre_unidad = @Nombre AND numero_planta = CONVERT(int, @Numero_planta)))
		BEGIN
			PRINT 'ESTA UNIDA YA HA SIDO REGISTRADA'
		END
	ELSE
		BEGIN
			INSERT INTO Unidad(nombre_unidad, numero_planta)
			VALUES (@Nombre, CONVERT(int, @numero_planta))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Unidad_Medico
	@IdUnidad varchar(5),
	@IdMedico varchar(5)
AS
	IF(@IdUnidad = '' OR @IdMedico = '')
		BEGIN 
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdUnidad) = 0 OR ISNUMERIC(@IdMedico) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'EL ID DE LA UNIDAD NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL ID DEL MEDICO NO EXISTE'
		END
	ELSE IF(EXISTS(SELECT id_medico FROM Unidad_Medico WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL MEDICO YA TIENE UNA UNIDAD'
		END
	ELSE IF(EXISTS(SELECT id_unidad FROM Unidad_Medico WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'LA UNIDAD SE ENCUENTRA OCUPADA'
		END
	ELSE
		BEGIN
			INSERT INTO Unidad_Medico(id_unidad, id_medico)
			VALUES (CONVERT(int, @IdUnidad), CONVERT(int, @IdMedico))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre_sintoma FROM Sintoma WHERE nombre_sintoma = @Nombre))
		BEGIN
			PRINT 'ESTE SINTOMA YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Sintoma(nombre_sintoma)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Paciente
	@Numero_seguro_social VARCHAR(8),
	@FechaIngreso VARCHAR(12),
	@DniPersona VARCHAR(12)
AS
	IF(@Numero_seguro_social = '' OR @FechaIngreso = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN DATOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@Numero_seguro_social) = 0)
		BEGIN	
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(ISDATE(@FechaIngreso) = 0)
		BEGIN
			PRINT 'DEBE SER UN FORMATO FECHA VALIDO'
		END
	ELSE IF EXISTS(SELECT numero_seguro_social FROM Paciente WHERE numero_seguro_social = @Numero_seguro_social)
		BEGIN
			PRINT 'EL NUMERO DE SEGURO SOCIAL YA HA SIDO REGISTRADO'
		END
	ELSE IF NOT EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona = @DniPersona)
		BEGIN
			PRINT 'LA PERSONA NO EXISTE'
		END
	ELSE IF EXISTS(SELECT dni_persona FROM Paciente WHERE dni_persona = @DniPersona)
		BEGIN
			PRINT 'EL PACIENTE YA HABIA SIDO REGISTRADO'
		END
	ELSE
		BEGIN
			INSERT INTO Paciente(numero_seguro_social, fecha_ingreso, dni_persona)
			VALUES (CONVERT(int, @Numero_seguro_social), CONVERT(date, @FechaIngreso), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Consulta
	@FechaConsulta VARCHAR(12),
	@IdPaciente VARCHAR(5)
AS
	IF(@FechaConsulta = '' OR @IdPaciente = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISDATE(@FechaConsulta) = 0)
		BEGIN
			PRINT 'DEBE SER UN FORMATO FECHA'
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			PRINT 'EL PACIENTE NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Consulta(fecha_consulta, id_paciente)
			VALUES (CONVERT(date, @FechaConsulta), CONVERT(int, @IdPaciente))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Consulta_Unidad
	@IdConsulta VARCHAR(5),
	@IdUnidad VARCHAR(5)
AS
	IF(@IdConsulta = '' OR @IdUnidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN DATOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdConsulta) = 0 OR ISNUMERIC(@IdUnidad) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			PRINT 'EL ID DE LA CONSULTA NO EXISTE'
		END
	ELSE IF (NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'EL ID DE LA UNIDAD NO EXISTE'
		END
	ELSE IF (EXISTS(SELECT id_consulta, id_unidad FROM Consulta_Unidad WHERE id_consulta = @IdConsulta AND id_unidad = @IdUnidad))
		BEGIN
			PRINT 'ESTE REGISTRO YA FUE INGRESADO'
		END
	ELSE
		BEGIN
			INSERT INTO Consulta_Unidad(id_consulta, id_unidad)
			VALUES (CONVERT(int, @IdConsulta), CONVERT(int, @IdUnidad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END  
	ELSE IF(ISNUMERIC(@IdConsulta) = 0 OR ISNUMERIC(@IdSintoma) = 0)
		BEGIN	
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			PRINT 'EL ID DE LA CONSULTA NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @IdSintoma))
		BEGIN
			PRINT 'EL ID DEL SINTOMA NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Presenta(id_consulta, id_sintoma, descripcion_presenta)
			VALUES (CONVERT(int, @IdConsulta), CONVERT(int, @IdSintoma), @Descripcion)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Enfermedad
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre_enfermedad FROM Enfermedad WHERE nombre_enfermedad = @Nombre))
		BEGIN
			PRINT 'LA ENFERMEDAD YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Enfermedad(nombre_enfermedad)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdEnfermedad) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			PRINT 'EL ID DEL PACIENTE NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @IdEnfermedad))
		BEGIN
			PRINT 'EL ID DE LA ENFERMEDAD NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Padece(id_paciente, id_enfermedad)
			VALUES (CONVERT(int, @IdPaciente), CONVERT(int, @IdEnfermedad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Tipo_Intervencion
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre_tipo_intervencion FROM Tipo_Intervencion WHERE nombre_tipo_intervencion = @Nombre))
		BEGIN
			PRINT 'EL TIPO DE INTERVENCION YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Tipo_Intervencion(nombre_tipo_intervencion)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdTipoIntervencion) = 0 OR ISNUMERIC(@IdConsulta) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @IdTipoIntervencion))
		BEGIN
			PRINT 'EL ID DE TIPO DE INTERVENCION NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @IdConsulta))
		BEGIN
			PRINT 'EL ID DE LA CONSULTA NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Intervenciones(tratamiento, id_tipo_intervencion, id_consulta)
			VALUES (@Tratamiento, CONVERT(int, @IdTipoIntervencion), CONVERT(int, @IdConsulta))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
--------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_Crear_Paciente_Unidad
	@IdPaciente VARCHAR(5),
	@IdUnidad VARCHAR(5)
AS
	IF(@IdPaciente = '' OR @IdUnidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdUnidad) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			PRINT 'EL ID DEL PACIENTE NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'EL ID DE LA UNIDAD NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Paciente_Unidad(id_paciente, id_unidad)
			VALUES (CONVERT(int, @IdPaciente), CONVERT(int, @IdUnidad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO