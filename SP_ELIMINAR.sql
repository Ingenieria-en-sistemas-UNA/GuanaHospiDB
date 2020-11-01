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
				    SELECT message ='Se ha eliminado el paciente', ok = 0
					DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
				END
			SELECT message ='Se ha eliminado la persona', ok = 0
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
CREATE PROC SP_Eliminar_Especialidad (@id_especialidad VARCHAR(10))
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
		    SELECT message = 'Se ha eliminado la especalidad', ok = 0
			DELETE FROM Especialidad WHERE Especialidad.id_especialidad = @id_especialidad
		END
	ELSE
		BEGIN
			SELECT message = 'El id de especialidad no existe', ok = 0
		END
GO
-------------------------------------------------Eliminar Medico------------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Medico (@id_medico VARCHAR)
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
			IF(EXISTS (SELECT id_medico FROM Unidad WHERE id_medico = @id_medico))
				BEGIN
					UPDATE Unidad
					SET id_medico = NULL
					WHERE id_medico = @id_medico
				END
			SELECT message = 'Se ha eliminado el medico', ok = 1
			DECLARE @idPersonaMedico VARCHAR(12)
			SET @idPersonaMedico = (SELECT dni_persona FROM Medico WHERE id_medico = @id_medico)
			DELETE FROM Medico WHERE Medico.id_medico = @id_medico
			SELECT message = 'Se ha eliminado la persona', ok = 1
		    DELETE FROM Persona WHERE Persona.dni_persona = @idPersonaMedico
		END
	ELSE
		BEGIN
			SELECT message = 'El medico no existe', ok = 0
		END
GO

--EXEC SP_Eliminar_Medico 4
--SELECT * FROM Unidad
--DROP PROC SP_Eliminar_Medico
---------------------------------------------ELIMINAR UNIDAD-----------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Unidad (@id_unidad VARCHAR(10))
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
			SELECT message = 'Se ha eliminado unidad', ok = 0
			DELETE FROM Unidad WHERE Unidad.id_unidad = @id_unidad
		END
	ELSE
		BEGIN
			SELECT message = 'La unidad no existe', ok = 0
		END
GO
------------------------------------------------------------ELIMINAR SINTOMA-------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Sintoma (@id_sintoma INT)
AS
	IF (@id_sintoma = '') 
		BEGIN
			SELECT message = 'El id de sintoma no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_sintoma) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @id_sintoma)
		BEGIN
		    SELECT message = 'Se ha eliminado el sintoma', ok = 0
			DELETE FROM Sintoma WHERE id_sintoma = @id_sintoma
		END
	ELSE
		BEGIN
			SELECT message = 'El id de sintoma no existe', ok = 0
		END
GO
-----------------------------ELIMINAR Paciente-----------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Paciente (@id_paciente INT)
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
			SET @idPersonaPaciente = (SELECT dni_persona FROM Paciente WHERE id_paciente = @id_paciente)
			SELECT message = 'Se ha eliminado el paciente', ok = 0
			DELETE FROM Paciente WHERE Paciente.id_paciente = @id_paciente
			SELECT message = 'Se ha eliminado la persona', ok = 0
			DELETE FROM Persona WHERE Persona.dni_persona = @idPersonaPaciente
		END
	ELSE
		BEGIN
			SELECT message = 'El paciente no existe', ok = 0
		END
GO

------------------------------------------ELIMINAR CONSULTA------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Elimina_Consulta (@id_consulta INT)
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
		    SELECT message = 'Se ha eliminado la consulata', ok = 0
			DELETE FROM Consulta WHERE Consulta.id_consulta = @id_consulta
		END
	ELSE
		BEGIN
			SELECT message = 'La consulta no existe', ok = 0
		END
GO

-------------------------------------------ELIMINAR PRESENTA--------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Presenta (@id_presenta INT)
AS
	IF (@id_presenta = '') 
		BEGIN
			SELECT message = 'El id de presenta no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_presenta) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_presenta FROM Presenta WHERE Presenta.id_presenta = @id_presenta)
		BEGIN
			SELECT message = 'Se ha eliminado presenta', ok = 0
			DELETE FROM Presenta WHERE Presenta.id_presenta = @id_presenta
		END
	ELSE
		 BEGIN
			SELECT message = 'El id de presenta no existe', ok = 0
		END
GO

-----------------------------------ELIMINAR ENFERMEDAD-----------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Enfermedad (@id_enfermedad INT)
AS
	IF (@id_enfermedad = '') 
		BEGIN
			SELECT message = 'El id de enfermedad no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_enfermedad) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad)
		BEGIN
			SELECT message = 'Se ha eliminado la enfermedad', ok = 1
			DELETE FROM Enfermedad WHERE Enfermedad.id_enfermedad = @id_enfermedad
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
			DELETE FROM Padece WHERE id_padece = @id_padece
	    END    
	ELSE
		BEGIN
			SELECT message = 'El id de padecimiento no existe', ok = 0
		END
GO
---------------------------------------------ELIMINAR TIPO INTERVENcION-----------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_Eliminar_Tipo_Intervension(@id_tipo_intervencion INT)
AS
	IF (@id_tipo_intervencion = '') 
		BEGIN
			SELECT message = 'El id del tipo de intervencion no puede ser vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_tipo_intervencion) = 0)
		BEGIN
			SELECT message = 'Los datos deben de ser de tipo numerico', ok = 0
		END
	ELSE IF EXISTS (SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @id_tipo_intervencion)
		BEGIN
			SELECT message = 'Se ha eliminado el tipo de intervencion', ok = 1
			DELETE FROM Tipo_Intervencion WHERE Tipo_Intervencion.id_tipo_intervencion = @id_tipo_intervencion
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
	ELSE IF EXISTS (SELECT id_medico FROM Medico_especialidad WHERE id_medico = @Id_Medico)
		BEGIN
			SELECT message = 'Se ha eliminado las especialidades del medico', ok = 1
			DELETE FROM Medico_especialidad WHERE id_medico = @Id_Medico
		END
	ELSE
		BEGIN
			SELECT message = 'El medico no cuenta con ninguna especialidad', ok = 0
		END
GO


