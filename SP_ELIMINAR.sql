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
-----------------------------ELIMINAR Paciente-----------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPaciente (@id_paciente INT)
AS
	IF (@id_paciente = '') 
		BEGIN
			PRINT 'EL ID DE COCINERO NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT @id_paciente  FROM Paciente WHERE Paciente.id_paciente = @id_paciente )
		BEGIN
		    DELETE FROM Persona WHERE Persona.dni_persona = @id_paciente 
			PRINT 'SE HA ELIMINADO EL PERSONA'
			DELETE FROM Paciente WHERE Paciente.id_paciente = @id_paciente 
			PRINT 'SE HA ELIMINADO EN PACIENTE'
		END
	ELSE
		BEGIN
			PRINT 'EL PACIENTE NO EXISTE'
		END
GO
-------------------------------------------------Eliminar Medico------------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarMedico (@id_medico INT)
AS
	IF (@id_medico = '') 
		BEGIN
			PRINT 'EL ID DE COCINERO NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT @id_medico FROM Medico WHERE Medico.id_medico = @id_medico )
		BEGIN
		    DELETE FROM Persona WHERE Persona.dni_persona = @id_medico
			PRINT 'SE HA ELIMINADO EL PERSONA'
			DELETE FROM Medico WHERE Medico.id_medico = @id_medico
			PRINT 'SE HA ELIMINADO EN MEDICO'
		END
	ELSE
		BEGIN
			PRINT 'EL MEDICO NO EXISTE'
		END
GO

drop proc SP_EliminarMedico
drop proc SP_EliminarPaciente

