USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_Eliminar_Tablas_DW
AS
	SELECT message = 'Se elimino los datos exitosamente', ok = 1
	DELETE FROM DW_GUANA_HOSPI..Consulta;
	DELETE FROM DW_GUANA_HOSPI..Enfermedad
	DELETE FROM DW_GUANA_HOSPI..Intervenciones
	DELETE FROM DW_GUANA_HOSPI..Medico
	DELETE FROM DW_GUANA_HOSPI..Padece
	DELETE FROM DW_GUANA_HOSPI..Persona
	DELETE FROM DW_GUANA_HOSPI..Tipo_Intervencion
	DELETE FROM DW_GUANA_HOSPI..Unidad
GO

USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_LLenarDW
AS

	SELECT message = 'Se cargaron los datos exitosamente', ok = 1
	EXEC SP_Eliminar_Tablas_DW
	
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Consulta OUT C:\BCP\Consulta.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Enfermedad OUT C:\BCP\Enfermedad.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Intervenciones OUT C:\BCP\Intervenciones.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Medico OUT C:\BCP\Medico.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Padece OUT C:\BCP\Padece.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Persona OUT C:\BCP\Persona.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Tipo_Intervencion OUT C:\BCP\Tipo_Intervencion.txt -T -c'
	EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Unidad OUT C:\BCP\Unidad.txt -T -c'

	BULK INSERT DW_GUANA_HOSPI.dbo.Consulta  FROM 'C:\BCP\Consulta.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Enfermedad FROM 'C:\BCP\Enfermedad.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Intervenciones FROM 'C:\BCP\Intervenciones.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Medico FROM 'C:\BCP\Medico.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Padece FROM 'C:\BCP\Padece.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Persona FROM 'C:\BCP\Persona.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Tipo_Intervencion FROM 'C:\BCP\Tipo_Intervencion.txt'
	BULK INSERT DW_GUANA_HOSPI.dbo.Unidad FROM 'C:\BCP\Unidad.txt'
GO
--EXEC SP_LLenarDW
	
--EXEC SP_Eliminar_Tablas_DW

--    use GUANA_HOSPI
--	go
--	drop procedure SP_Eliminar_Tablas_DW
--	drop procedure SP_LLenarDW