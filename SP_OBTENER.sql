USE GUANA_HOSPI
GO

CREATE PROC SP_Obtener_Personas
AS
	SELECT 'Cedula_Persona' = dni_persona , 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
		'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1
	FROM Persona
GO

CREATE PROC SP_Obtener_Persona_Por_Dni
	(@dni_persona VARCHAR(12))
AS
	IF(@dni_persona = '')
		BEGIN
			SELECT message = 'El campo dni viene vacio', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Cedula_Persona' = dni_persona , 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
				'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1
			FROM Persona
			WHERE dni_persona = @dni_persona;
		END
GO


CREATE PROC SP_Obtener_Pacientes
AS
	SELECT 'Id_Paciente' = id_paciente, 'Numero_Seguro_Social' = numero_seguro_social , 'Fecha_Ingreso' = fecha_ingreso, 'Cedula_Persona' = dni_persona, ok = 1
	FROM Paciente
GO
	

CREATE PROC SP_Obtener_Paciente_Por_Id
	(@id_paciente VARCHAR(12))
AS
	IF(@id_paciente = '')
		BEGIN
			SELECT message = 'El campo id_paciente viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_paciente) = 0)
		BEGIN
			SELECT message = 'El campo id_paciente no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Paciente' = id_paciente, 'Numero_Seguro_Social' = numero_seguro_social , 'Fecha_Ingreso' = fecha_ingreso, 'Cedula_Persona' = Paciente.dni_persona, 
			'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1, 'Segundo_Apellido' = apellido_2, 'Edad' = edad , ok = 1
			FROM Paciente
			INNER JOIN Persona
			ON Persona.dni_persona = Paciente.dni_persona
			WHERE id_paciente = @id_paciente;
		END
GO


CREATE PROC SP_Obtener_Unidades
AS
	SELECT 'Id_Unidad' = id_unidad, 'Nombre_Unidad' = nombre_unidad , 'Numero_Planta' = numero_planta, ok = 1
	FROM Unidad
GO

CREATE PROC SP_Obtener_Unidade_Por_Id
	(@id_unidad VARCHAR(12))
AS
	IF(@id_unidad = '')
		BEGIN
			SELECT message = 'El campo id_unidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_unidad) = 0)
		BEGIN
			SELECT message = 'El campo id_unidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Unidad' = id_unidad, 'Nombre_Unidad' = nombre_unidad , 'Numero_Planta' = numero_planta, 'Id_Medico' = id_medico, ok = 1
			FROM Unidad
			WHERE id_unidad = @id_unidad;
		END
GO

CREATE PROC SP_Obtener_Medicos
AS
	SELECT 'Id_Medico' = id_medico, 'Codigo_Medico' = codigo_medico , 'Cedula_Persona' = Medico.dni_persona, 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
	'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1	FROM Medico
	INNER JOIN Persona
	ON Persona.dni_persona = Medico.dni_persona
GO

CREATE PROC SP_Obtener_Medicos_Por_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id_medico viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id_medico no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Medico' = id_medico, 'Codigo_Medico' = codigo_medico , 'Cedula_Persona' = Medico.dni_persona, 'Nombre_Persona' = nombre_persona, 'Primer_Apellido' = apellido_1,
			'Segundo_Apellido' = apellido_2, 'Edad' = edad, ok = 1
			FROM Medico
			INNER JOIN Persona
			ON Persona.dni_persona = Medico.dni_persona
			WHERE id_medico = @id_medico;
		END
GO

CREATE PROC SP_Obtener_Roles
AS
	SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
	FROM Roles
GO

CREATE PROC SP_Obtener_Role_Por_ID
	(@IdRole VARCHAR)
AS
	IF(@IdRole = '')
		BEGIN
			SELECT message = 'El campo id_role viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@IdRole) = 0)
		BEGIN
			SELECT message = 'El campo id_role no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
			FROM Roles
			WHERE id_role = @IdRole
		END
GO

CREATE PROC SP_Obtener_Role_Por_Nombre
	(@NombreRole VARCHAR(100))
AS
	IF(@NombreRole = '')
		BEGIN
			SELECT message = 'El campo nombre_role viene vacio', ok = 0
		END
	ELSE IF EXISTS(SELECT nombre_role FROM Roles WHERE Roles.nombre_role = @NombreRole)
		BEGIN
			SELECT 'Id_Role' = id_role, 'Nombre_Role' = nombre_role, ok = 1
			FROM Roles
			WHERE nombre_role = @NombreRole
		END
	ELSE
		BEGIN
			SELECT message = 'No existe el role', ok = 0
		END
GO

CREATE PROC SP_Obtener_Consultas
AS
	SELECT 'Id_Consulta' = id_consulta, 'Fehca_Consulta' = fecha_consulta , descripcion , 'Id_Paciente' = id_paciente, ok = 1
	FROM Consulta
GO

USE GUANA_HOSPI
GO
CREATE PROC SP_Obtener_Consulta_Por_Id
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
		BEGIN
			SELECT message = 'El campo id_consulta viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_consulta) = 0)
		BEGIN
			SELECT message = 'El campo id_consulta no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Consulta' = id_consulta, 'Id_Unidad' = id_unidad, 'Fehca_Consulta' = fecha_consulta , 'Descripcion' = Consulta.descripcion, 'Id_Paciente' = Paciente.id_paciente,
			'Nombre_Persona' = Persona.nombre_persona, 'Apellido_Uno' = Persona.apellido_1, 'Apellido_Dos' = Persona.apellido_2, ok = 1
			FROM Consulta 
			INNER JOIN Paciente ON Consulta.id_paciente = Paciente.id_paciente
			INNER JOIN Persona ON Persona.dni_persona = Paciente.dni_persona
			WHERE id_consulta = @id_consulta;
		END
GO


CREATE PROC SP_Obtener_Enfermedades
AS
	SELECT 'Id_Enfermedad' = id_enfermedad, 'Nombre_Enfermedad' = nombre_enfermedad, ok = 1
	FROM Enfermedad
GO

CREATE PROCEDURE SP_Obtener_Enfermedades_Por_Id_Paciente
	(@id_paciente VARCHAR(12))
AS
	IF(@id_paciente = '')
	BEGIN
		SELECT MESSAGE = 'El ID está vacío', ok = 0
	END
		ELSE IF(ISNUMERIC(@id_paciente) = 0)
	BEGIN
		SELECT message = 'El campo no es numerico'
	END
		ELSE
	BEGIN
		SELECT 'Id_Enfermedad' = Enfermedad.id_enfermedad, 'Nombre_Enfermedad' = Enfermedad.nombre_enfermedad, ok = 1
		FROM Enfermedad INNER JOIN Padece ON Enfermedad.id_enfermedad = Padece.id_enfermedad
		WHERE id_paciente = @id_paciente
	END
GO

CREATE PROC SP_Obtener_Enfermedades_Por_Id
	(@id_enfermedad VARCHAR(12))
AS
	IF(@id_enfermedad = '')
		BEGIN
			SELECT message = 'El campo id_enfermedad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_enfermedad) = 0)
		BEGIN
			SELECT message = 'El campo id_enfermedad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Enfermedad' = id_enfermedad, 'Nombre_Enfermedad' = nombre_enfermedad, ok = 1
			FROM Enfermedad
			WHERE id_enfermedad = @id_enfermedad;
		END
GO

CREATE PROC SP_Obtener_Intervenciones
AS
	SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta, ok = 1
	FROM Intervenciones
GO

CREATE PROC SP_Obtener_Interv_Por_Id_Consulta
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta está vacío', ok = 0
	END
		ELSE IF(ISNUMERIC(@id_consulta) = 0)
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta no es númerico'
	END
		ELSE
	BEGIN
		SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta, ok = 1
		FROM Intervenciones
		WHERE id_consulta = @id_consulta;
	END
GO


CREATE PROC SP_Obtener_Intervenciones_Por_Id
	(@id_intervencion VARCHAR(12))
AS
	IF(@id_intervencion = '')
		BEGIN
			SELECT message = 'El campo id_intervencion viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_intervencion) = 0)
		BEGIN
			SELECT message = 'El campo id_intervencion no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Intervencion' = id_intervencion, 'Tratamiento' = tratamiento, 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Id_Consulta' = id_consulta, ok = 1
			FROM Intervenciones
			WHERE id_intervencion = @id_intervencion;
		END
GO

CREATE PROC SP_Obtener_Especialidades
AS
	SELECT 'Id_Especialidad' = id_especialidad, 'Nombre_Especialidad' = nombre_especialdad, ok = 1
	FROM Especialidad
GO

CREATE PROC SP_Obtener_Especialidades_Por_Id
	(@id_especialidad VARCHAR(12))
AS
	IF(@id_especialidad = '')
		BEGIN
			SELECT message = 'El campo id_especialidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_especialidad) = 0)
		BEGIN
			SELECT message = 'El campo id_especialidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Especialidad' = id_especialidad, 'Nombre_Especialidad' = nombre_especialdad, ok = 1
			FROM Especialidad
			WHERE id_especialidad = @id_especialidad;
		END
GO

CREATE PROC SP_Obtener_Especialidades_Por_Medico_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id medico viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id medico no es numerico', ok = 0
		END
	ELSE IF(NOT EXISTS(SELECT id_medico FROM Medico WHERE id_medico = @id_medico))
		BEGIN
			SELECT message = 'El id del medico no existe', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Especialidad' = e.id_especialidad, 'Nombre_Especialidad' = e.nombre_especialdad, ok = 1
			FROM Especialidad e
			INNER JOIN Medico_Especialidad me ON e.id_especialidad = me.id_especialidad
			WHERE me.id_medico = @id_medico;
		END
GO

CREATE PROC SP_Obtener_Padece
AS
	SELECT 'Id_Padece' = id_padece, 'Id_Paciente' = id_paciente, 'Id_Enfermedad' = id_enfermedad, 'Id_Consulta' = id_consulta, ok = 1
	FROM Padece
GO

CREATE PROC SP_Obtener_Padece_Por_Id
	(@id_padece VARCHAR(12))
AS
	IF(@id_padece = '')
		BEGIN
			SELECT message = 'El campo id_padece viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_padece) = 0)
		BEGIN
			SELECT message = 'El campo id_padece no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Padece' = id_padece, 'Id_Paciente' = id_paciente, 'Id_Enfermedad' = id_enfermedad,'Id_Consulta' id_consulta,ok = 1
			FROM Padece
			WHERE id_padece = @id_padece;
		END
GO

CREATE PROC SP_Obtener_Tipos_Intervenciones
AS
	SELECT 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = nombre_tipo_intervencion, ok = 1
	FROM Tipo_Intervencion
GO

CREATE PROC SP_Obtener_Tipo_Intervencion_Por_Id_Consulta
	(@id_consulta VARCHAR(12))
AS
	IF(@id_consulta = '')
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta está vacío', ok = 0
	END
		ELSE IF(ISNUMERIC(@id_consulta) = 0)
	BEGIN
		SELECT MESSAGE = 'El campo id_consulta no es númerico'
	END
		ELSE
	BEGIN
		SELECT 'Id_Tipo_Intervencion' = Tipo_Intervencion.id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = Tipo_Intervencion.nombre_tipo_intervencion, ok = 1
		FROM Tipo_Intervencion INNER JOIN Intervenciones ON Tipo_Intervencion.id_tipo_intervencion = Intervenciones.id_tipo_intervencion
		WHERE id_consulta = @id_consulta;
	END
GO

CREATE PROC SP_Obtener_Tipos_Intervencione_Por_Id
	(@id_tipo_intervencion VARCHAR(12))
AS
	IF(@id_tipo_intervencion = '')
		BEGIN
			SELECT message = 'El campo id_tipo_intervencion viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_tipo_intervencion) = 0)
		BEGIN
			SELECT message = 'El campo id_tipo_intervencion no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Tipo_Intervencion' = id_tipo_intervencion, 'Nombre_Tipo_Intervencion' = nombre_tipo_intervencion, ok = 1
			FROM Tipo_Intervencion
			WHERE id_tipo_intervencion = @id_tipo_intervencion;
		END
GO

CREATE PROC SP_Obtener_Medico_Especialidad
AS
	SELECT 'Id_Medico_Especialidad' = id_medico_especialidad, 'Id_Medico' = id_medico, 'Id_Especialidad' = id_especialidad, ok = 1
	FROM Medico_Especialidad
GO

USE GUANA_HOSPI
GO
CREATE PROC SP_Obtener_Medico_Especialidad_Por_Medico_Id
	(@id_medico VARCHAR(12))
AS
	IF(@id_medico = '')
		BEGIN
			SELECT message = 'El campo id_medico_especialidad viene vacio', ok = 0
		END
	ELSE IF(ISNUMERIC(@id_medico) = 0)
		BEGIN
			SELECT message = 'El campo id_medico_especialidad no es numerico', ok = 0
		END
	ELSE
		BEGIN
			SELECT 'Id_Medico_Especialidad' = id_medico_especialidad, 'Id_Medico' = id_medico, 'Id_Especialidad' = id_especialidad, ok = 1
			FROM Medico_Especialidad
			WHERE id_medico = @id_medico;
		END
GO

CREATE PROC SP_Obtener_Auditoria
AS
	SELECT 'Email' = Usuario, 'Fecha' = Fecha, 'Accion' = Descripcion, ok = 1
	FROM Auditoria
GO