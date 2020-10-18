

use datos
go
Select Top 5 PROVINCIA, COUNT(PROVINCIA) AS PROVINCIA
from rutas
Group by PROVINCIA
Order by count(PROVINCIA) desc

USE DW_GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Enfermedades
	As
		Select Top 5 e.nombre_enfermedad, COUNT(p.id_enfermedad) AS Cantidad
			from DW_GUANA_HOSPI.DBO.Enfermedad e inner join DW_GUANA_HOSPI.DBO.Padece p
			ON e.id_enfermedad = p.id_enfermedad
			Group by e.nombre_enfermedad
		Order by count(*) desc 	
	Go


EXEC  SP_Top_Enfermedades




USE DW_GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Unidades
	As
		Select Top 5 u.nombre_unidad, u.numero_planta, COUNT(p.id_unidad) AS Cantidad
			from DW_GUANA_HOSPI.DBO.Unidad u inner join DW_GUANA_HOSPI.DBO.Paciente_Unidad p
			on u.id_unidad = p.id_unidad
			Group by u.nombre_unidad
		Order by count(*) desc 	
GO


EXEC SP_Top_Unidades





USE DW_GUANA_HOSPI
GO
	SELECT * FROM Unidad
	SELECT * FROM Paciente_Unidad
GO



USE DW_GUANA_HOSPI
GO
CREATE PROCEDURE SP_Top_Medico_Intervenciones
	AS
SELECT TOP 5 m.codigo_medico,p.dni_persona, p.nombre_persona, p.apellido_1, 
		p.apellido_2, p.edad, COUNT(id_intervencion) AS Cantidad FROM Medico m 
		INNER JOIN Persona p ON m.dni_persona = p.dni_persona
		INNER JOIN Unidad_Medico um ON um.id_medico = m.id_medico
		INNER JOIN Unidad u ON um.id_unidad = u.id_unidad
		INNER JOIN Consulta_Unidad cu ON cu.id_unidad = u.id_unidad
		INNER JOIN Consulta c ON c.id_consulta = cu.id_consulta 
		INNER JOIN Intervenciones i ON i.id_consulta = c.id_consulta
	Group by m.id_medico
	Order by count(id_intervencion) desc
GO









USE DW_GUANA_HOSPI
GO
SELECT * FROM Padece
SELECT * FROM Enfermedad


GO
DROP PROCEDURE SP_Top_Enfermedades