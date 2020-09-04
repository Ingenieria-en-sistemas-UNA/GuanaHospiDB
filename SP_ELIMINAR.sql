-----------------------------ELIMINAR PERSONA-----------------------------------------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPersona (@dni_persona VARCHAR(12))
AS
	IF (@dni_persona = '') 
		BEGIN
			PRINT 'EL ID DE DE PERSONA NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT dni_persona FROM Persona WHERE Persona.dni_persona = @dni_persona)
		BEGIN
			DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
			PRINT 'SE HA ELIMINADO LA PERONA'
		END
	ELSE
		BEGIN
			PRINT 'EL ID PERSONA NO EXISTE'
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
	ELSE IF EXISTS (SELECT id_medico FROM Medico WHERE id_medico  = @id_medico )
		BEGIN
		    DELETE FROM Persona WHERE Persona.dni_persona = @id_medico
			PRINT 'SE HA ELIMINADO EL PERSONA'
			 DELETE FROM Usuario WHERE Usuario.id_usuario = @id_medico
			PRINT 'SE HA ELIMINADO EL USUARIO'
			DELETE FROM Medico WHERE Medico.id_medico = @id_medico
			PRINT 'SE HA ELIMINADO EN MEDICO'
		END
	ELSE
		BEGIN
			PRINT 'EL MEDICO NO EXISTE'
		END
GO
-------------------------------------------------Eliminar Usuario------------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarUsuario (@id_usuario INT)
AS
	IF (@id_usuario = '') 
		BEGIN
			PRINT 'EL ID DE DE USUARIO NO PUEDE SER VACIO'
		END
	ELSE IF (ISNUMERIC(@id_usuario) = 0) 
		BEGIN
			PRINT 'EL ID DE DE USUARIO NO PUEDE CONTENER CARACTERES'
		END
	ELSE IF EXISTS (SELECT id_usuario FROM Usuario WHERE Usuario.id_usuario = @id_usuario)
		BEGIN
			DELETE FROM Usuario WHERE Usuario.id_usuario = @id_usuario
			PRINT 'SE HA ELIMINADO EL USUARIO'
		END
	ELSE
		BEGIN
			PRINT 'EL ID USUARIO NO EXISTE'
		END
GO
---------------------------------SP_ELIMINAR_ESPECIALIDAD-------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarEspecialidad (@id_especialidad INT)
AS
	IF (@id_especialidad = '') 
		BEGIN
			PRINT 'EL ID DE DE ESPECIALIDAD NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_especialidad FROM Especialidad WHERE Especialidad.id_especialidad = @id_especialidad)
		BEGIN
			DELETE FROM Especialidad WHERE Especialidad.id_especialidad = @id_especialidad
			PRINT 'SE HA ELIMINADO LA ESPECIALIDAD'
		END
	ELSE
		BEGIN
			PRINT 'EL ID ESPECIALIDAD NO EXISTE'
		END
GO



drop proc SP_EliminarMedico
drop proc SP_EliminarPaciente

