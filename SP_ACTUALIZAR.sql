
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT dni_persona FROM Persona WHERE dni_persona = @Dni))
		BEGIN
			IF ((@Nombre = '') OR ( @Apellido1 = '') OR (@Apellido2 = '') OR (@Edad = ''))
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@Dni) = 0) OR (CONVERT(int, @Dni) < 0))
				BEGIN
					PRINT  'EL DNI DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Persona
						Set	nombre_persona = @Nombre,
							apellido_1 = @Apellido1,
							apellido_2 = @Apellido2,
							edad = CONVERT(int, @Edad)
						WHERE dni_persona = @Dni
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DE LA PERSONA NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			IF ((@codigo_medico = '') OR (@dni_persona = ''))
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_medico) = 0) OR (CONVERT(int, @id_medico) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Medico
						Set	codigo_medico = @codigo_medico,
							dni_persona = @dni_persona
						WHERE id_medico = @id_medico
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DEl MEDICO NO EXISTE'
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarUsuario
	@id_usuario INT,
	@nombre_usuario VARCHAR(40),
	@contrasenna VARCHAR(12),
	@id_medico INT
	AS
	IF (@id_usuario = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_usuario FROM Usuario WHERE id_usuario = @id_usuario))
		BEGIN
			IF ((@nombre_usuario = '') OR (@contrasenna = '') OR (@id_medico = ''))
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_usuario) = 0) OR (CONVERT(int, @id_usuario) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Usuario
						Set	nombre_usuario = @nombre_usuario,
							contrasenna = @contrasenna,
							id_medico = @id_medico
						WHERE id_usuario = @id_usuario
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DEl MEDICO NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_especialidad FROM Especialidad WHERE id_especialidad = @id_especialidad))
		BEGIN
			IF (@nombreEspecialdad = '')
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_especialidad) = 0) OR (CONVERT(int, @id_especialidad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Especialidad
						Set	nombre_especialdad = @nombreEspecialdad
						WHERE id_especialidad = @id_especialidad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DE LA ESPECIALIDAD NO EXISTE'
		END
GO







USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarUnidad
	@id_unidad INT,
	@nombre VARCHAR(50),
	@numeroPlanta INT
	AS
	IF (@id_unidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_unidad FROM Unidad WHERE id_unidad = @id_unidad))
		BEGIN
			IF ((@nombre = '') OR (@numeroPlanta = ''))
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_unidad) = 0) OR (CONVERT(int, @id_unidad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Unidad
						Set	nombre_unidad = @nombre,
						    numero_planta = @numeroPlanta
						WHERE id_unidad = @id_unidad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DE LA UNIDAD NO EXISTE'
		END
GO


USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarUnidadMedico
	@id_unidad_medico INT,
    @id_unidad INT,
    @id_medico INT
	AS
	IF (@id_unidad_medico = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_unidad_medico FROM Unidad_medico WHERE id_unidad_medico = @id_unidad_medico))
		BEGIN
			IF ((@id_unidad = '') OR (@id_medico = ''))
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_unidad_medico) = 0) OR (CONVERT(int, @id_unidad_medico) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Unidad_medico
						Set	id_unidad = @id_unidad,
						    id_medico = @id_medico
						WHERE id_unidad_medico = @id_unidad_medico
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DE LA UNIDAD-MEDICO NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_sintoma FROM Sintoma WHERE id_sintoma = @id_sintoma))
		BEGIN
			IF (@nombre = '')
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_sintoma) = 0) OR (CONVERT(int, @id_sintoma) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Sintoma
						Set	nombre_sintoma = @nombre
						WHERE id_sintoma = @id_sintoma
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN
			PRINT 'EL ID DEL SINTOMA NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_paciente FROM Paciente WHERE id_paciente = @id_paciente))
		BEGIN
			IF ((@numeroSeguroSocial = '') OR (@fecha_ingreso='')OR (@dni_persona ='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_paciente) = 0) OR (CONVERT(int, @id_paciente) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Paciente
						Set	numero_seguro_social = @numeroSeguroSocial,
						fecha_ingreso = @fecha_ingreso,
						dni_persona = @dni_persona
						WHERE id_paciente = @id_paciente
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DEL DEL PACIENTE NO EXISTE'
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarConsulta
	@id_consulta INT ,
	@fecha DATE,
	@id_paciente INT
	AS
	IF (@id_consulta = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_consulta FROM Consulta WHERE id_consulta = @id_consulta))
		BEGIN
			IF ((@fecha = '') OR (@id_paciente='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_consulta) = 0) OR (CONVERT(int, @id_consulta) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Consulta
						Set	fecha_consulta = @fecha,
						id_paciente = @id_paciente
						WHERE id_consulta = @id_consulta
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DEL DE LA CONSULTA NO EXISTE'
		END
GO



USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarConsultaUnidad
	@id_consulta_unidad INT,
	@id_consulta INT,
	@id_unidad INT
	AS
	IF (@id_consulta_unidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_consulta_unidad FROM Consulta_Unidad WHERE id_consulta_unidad = @id_consulta_unidad))
		BEGIN
			IF ((@id_consulta = '') OR (@id_unidad='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_consulta_unidad) = 0) OR (CONVERT(int, @id_consulta_unidad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Consulta_Unidad
						Set	id_consulta = @id_consulta,
						id_unidad = @id_unidad
						WHERE id_consulta_unidad = @id_consulta_unidad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DEL PADECIMIENTO NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_presenta FROM Presenta WHERE id_presenta = @id_presenta))
		BEGIN
			IF ((@id_consulta = '') OR (@id_sintoma='')OR (@descripcion_presenta ='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_presenta) = 0) OR (CONVERT(int, @id_presenta) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Presenta
						Set	id_consulta = @id_consulta,
						id_sintoma = @id_sintoma,
						descripcion_presenta = @descripcion_presenta
						WHERE id_consulta = @id_presenta
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DEL PADECIMIENTO NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_enfermedad FROM Enfermedad WHERE id_enfermedad = @id_enfermedad))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_enfermedad) = 0) OR (CONVERT(int, @id_enfermedad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Enfermedad
						Set	nombre_enfermedad = @nombre
						WHERE id_enfermedad = @id_enfermedad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DE LA ENFERMEDAD NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_padece FROM Padece WHERE id_padece = @id_padece))
		BEGIN
			IF ((@id_paciente = '') OR (@id_enfermedad='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_padece) = 0) OR (CONVERT(int, @id_padece) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Padece
						Set	id_paciente = @id_paciente,
						id_enfermedad = @id_enfermedad
						WHERE id_padece = @id_padece
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DE PADECE NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_tipo_intervencion FROM Tipo_Intervencion WHERE id_tipo_intervencion = @id_tipo_Intervencion))
		BEGIN
			IF (@nombre = '') 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_tipo_Intervencion) = 0) OR (CONVERT(int, @id_tipo_Intervencion) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Tipo_Intervencion
						Set	nombre_tipo_intervencion = @nombre
						WHERE id_tipo_intervencion = @id_tipo_Intervencion
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DE TIPO INTERVENCION NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_intervencion FROM Intervencion WHERE id_intervencion = @id_intervencion))
		BEGIN
			IF ((@tratamiento = '')OR(@id_tipo_intervencion ='')OR(@id_consulta ='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_intervencion) = 0) OR (CONVERT(int, @id_intervencion) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
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
			PRINT 'EL ID DE INTERVENCION NO EXISTE'
		END
GO






USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_ActualizarPaciente_unidad
	@id_paciente_unidad INT,
	@id_paciente INT,
	@id_unidad INT
	AS
	IF (@id_paciente_unidad = '')
		BEGIN
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_paciente_unidad FROM Paciente_unidad WHERE id_paciente_unidad = @id_paciente_unidad))
		BEGIN
			IF ((@id_paciente = '')OR(@id_unidad ='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_paciente_unidad) = 0) OR (CONVERT(int, @id_paciente_unidad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Paciente_unidad
						Set	id_paciente = @id_paciente,
						id_unidad = @id_unidad
						WHERE id_paciente_unidad = @id_paciente_unidad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DE PACIENTE UNIDAD NO EXISTE'
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
			PRINT 'NO SE PERMITEN CAMPOS VACIOS'
		END
	ELSE IF ( EXISTS(SELECT id_medico_especialidad FROM Medico_Especialidad WHERE id_medico_especialidad = @id_medico_especialidad))
		BEGIN
			IF ((@id_medico = '')OR(@id_especialidad ='')) 
				BEGIN
					PRINT 'NO SE PERMITEN CAMPOS VACIOS'
				END
			ELSE IF((ISNUMERIC(@id_medico_especialidad) = 0) OR (CONVERT(int, @id_medico_especialidad) < 0))
				BEGIN
					PRINT  'EL ID DEBE SER DATOS NUMERICOS Y DEBE SER POSITIVO' 
				END
			ELSE
				BEGIN
					UPDATE Medico_Especialidad
						Set	id_medico = @id_medico,
						id_especialidad = @id_especialidad
						WHERE id_medico_especialidad = @id_medico_especialidad
						PRINT 'SE HA ACTUALIZADO CORRECTAMENTE'
				END
		END
	ELSE
        BEGIN	
			PRINT 'EL ID DE PACIENTE UNIDAD NO EXISTE'
		END
GO

