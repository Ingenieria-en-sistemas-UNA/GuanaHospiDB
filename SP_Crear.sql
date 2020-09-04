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
	@IdUsuario VARCHAR(5),
	@Nombre VARCHAR(30),
	@Contrasenna VARCHAR(30)
AS
	IF(@IdUsuario = '' OR @Nombre = '' OR @Contrasenna = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdUsuario) = 0)
		BEGIN
			PRINT 'EL ID USUARIO ES DE TIPO NUMERICO'
		END
	ELSE
		BEGIN
			INSERT INTO Usuario( id_usuario, nombre, contrasenna)
			VALUES (CONVERT(int, @IdUsuario), @Nombre, @Contrasenna)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
----------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearEspecialidad
	@IdEspecialidad VARCHAR(5),
	@NombreEspecialidad VARCHAR(30)
AS
	IF(@IdEspecialidad = '' OR @NombreEspecialidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdEspecialidad) = 0)
		BEGIN
			PRINT 'EL ID DE LA ESPECIALIDAD ES DE TIPO NUMERICO'
		END
	ELSE
		BEGIN
			INSERT INTO Especialidad( id_especialidad, nombreEspecialdad)
			VALUES (CONVERT(int, @IdEspecialidad), @NombreEspecialidad)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-----------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearMedico
	@IdMedico varchar(5),
	@CodigoMedico varchar(5),
	@IdUsuario varchar(5),
	@IdEspecialidad varchar(5),
	@DniPersona varchar(12)
AS
	IF(@IdMedico = '' OR @CodigoMedico = '' OR @IdUsuario = '' OR @IdEspecialidad = '' OR @DniPersona = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdMedico) = 0 OR ISNUMERIC(@CodigoMedico) = 0 OR ISNUMERIC(@IdUsuario) = 0 OR ISNUMERIC(@IdEspecialidad) = 0)
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
	ELSE IF (EXISTS(SELECT codigo_medico FROM Medico WHERE codigo_medico=@CodigoMedico))
		BEGIN
			PRINT 'ESTA PERSONA YA ES UN MEDICO'
		END
	ELSE 
		BEGIN
			INSERT INTO Medico(id_usuario, codigo_medico, id_usuario, id_especialidad, dni_persona)
			VALUES (CONVERT(int, @IdMedico), CONVERT(int, @CodigoMedico), CONVERT(int, @IdUsuario), CONVERT(int, @IdEspecialidad), @DniPersona)
			PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
		END
GO
-------------------------------------------------------------------------------------------------------------------------
USE GUANA_HOSPI
GO
CREATE PROC SP_CrearUnidad
	@IdUnidad varchar(5),
	@Nombre varchar(5),
	@NumeroPlanta varchar(5)
AS
	IF ((@IdUnidad = '') OR (@Nombre = '') OR ( @NumeroPlanta = ''))
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF(ISNUMERIC(@IdUnidad) = 0 OR ISNUMERIC(@NumeroPlanta) = 0)
	    BEGIN
            PRINT 'NO SE PERMITEN CARACTERES'
        END
	ELSE IF (EXISTS(SELECT nombre, numeroPlanta FROM Unidad WHERE nombre= @Nombre AND numeroPlanta = @NumeroPlanta))
		BEGIN
			PRINT 'ESTA UNIDA YA HA SIDO REGISTRADA'
		END
	ELSE
		BEGIN
			INSERT INTO Unidad(id_unidad, nombre, numeroPlanta)
			VALUES (CONVERT(int, @IdUnidad), @Nombre, CONVERT(int, @NumeroPlanta))
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
