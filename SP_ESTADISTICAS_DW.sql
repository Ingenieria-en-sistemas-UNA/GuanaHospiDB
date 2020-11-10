
USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Enfermedades
AS
		SELECT TOP 5 e.nombre_enfermedad, COUNT(p.id_enfermedad) AS Cantidad, 'Id_Enfermedad' = e.id_enfermedad
			FROM DW_GUANA_HOSPI.DBO.Enfermedad e 
			INNER JOIN DW_GUANA_HOSPI.DBO.Padece p
			ON e.id_enfermedad = p.id_enfermedad
		GROUP BY e.nombre_enfermedad, e.id_enfermedad
		ORDER BY COUNT(p.id_enfermedad) DESC 	
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Unidades
AS
		SELECT TOP 3 u.nombre_unidad, u.numero_planta, u.id_unidad, 'Cantidad' = COUNT(c.id_unidad)
			FROM DW_GUANA_HOSPI.DBO.Unidad u 
			INNER JOIN DW_GUANA_HOSPI.DBO.Consulta c
			ON u.id_unidad = c.id_unidad
		GROUP BY u.nombre_unidad, u.numero_planta, u.id_unidad
		ORDER BY COUNT(c.id_paciente) DESC 	
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Medico_Intervenciones
AS
	SELECT TOP 1 m.codigo_medico, p.dni_persona, p.nombre_persona, p.apellido_1, 
		p.apellido_2, 'Cantidad' = COUNT(i.id_intervencion)
		FROM DW_GUANA_HOSPI.DBO.Medico m 
		INNER JOIN DW_GUANA_HOSPI.DBO.Persona p ON m.dni_persona = p.dni_persona
		INNER JOIN DW_GUANA_HOSPI.DBO.Consulta co ON co.id_medico = m.id_medico	
		INNER JOIN DW_GUANA_HOSPI.DBO.Intervenciones i ON i.id_consulta = co.id_consulta
	GROUP BY m.codigo_medico, p.dni_persona, p.nombre_persona, p.apellido_1, p.apellido_2
	ORDER BY COUNT(i.id_intervencion) DESC
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Tipo_Intervenciones
AS
	SELECT TOP 5 ti.nombre_tipo_intervencion, i.tratamiento, ti.id_tipo_intervencion , 'Cantidad' = COUNT(ti.id_tipo_intervencion)
	FROM DW_GUANA_HOSPI.DBO.Tipo_Intervencion ti
		INNER JOIN DW_GUANA_HOSPI.DBO.Intervenciones i ON ti.id_tipo_intervencion = i.id_tipo_intervencion
	GROUP BY ti.nombre_tipo_intervencion, i.tratamiento, ti.id_tipo_intervencion
	ORDER BY COUNT(ti.id_tipo_intervencion) DESC
GO

--use datos
--go
--Select Top 5 PROVINCIA, COUNT(PROVINCIA) AS PROVINCIA
--from rutas
--Group by PROVINCIA
--Order by count(PROVINCIA) desc

--EXEC  SP_Top_Enfermedades

--EXEC SP_Top_Unidades

--USE DW_GUANA_HOSPI
--GO
--	SELECT * FROM Unidad
--	SELECT * FROM Paciente_Unidad
--GO

--DROP PROC SP_Top_Medico_Intervenciones

--USE DW_GUANA_HOSPI
--GO
--SELECT * FROM Padece
--SELECT * FROM Enfermedad

--exec SP_Top_Medico_Intervenciones
--GO
--DROP PROCEDURE SP_Top_Enfermedades
