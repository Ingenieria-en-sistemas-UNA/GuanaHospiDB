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
	@Nombre varchar(5),
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
	ELSE IF (EXISTS(SELECT nombre, numeroPlanta FROM Unidad WHERE nombre= @Nombre AND numeroPlanta = @NumeroPlanta))
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
	@IdSintoma varchar(5),
	@Nombre varchar(5)
AS
	IF(@IdSintoma = '' OR @Nombre = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdSintoma) = 0)
		BEGIN
			PRINT 'NO SE PERMITEN CARACTERES'
		END
	ELSE IF (EXISTS(SELECT nombre FROM Sintoma WHERE nombre = @Nombre))
		BEGIN
			PRINT 'ESTE SINTOMA YA EXISTE'
		END
	ELSE
		BEGIN
			INSERT INTO Sintoma(id_sintoma, nombre)
			VALUES (CONVERT(int, @IdSintoma), @Nombre)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearPaciente
	@NumeroSeguroSocial VARCHAR(8),
	@Edad VARCHAR(3),
	@FechaIngreso VARCHAR(5),
	@DniPersona VARCHAR(12)
AS
	IF(@NumeroSeguroSocial = '' OR @Edad = '' OR @FechaIngreso = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN DATOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@NumeroSeguroSocial) = 0 OR ISNUMERIC(@Edad) = 0)
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
	ELSE IF NOT EXISTS(SELECT dni_persona FROM Paciente WHERE dni_persona = @DniPersona)
		BEGIN
			PRINT 'EL PACIENTE YA HABIA SIDO REGISTRADO'
		END
		ELSE
	BEGIN
			INSERT INTO Paciente(numeroSeguroSocial, edad, fecha_ingreso, dni_persona)
			VALUES (CONVERT(int, @NumeroSeguroSocial), CONVERT(int, @Edad), CONVERT(date, @FechaIngreso), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO