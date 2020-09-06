-----------------------------ELIMINAR PERSONA-----------------------------------------------------------------

USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPersona (@dni_persona VARCHAR(12))
AS
	IF (@dni_persona = '') 
		BEGIN
			PRINT 'EL ID DE DE PERSONA NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT dni_persona FROM Persona WHERE dni_persona = @dni_persona)
		BEGIN
	        IF EXISTS (SELECT dni_persona  FROM Medico where dni_persona = @dni_persona)
				BEGIN
					DECLARE @idUsuarioMedico INT
					SET @idUsuarioMedico = (SELECT  id_usuario FROM Medico WHERE dni_persona = @dni_persona)
					DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
					PRINT 'SE HA ELIMINADO LA MEDICO'
					DELETE FROM Usuario  WHERE Usuario.id_usuario = @idUsuarioMedico
					PRINT 'SE HA ELIMINADO EL USUARIO DE LA PERSONA'
				END
			ELSE IF EXISTS (SELECT @dni_persona FROM Paciente WHERE dni_persona = @dni_persona)
				BEGIN
					DELETE FROM Persona WHERE Persona.dni_persona = @dni_persona
					PRINT 'SE HA ELIMINADO PERSONA'
					PRINT 'SE HA ELIMINADO PACIENTE'
				END
		END
	ELSE
		BEGIN
			PRINT 'EL ID PERSONA NO EXISTE'
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
	ELSE IF EXISTS (SELECT id_usuario FROM Usuario WHERE id_usuario  = @id_usuario)
		BEGIN
		    DECLARE @idUsuarioMedico INT
			SET @idUsuarioMedico = (SELECT id_usuario FROM Medico WHERE id_medico = @id_usuario)
			DELETE FROM Medico WHERE Medico.id_medico = @id_usuario
			PRINT 'SE HA ELIMINADO EL MEDICO'
			DELETE FROM Usuario WHERE Usuario.id_usuario = @idUsuarioMedico
			PRINT 'SE HA ELIMINADO EL USUARIO'
		END
	ELSE
		BEGIN
			PRINT 'EL USUARIO NO EXISTE'
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
		    DECLARE @idUsuarioMedico INT
			DECLARE @idPersonaMedico VARCHAR(12)
			SET @idUsuarioMedico = (SELECT id_usuario FROM Medico WHERE id_medico = @id_medico)
			SET @idPersonaMedico = (SELECT dni_persona FROM Medico WHERE id_medico = @id_medico)
			DELETE FROM Medico WHERE Medico.id_medico = @id_medico
			PRINT 'SE HA ELIMINADO EL MEDICO'
			DELETE FROM Usuario WHERE Usuario.id_usuario = @idUsuarioMedico
			PRINT 'SE HA ELIMINADO EL USUARIO'
		    DELETE FROM Persona WHERE Persona.dni_persona = @idPersonaMedico
			PRINT 'SE HA ELIMINADO EL PERSONA'
		END
	ELSE
		BEGIN
			PRINT 'EL MEDICO NO EXISTE'
		END
GO
---------------------------------------------ELIMINAR UNIDAD-----------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarUnidad (@id_unidad INT)
AS
	IF (@id_unidad = '') 
		BEGIN
			PRINT 'EL ID DE DE PERSONA NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad)
		BEGIN
	        IF EXISTS (SELECT id_paciente_unidad  FROM Paciente_unidad where id_unidad = @id_unidad)
				BEGIN
					DECLARE @idUnidadPaciente INT
                    SET @idUnidadPaciente = (SELECT  id_unidad FROM Paciente_unidad WHERE id_unidad = @id_unidad)
					DELETE FROM Unidad WHERE Unidad.id_unidad = @idUnidadPaciente
					PRINT 'SE HA ELIMINADO LA UNIDAD PACIENTE'
				END
		ELSE IF EXISTS (SELECT @id_unidad FROM Unidad_medico WHERE id_unidad = @id_unidad)
				BEGIN
					DELETE FROM Unidad WHERE Unidad.id_unidad = @id_unidad
					PRINT 'SE HA ELIMINADO UNIDAD'
					PRINT 'SE HA ELIMINADO LA UNIDAD MEDICO'
				END
		END
	ELSE
		BEGIN
			PRINT 'LA UNIDAD NO EXISTE'
		END
GO
---------------------------------------------------UNIDAD MEDICO-----------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarUnidadMedico (@id_unidad_medico INT)
AS
	IF (@id_unidad_medico = '') 
		BEGIN
			PRINT 'EL ID DE UNIDAD MEDICO NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_unidad_medico FROM Unidad_medico WHERE id_unidad_medico  = @id_unidad_medico )
		BEGIN
		    DECLARE @idUnidadMedicoMedico INT
			DECLARE @idUnidaMedicoUnidad INT
			SET @idUnidadMedicoMedico = (SELECT id_medico FROM Unidad_medico WHERE id_medico = @id_unidad_medico)
			SET v@idUnidadPacientePaciente = (SELECT id_unidad FROM Unidad_medico WHERE id_unidad = @id_unidad_medico)
			DELETE FROM Unidad_medico WHERE Unidad_medico.id_unidad_medico = @id_unidad_medico
			PRINT 'SE HA ELIMINADO LA UNIDAD MEDICO'
			DELETE FROM Medico WHERE Medico.id_medico = @idUnidadMedicoMedico
			PRINT 'SE HA ELIMINADO EL USUARIO'
		    DELETE FROM Unidad WHERE Unidad.id_unidad = @idUnidaMedicoUnidad
			PRINT 'SE HA ELIMINADO EL PERSONA'
		END
	ELSE
		BEGIN
			PRINT 'LA UNIDAD MEDICO NO EXISTE'
		END
GO
------------------------------------------------------------ELIMINAR SINTOMA-------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarSintoma (@id_sintoma INT)
AS
	IF (@id_sintoma = '') 
		BEGIN
			PRINT 'EL ID DE DE PADECIMIENTO NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @id_sintoma)
		BEGIN
					DECLARE @idSintomaPresenta INT
					SET @idSintomaPresenta = (SELECT  id_padecimiento FROM Presenta WHERE id_sintoma = @id_sintoma)
					DELETE FROM Sintoma WHERE id_sintoma = @id_sintoma
					PRINT 'SE HA ELIMINADO EL SINTOMA'
					DELETE FROM Presenta  WHERE Presenta.id_padecimiento = @idSintomaPresenta
					PRINT 'SE HA ELIMINADO EL PADECIMINETO'
			END
	ELSE
		BEGIN
			PRINT 'EL ID DE SINTOMA NO EXISTE'
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
	ELSE IF EXISTS (SELECT id_paciente FROM Paciente WHERE id_paciente  = @id_paciente )
		BEGIN
		    DECLARE @idPacientePadece INT
			DECLARE @idPersonaPaciente VARCHAR(12)
			DECLARE @idconsultaPaciente INT
			SET @idPacientePadece = (SELECT id_pacienteEnfermedad FROM Padece WHERE id_paciente = @id_paciente)
			SET @idPersonaPaciente = (SELECT dni_persona FROM Paciente WHERE id_paciente = @id_paciente)
			SET @idconsultaPaciente = (SELECT id_consulta FROM Consulta WHERE id_paciente = @id_paciente)
			DELETE FROM Paciente WHERE Paciente.id_paciente = @id_paciente
			PRINT 'SE HA ELIMINADO EL PACIENTE'
			DELETE FROM Padece WHERE Padece.id_pacienteEnfermedad = @idPacientePadece
			PRINT 'SE HA ELIMINADO EL PADECIMIENTE'
		    DELETE FROM Consulta WHERE Consulta.id_consulta = @idPersonaPaciente
			PRINT 'SE HA ELIMINADO LA CONSULTA'
			  DELETE FROM Persona WHERE Persona.dni_persona = @idconsultaPaciente
			PRINT 'SE HA ELIMINADO EL PERSONA'
		END
	ELSE
		BEGIN
			PRINT 'EL PACIENTE NO EXISTE'
		END
GO
------------------------------------------ELIMINAR CONSULTA------------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminaConsulta (@id_consulta INT)
AS
	IF (@id_consulta = '') 
		BEGIN
			PRINT 'EL ID DE LA CONSULTA NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_consulta FROM Consulta WHERE id_consulta  = @id_consulta )
		BEGIN
		    DECLARE @idConsultaPresenta INT
			DECLARE @idConsultaIntervenciones INT
			SET @idConsultaPresenta = (SELECT id_presenta FROM Consulta WHERE id_consulta = @id_consulta)
			SET @idConsultaIntervenciones = (SELECT dni_persona FROM Consulta WHERE id_consulta = @id_consulta)
			DELETE FROM Medico WHERE Medico.id_medico = @id_consulta
			PRINT 'SE HA ELIMINADO EL MEDICO'
			DELETE FROM Usuario WHERE Usuario.id_usuario = @idConsultaPresenta
			PRINT 'SE HA ELIMINADO EL USUARIO'
		    DELETE FROM Persona WHERE Persona.dni_persona = @idConsultaIntervenciones
			PRINT 'SE HA ELIMINADO EL PERSONA'
		END
	ELSE
		BEGIN
			PRINT 'EL MEDICO NO EXISTE'
		END


-------------------------------------------ELIMINAR PRESENTA--------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPresenta (@id_presenta INT)
AS
	IF (@id_presenta = '') 
		BEGIN
			PRINT 'EL ID DEL PRESENTAA SINTOMA NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_presenta FROM Presenta WHERE id_presenta  = @id_presenta )
		BEGIN
		    DECLARE @idPesentaSintoma INT
			SET @idPesentaSintoma = (SELECT id_sintoma FROM Padece WHERE id_padece = @id_presenta)
			DELETE FROM Presenta WHERE Presenta.id_presenta = @idPesentaSintoma
			PRINT 'SE HA ELIMINADO LA PRESENCIA SINTOMA '
			END
	ELSE IF EXISTS (SELECT id_presente FROM Presenta WHERE Presenta.id_presenta = @id_presenta)
		BEGIN
			DELETE FROM Presenta WHERE Presenta.id_presenta = @id_presenta
			PRINT 'SE HA ELIMINADO  LA PRESENCIA DE SINTOMA'
	    END
    
	  ELSE
		 BEGIN
			PRINT 'EL ID DE DEL PRESENTA SINTOMA NO EXISTE'
		END
GO

-----------------------------------ELIMINAR ENFERMEDAD-----------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarEnfermedad (@id_enfermedad INT)
AS
	IF (@id_enfermedad = '') 
		BEGIN
			PRINT 'EL ID DE LA ENFERMEDAD NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_enfermedad FROM Enfermedad WHERE Enfermedad.id_enfermedad = @id_enfermedad)
		BEGIN
			DELETE FROM Enfermedad WHERE Enfermedad.id_enfermedad = @id_enfermedad
			PRINT 'SE HA ELIMINADO LA ENFERMEDAD'
		END
	ELSE
		BEGIN
			PRINT 'EL ID ENFERMEDAD NO EXISTE'
		END
GO
----------------------------------------ELIMINAR PADECIMIETNO------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarPadecimiento (@id_padece INT)
AS
	IF (@id_padece = '') 
		BEGIN
			PRINT 'EL ID DEL PADECIMIENTO NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_padece FROM Padece WHERE id_padece  = @id_padece )
		BEGIN
		    DECLARE @idPadeceEnfermedad INT
			SET @idPadeceEnfermedad = (SELECT id_enfermedad FROM Padece WHERE id_padece = @id_padece)
			DELETE FROM Padece WHERE Padece.id_enfermedad = @idPadeceEnfermedad
			PRINT 'SE HA ELIMINADO LA ENFERMEDAD'
			END
	ELSE IF EXISTS (SELECT @id_padece FROM Padece WHERE Padece.id_enfermedad = @id_padece)
		BEGIN
			DELETE FROM Padece WHERE Padece.id_padece = @id_padece
			PRINT 'SE HA ELIMINADO	EL PADECIMINETO'
	    END
    
	  ELSE
		 BEGIN
			PRINT 'EL ID DE PADECIMINTO NO EXISTE'
		END
GO
---------------------------------------------ELIMINAR TIPO INTERVENcION-----------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarIntervension(@id_tipo_intervencion INT)
AS
	IF (@id_tipo_intervencion = '') 
		BEGIN
			PRINT 'EL ID DE LA INTERVENSION NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_intervencion FROM Intervenciones WHERE Intervenciones.id_intervencion = @id_tipo_intervencion)
		BEGIN
			DELETE FROM Intervenciones WHERE Intervenciones.id_intervencion = @id_tipo_intervencion
			PRINT 'SE HA ELIMINADO LA INTERVENSION'
		END
	ELSE
		BEGIN
			PRINT 'EL ID DE LA INTERVENSION NO EXISTE'
		END
GO
------------------------------------ELIMINAR INTERVENCIONES------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarIntervencion (@id_intervencion INT)
AS
	IF (@id_intervencion = '') 
		BEGIN
			PRINT 'EL ID DEL ESTANTE NO PUEDE SER VACIO'
		END
	ELSE IF EXISTS (SELECT id_intervencion FROM Intervenciones WHERE id_intervencion  = @id_intervencion )
		BEGIN
		    DECLARE @idTipoIntervencion INT
			SET @idTipoIntervencion = (SELECT id_tipo_intervencion FROM Intervenciones WHERE id_intervencion = @id_intervencion)
			DELETE FROM Intervenciones WHERE Intervenciones.id_tipo_intervencion = @idTipoIntervencion
			PRINT 'SE HA ELIMINADO EL TIPO INTERVENCION'
			END
	ELSE IF EXISTS (SELECT @id_intervencion FROM Intervenciones WHERE Intervenciones.id_intervencion = @id_intervencion)
		BEGIN
			DELETE FROM Intervenciones WHERE Intervenciones.id_intervencion = @id_intervencion
			PRINT 'SE HA ELIMINADO LA INTERVENCION'
	    END
    
	  ELSE
		 BEGIN
			PRINT 'EL ID DE LA INTERENCION NO EXISTE'
		END
GO

----------------------------------PACIENTE UNIDAD-------------------------------------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarUnidadPaciente (@id_paciente_unidad INT)
AS
	IF (@id_paciente_unidad = '') 
		BEGIN
			PRINT 'EL ID DE UNIDAD PACIENTE NO PUEDE SER VACIO'
		END
	
GO

------------------------------------------ELIMINAR MEDICO ESPECIALIDAD----------------------------
USE	GUANA_HOSPI
GO
CREATE PROC SP_EliminarMedicoEspecialidad (@id_medico_especialidad INT)
AS
	IF (@id_medico_especialidad = '') 
		BEGIN
			PRINT 'EL ID DE MEDIICO ESPECIALIDAD NO PUEDE SER VACIO'
		END
	
GO

drop proc SP_EliminarMedico
drop proc SP_EliminarPaciente

