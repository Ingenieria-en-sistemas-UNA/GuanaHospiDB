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