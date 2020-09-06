USE GUANA_HOSPI
GO
CREATE PROC SP_CrearPersona
	@Dni VARCHAR(12),
	@Nombre VARCHAR(30),
	@Apellido1 VARCHAR(40),
	@Apellido2 VARCHAR(40),
	@Edad VARCHAR(20)
AS
	IF ((@Dni = '') OR (@Nombre = '') OR ( @Apellido1 = '') OR (@Apellido2 = '') OR (@Edad = ''))
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@Edad) = 0)
	    BEGIN
            PRINT 'LA EDAD DEBE SER DATOS NUMERICOS'
        END
	ELSE IF (EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona= @Dni))
		BEGIN
			PRINT 'ESTA PERSONA YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Persona( dni_persona, nombre, apellido_1, apellido_2, edad)
			VALUES (@Dni, @Nombre, @Apellido1, @Apellido2, CONVERT(int, @Edad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
--------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearUsuario
	@Nombre VARCHAR(30),
	@Contrasenna VARCHAR(30)
AS
	IF(@Nombre = '' OR @Contrasenna = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE
		BEGIN
			INSERT INTO Usuario(nombre, contrasenna)
			VALUES (@Nombre, @Contrasenna)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
----------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearEspecialidad
	@NombreEspecialidad VARCHAR(30)
AS
	IF(@NombreEspecialidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE
		BEGIN
			INSERT INTO Especialidad(nombreEspecialdad)
			VALUES (@NombreEspecialidad)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearMedico
	@CodigoMedico varchar(5),
	@IdUsuario varchar(5),
	@IdEspecialidad varchar(5),
	@DniPersona varchar(12)
AS
	IF(@CodigoMedico = '' OR @IdUsuario = '' OR @IdEspecialidad = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@CodigoMedico) = 0 OR ISNUMERIC(@IdUsuario) = 0 OR ISNUMERIC(@IdEspecialidad) = 0)
		BEGIN
			PRINT 'LOS DATOS DEBEN SER DE TIPO NUMERICO'
		END
	ELSE IF (NOT EXISTS(SELECT id_usuario FROM Usuario WHERE id_usuario=@IdUsuario))
		BEGIN
			PRINT 'EL ID DEL USUARIO NO EXISTE'
		END
	ELSE IF (NOT EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad=@IdEspecialidad))
		BEGIN
			PRINT 'EL ID DE LA ESPECIALIDAD NO EXISTE'
		END
	ELSE IF (NOT EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona=@DniPersona))
		BEGIN
			PRINT 'EL ID DE LA PERSONA NO EXISTE'
		END
	ELSE IF (EXISTS(SELECT id_usuario FROM Medico WHERE id_usuario=@IdUsuario))
		BEGIN
			PRINT 'ESTE USUARIO YA PERTENECE A UN MEDICO'
		END
	ELSE IF (EXISTS(SELECT dni_persona FROM Medico WHERE dni_persona=@DniPersona))
		BEGIN
			PRINT 'ESTA PERSONA YA ES UN MEDICO'
		END
	ELSE IF (EXISTS(SELECT codigo_medico FROM Medico WHERE codigo_medico = @CodigoMedico))
		BEGIN
			PRINT 'ESTA PERSONA YA ES UN MEDICO'
		END
	ELSE 
		BEGIN
			INSERT INTO Medico(codigo_medico, id_usuario, id_especialidad, dni_persona)
			VALUES (CONVERT(int, @CodigoMedico), CONVERT(int, @IdUsuario), CONVERT(int, @IdEspecialidad), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearUnidad
	@Nombre varchar(50),
	@NumeroPlanta varchar(5)
AS
	IF (@Nombre = '' OR @NumeroPlanta = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@NumeroPlanta) = 0)
	    BEGIN
            PRINT 'NO SE PERMITEN CARACTERES'
        END
	ELSE IF (EXISTS(SELECT nombre, numeroPlanta FROM Unidad WHERE nombre = @Nombre AND numeroPlanta = CONVERT(int, @NumeroPlanta)))
		BEGIN
			PRINT 'ESTA UNIDA YA HA SIDO REGISTRADA'
		END
	ELSE
		BEGIN
			INSERT INTO Unidad(nombre, numeroPlanta)
			VALUES (@Nombre, CONVERT(int, @NumeroPlanta))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearUnidadMedico
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
	ELSE IF(EXISTS(SELECT id_medico FROM Unidad_medico WHERE id_medico = @IdMedico))
		BEGIN
			PRINT 'EL MEDICO YA TIENE UNA UNIDAD'
		END
	ELSE IF(EXISTS(SELECT id_unidad FROM Unidad_medico WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'LA UNIDAD SE ENCUENTRA OCUPADA'
		END
	ELSE
		BEGIN
			INSERT INTO Unidad_medico(id_unidad, id_medico)
			VALUES (CONVERT(int, @IdUnidad), CONVERT(int, @IdMedico))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearSintoma
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre FROM Sintoma WHERE nombre = @Nombre))
		BEGIN
			PRINT 'ESTE SINTOMA YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Sintoma(nombre)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearPaciente
	@NumeroSeguroSocial VARCHAR(8),
	@FechaIngreso VARCHAR(12),
	@DniPersona VARCHAR(12)
AS
	IF(@NumeroSeguroSocial = '' OR @FechaIngreso = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN DATOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@NumeroSeguroSocial) = 0)
		BEGIN	
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(ISDATE(@FechaIngreso) = 0)
		BEGIN
			PRINT 'DEBE SER UN FORMATO FECHA VALIDO'
		END
	ELSE IF EXISTS(SELECT numeroSeguroSocial FROM Paciente WHERE numeroSeguroSocial = @NumeroSeguroSocial)
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
			INSERT INTO Paciente(numeroSeguroSocial, fecha_ingreso, dni_persona)
			VALUES (CONVERT(int, @NumeroSeguroSocial), CONVERT(date, @FechaIngreso), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearConsulta
	@FechaConsulta VARCHAR(12),
	@SintomaObservado VARCHAR(150),
	@IdPaciente VARCHAR(5),
	@IdUnidad VARCHAR(5)
AS
	IF(@FechaConsulta = '' OR @SintomaObservado = '' OR @IdPaciente = '' OR @IdUnidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISDATE(@FechaConsulta) = 0)
		BEGIN
			PRINT 'DEBE SER UN FORMATO FECHA'
		END
	ELSE IF(ISNUMERIC(@IdPaciente) = 0 OR ISNUMERIC(@IdUnidad) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF(NOT EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @IdPaciente))
		BEGIN
			PRINT 'EL PACIENTE NO EXISTE'
		END
	ELSE IF(NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @IdUnidad))
		BEGIN
			PRINT 'LA UNIDAD NO EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Consulta(fecha, sintoma_observado, id_paciente, id_unidad)
			VALUES (CONVERT(date, @FechaConsulta), @SintomaObservado, CONVERT(int, @IdPaciente), CONVERT(int, @IdUnidad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearPresenta
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
			INSERT INTO Presenta(id_consulta, id_sintoma, descripcion)
			VALUES (CONVERT(int, @IdConsulta), CONVERT(int, @IdSintoma), @Descripcion)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearEnfermedad
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre FROM Enfermedad WHERE nombre = @Nombre))
		BEGIN
			PRINT 'LA ENFERMEDAD YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Enfermedad(nombre)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
--------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearPadece
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
CREATE PROC SP_CrearTipoIntervencion
	@Nombre varchar(50)
AS
	IF(@Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF (EXISTS(SELECT nombre FROM TipoIntervencion WHERE nombre = @Nombre))
		BEGIN
			PRINT 'EL TIPO DE INTERVENCION YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO TipoIntervencion(nombre)
			VALUES (@Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearIntervencion
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
	ELSE IF(NOT EXISTS(SELECT id_tipo_intervencion FROM TipoIntervencion WHERE id_tipo_intervencion = @IdTipoIntervencion))
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
CREATE PROC SP_CrearPacienteUnidad
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
			INSERT INTO Paciente_unidad(id_paciente, id_unidad)
			VALUES (CONVERT(int, @IdPaciente), CONVERT(int, @IdUnidad))
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO