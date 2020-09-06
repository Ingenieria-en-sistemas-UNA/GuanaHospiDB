USE GUANA_HOSPI
GO

CREATE PROC SP_Obtener_Personas
AS
	SELECT 'Cedula_Persona' = dni_persona , 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1, 
	'Segundo_Apellido' = apellido_2, 'Edad' = edad
	FROM Persona
GO

CREATE PROC SP_Obtener_Pacientes
AS
	SELECT 'Id_Paciente' = id_paciente,'Numero_Seguro_Social' = numero_seguro_social , 'Fecha_Ingreso' = fecha_ingreso, 'Cedula_Persona' = dni_persona
	FROM Paciente
GO


CREATE PROC SP_Obtener_Unidades
AS
	SELECT 'Id_Unidad' = id_unidad, 'Nombre_Unidad' = nombre_unidad , 'Id_Numero_Planta' = numero_planta
	FROM Unidad
GO

CREATE PROC SP_Obtener_Usuarios
AS
	SELECT 'Id_Usuario' = id_usuario, 'Nombre_Usuario' = nombre_usuario, 'Contrasenna' = contrasenna
	FROM Usuario
GO

CREATE PROC SP_Obtener_Medicos
AS
	SELECT 'Id_Medico' = id_medico, 'Codigo_Medico' = codigo_medico , 'Id_Usuario' = id_usuario, 'Id_Especialidad' = id_especialidad, 'Cedula_Persona' = dni_persona
	FROM Medico
GO

CREATE PROC SP_Obtener_Unidad_Medicos
AS
	SELECT 'Id_Unidad_Medico' = id_unidad_medico, 'Id_Unidad' = id_unidad , 'Id_Medico' = id_medico
	FROM Unidad_medico
GO

CREATE PROC SP_Obtener_Consultas
AS
	SELECT 'Id_Consulta' = id_consulta, 'Fehca_Consulta' = fecha_consulta , 'Sintoma_Observado' = sintoma_observado, 'Id_Paciente' = id_paciente, 'Id_Unidad' = id_unidad
	FROM Consulta
GO

CREATE PROC SP_Obtener_Enfermedades
AS
	SELECT 'Id_Enfermedad' = id_enfermedad, 'Nombre_Enfermedad' = nombre_enfermedad
	FROM Enfermedad
GO

CREATE PROC SP_Obtener_Intervenciones
AS
	SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta
	FROM Intervenciones
GO

CREATE PROC SP_Obtener_Especialidades
AS
	SELECT 'Id_Especialidad' = id_especialidad, 'Nombre_Especialidad' = nombre_especialdad
	FROM Especialidad
GO

CREATE PROC SP_Obtener_Paciente_Unidades
AS
	SELECT 'Id_Paciente_Unidad' = id_paciente_unidad, 'Id_Paciente' = id_paciente, 'Id_Unidad' = id_unidad
	FROM Paciente_unidad
GO

CREATE PROC SP_Obtener_Padece
AS
	SELECT 'Id_Padece' = id_padece, 'Id_Paciente' = id_paciente, 'Id_Enfermedad' = id_enfermedad
	FROM Padece
GO

CREATE PROC SP_Obtener_Sintomas
AS
	SELECT 'Id_Sintoma' = id_sintoma, 'Nombre_Sintoma' = nombre_sintoma
	FROM Sintoma
GO

CREATE PROC SP_Obtener_Tipos_Intervenciones
AS
	SELECT 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = nombre_tipo_intervencion
	FROM TipoIntervencion
GO

CREATE PROC SP_Obtener_Presenta
AS
	SELECT 'Id_Presenta' = id_presenta, 'Id_Consulta' = id_consulta, 'Id_Sintoma' = id_sintoma, 'Descripcion_Presenta' = descripcion_presenta
	FROM Presenta
GO