-----------------------------ELIMINAR PERSONA-----------------------------------------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPersona (@dni_persona varchar(12))
AS
		IF(@dni_persona = '')
			BEGIN
					PRINT 'EL ID DE PERSONA NO PUEDE SER DATO VACÍO'
				END
		ELSE IF EXISTS (SELECT dni_persona FROM Persona WHERE Persona.dni_persona = @dni_persona)
			BEGIN
				IF EXISTS (SELECT id_medico FROM Medico WHERE Medico.id_medico = @dni_persona)
					BEGIN
						DECLARE @id_medico INT
						SELECT @id_medico = Medico.id_medico FROM Medico WHERE Medico.id_medico = @id_medico 
						DELETE FROM Paciente WHERE Paciente.id_paciente =  @dni_persona 
					END
				DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
				PRINT 'SE HA ELIMINADO LA PERSONA'
			END
		ELSE
			BEGIN
				PRINT 'EL DNI_PERSONA NO EXISTE'
			END
GO
-----------------------------ELIMINAR MEDICO-----------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPACIENTE (@id_paciente INT)
AS
	IF (@id_paciente = '') 
		BEGIN
			PRINT 'EL ID DE DE PACIENTE NO PUEDE SER VACÍO'
		END
	ELSE IF (ISNUMERIC(@id_paciente) = 0) 
		BEGIN
			PRINT 'EL ID DE DE PACIENTE NO PUEDE CONTENER CARACTERES'
		END
	ELSE IF EXISTS (SELECT id_paciente FROM Paciente WHERE Paciente.id_paciente = @id_paciente)
		BEGIN
			DELETE FROM Paciente WHERE Paciente.id_paciente = @id_paciente
			PRINT 'SE HA ELIMINADO EL PACIENTE'
		END
	ELSE
		BEGIN
			PRINT 'EL ID PACIENTE NO EXISTE'
		END
GO
