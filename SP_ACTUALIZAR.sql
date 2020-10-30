
USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPersona
    @Dni VARCHAR(12),
	@Nombre VARCHAR(30),
	@Apellido1 VARCHAR(40),
	@Apellido2 VARCHAR(40),
	@Edad VARCHAR(20)
AS
	IF (@Dni = '')
		BEGIN
			SELECT message = 'El DNI no puede ser nulo', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona = @Dni))
		BEGIN
			IF ((@Nombre = '') OR ( @Apellido1 = '') OR (@Apellido2 = '') OR (@Edad = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La persona se a editado exitosamente!', ok = 1
					UPDATE Persona
						Set	nombre_persona = @Nombre,
							apellido_1 = @Apellido1,
							apellido_2 = @Apellido2,
							edad = CONVERT(int, @Edad)
						WHERE dni_persona = @Dni
				END
		END
	ELSE
        BEGIN
			SELECT message = 'La cedula de la persona no existe', ok = 0;
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarMedico
	@id_medico INT,
	@codigo_medico INT,
	@dni_persona VARCHAR(12)
	AS
	IF (@id_medico = '')
		BEGIN
			SELECT message = 'El id del medico no puede ser nulo', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			IF ((@codigo_medico = '') OR (@dni_persona = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_medico) = 0) OR (CONVERT(int, @id_medico) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y no puede ser negativo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El medico se ha actualizado exitosamente', ok = 0;
					UPDATE Medico
						Set	codigo_medico = @codigo_medico,
							dni_persona = @dni_persona
						WHERE id_medico = @id_medico
				END
		END
	ELSE
        BEGIN
			SELECT message = 'El id del medico no existe', ok = 0;
		END
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarEspecialidad
	@id_especialidad INT,
	@nombreEspecialdad VARCHAR(50)
AS
	IF (@id_especialidad = '')
		BEGIN
			SELECT message = 'El id de la especialidad no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @id_especialidad))
		BEGIN
			IF (@nombreEspecialdad = '')
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_especialidad) = 0) OR (CONVERT(int, @id_especialidad) < 0))
				BEGIN
					SELECT message = 'El id debe ser un dato numerico y debe ser positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La especialidad ha sido editada exitosamente', ok = 1;
					UPDATE Especialidad
						Set	nombre_especialdad = @nombreEspecialdad
						WHERE id_especialidad = @id_especialidad
				END
		END
	ELSE
        BEGIN
		SELECT message = 'El id de la especialidad no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarUnidad
	@id_unidad INT,
	@nombre VARCHAR(50),
	@numeroPlanta INT,
	@Id_Medico varchar = NULL
	AS
	IF (@id_unidad = '')
		BEGIN
			SELECT message = 'El id de la Unidad no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad))
		BEGIN
			IF ((@nombre = '') OR (@numeroPlanta = ''))
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_unidad) = 0) OR (CONVERT(int, @id_unidad) < 0) OR @Id_Medico <> NULL AND ISNUMERIC(@Id_Medico) = 0)
				BEGIN
					SELECT message = 'El id debe ser un dato numerico y positivo', ok = 0; 
				END
			ELSE
				BEGIN
				SELECT message = 'La unidad ha sido editada con exito', ok = 1;
					UPDATE Unidad
						Set	nombre_unidad = @nombre,
						    numero_planta = @numeroPlanta,
							id_medico = @id_medico
						WHERE id_unidad = @id_unidad
				END
		END
	ELSE
        BEGIN
			SELECT message = 'El id de la Unidad no existe', ok = 0;
		END
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarSintoma
	@id_sintoma INT,
	@nombre VARCHAR(50)
	AS
	IF (@id_sintoma = '')
		BEGIN
			SELECT message = 'El id del sintoma no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @id_sintoma))
		BEGIN
			IF (@nombre = '')
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_sintoma) = 0) OR (CONVERT(int, @id_sintoma) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'EL sintoma ha sido editado exitosamente', ok = 1;
					UPDATE Sintoma
						Set	nombre_sintoma = @nombre
						WHERE id_sintoma = @id_sintoma
				END
		END
	ELSE
        BEGIN
		SELECT message = 'El id del sintoma no existe', ok = 0;
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPaciente
	@id_paciente INT,
	@numeroSeguroSocial INT,
	@fecha_ingreso DATE,
	@dni_persona VARCHAR(12)
	AS
	IF (@id_paciente = '')
		BEGIN
			SELECT message = 'El id del paciente no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @id_paciente))
		BEGIN
			IF ((@numeroSeguroSocial = '') OR (@fecha_ingreso='')OR (@dni_persona ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_paciente) = 0) OR (CONVERT(int, @id_paciente) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
				END
			ELSE
				BEGIN
				SELECT message = 'El Paciente ha sido editado correctamente', ok = 1;
					UPDATE Paciente
						Set	numero_seguro_social = @numeroSeguroSocial,
						fecha_ingreso = @fecha_ingreso,
						dni_persona = @dni_persona
						WHERE id_paciente = @id_paciente
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del Paciente no existe', ok = 0;
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarConsulta
	@id_consulta INT ,
	@fecha DATE,
	@id_paciente INT,
	@id_unidad INT
	AS
	IF (@id_consulta = '')
		BEGIN
			SELECT message = 'El id de la consulta no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @id_consulta))
		BEGIN
			IF ((@fecha = '') OR (@id_paciente='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_consulta) = 0) OR (CONVERT(int, @id_consulta) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
				END
		ELSE IF NOT EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad)
				BEGIN
				SELECT message = 'El id de la consulta no existe', ok = 0;
				END
		ELSE 
		BEGIN
			SELECT message = 'La consulta ha sido editada correctamente', ok = 1;
					UPDATE Consulta
						Set	fecha_consulta = @fecha,
						id_paciente = @id_paciente,
						id_unidad = @id_unidad
						WHERE id_consulta = @id_consulta
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'	
		END
	END
	ELSE
        BEGIN	
			SELECT message = 'El id de la consulta no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPresenta
	@id_presenta INT,
	@id_consulta INT,
	@id_sintoma INT,
	@descripcion_presenta VARCHAR(50)
	AS
	IF (@id_presenta = '')
		BEGIN
			SELECT message = 'El id de Presenta no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_presenta FROM Presenta WHERE id_presenta = @id_presenta))
		BEGIN
			IF ((@id_consulta = '') OR (@id_sintoma='')OR (@descripcion_presenta ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_presenta) = 0) OR (CONVERT(int, @id_presenta) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'Presenta ha sido editada correctamente', ok = 1;
					UPDATE Presenta
						Set	id_consulta = @id_consulta,
						id_sintoma = @id_sintoma,
						descripcion_presenta = @descripcion_presenta
						WHERE id_consulta = @id_presenta
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de Presenta no existe', ok = 0;
		END
GO




USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarEnfermedad
	@id_enfermedad INT,
	@nombre VARCHAR(50)
	AS
	IF (@id_enfermedad = '')
		BEGIN
			SELECT message = 'El id de la enfermedad no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_enfermedad) = 0) OR (CONVERT(int, @id_enfermedad) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
				END
			ELSE
				BEGIN
				SELECT message = 'La enfermedad ha sido editada correctamente', ok = 1;
					UPDATE Enfermedad
						Set	nombre_enfermedad = @nombre
						WHERE id_enfermedad = @id_enfermedad
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de la enfermedad no existe', ok = 0;
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPadece
	@id_padece INT,
	@id_paciente INT,
	@id_enfermedad INT
	AS
	IF (@id_padece = '')
		BEGIN
			SELECT message = 'El id del padecimiento no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_padece FROM Padece WHERE id_padece = @id_padece))
		BEGIN
			IF ((@id_paciente = '') OR (@id_enfermedad='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_padece) = 0) OR (CONVERT(int, @id_padece) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El padecimiento ha sido editado correctamente', ok = 1;
					UPDATE Padece
						Set	id_paciente = @id_paciente,
						id_enfermedad = @id_enfermedad
						WHERE id_padece = @id_padece
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del Padecimiento no existe', ok = 0;
		END
GO




USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarTipoIntervension
	@id_tipo_Intervencion INT,
	@nombre VARCHAR(50)
	AS
	IF (@id_tipo_Intervencion = '')
		BEGIN
			SELECT message = 'El id del tipo de intervenci�n no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @id_tipo_Intervencion))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_tipo_Intervencion) = 0) OR (CONVERT(int, @id_tipo_Intervencion) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0; 
				END
			ELSE
				BEGIN
				SELECT message = 'El tipo de intervencion ha sido editado correctamente', ok = 1;
					UPDATE Tipo_Intervencion
						Set	nombre_tipo_intervencion = @nombre
						WHERE id_tipo_intervencion = @id_tipo_Intervencion
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id del tipo-intervencion no existe', ok = 0;
		END
GO






USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarIntervencion
	@id_intervencion INT,
	@tratamiento VARCHAR(150),
	@id_tipo_intervencion INT,
	@id_consulta INT
	AS
	IF (@id_intervencion = '')
		BEGIN
			SELECT message = 'El id de la intervenci�n no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_intervencion FROM Intervencion WHERE id_intervencion = @id_intervencion))
		BEGIN
			IF ((@tratamiento = '')OR(@id_tipo_intervencion ='')OR(@id_consulta ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_intervencion) = 0) OR (CONVERT(int, @id_intervencion) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'La intevencion ha sido editada correctamente', ok = 1;
					UPDATE Intervencion
						Set	tratamiento = @tratamiento,
						id_tipo_intervencion = @id_tipo_intervencion,
						id_consulta = @id_consulta
						WHERE id_intervencion = @id_intervencion
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de la intervencion no existe', ok = 0;
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarMedicoEspecialidad
	@id_medico_especialidad INT,
	@id_medico INT,
	@id_especialidad INT
	AS
	IF (@id_medico_especialidad = '')
		BEGIN
			SELECT message = 'El id del Medico-especialidad no puede ser vacio', ok = 0;
		END
	ELSE IF ( EXISTS(SELECT id_medico_especialidad FROM Medico_Especialidad WHERE id_medico_especialidad = @id_medico_especialidad))
		BEGIN
			IF ((@id_medico = '')OR(@id_especialidad ='')) 
				BEGIN
					SELECT message = 'No se permiten campos vacios', ok = 0;
				END
			ELSE IF((ISNUMERIC(@id_medico_especialidad) = 0) OR (CONVERT(int, @id_medico_especialidad) < 0))
				BEGIN
					SELECT message = 'El id debe ser numerico y positivo', ok = 0;
				END
			ELSE
				BEGIN
				SELECT message = 'El medico-especialidad ha sido editada correctamente', ok = 1;
					UPDATE Medico_Especialidad
						Set	id_medico = @id_medico,
						id_especialidad = @id_especialidad
						WHERE id_medico_especialidad = @id_medico_especialidad
				END
		END
	ELSE
        BEGIN	
			SELECT message = 'El id de medico-especialidad no existe', ok = 0;
		END
GO

