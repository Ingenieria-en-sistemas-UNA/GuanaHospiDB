
USE GUANA_HOSPI
GO
CREATE PROCEDURE SP_LLenarDW
	AS
		delete from DW_GUANA_HOSPI..Consulta;
		delete from DW_GUANA_HOSPI..Enfermedad
		delete from DW_GUANA_HOSPI..Intervenciones
		delete from DW_GUANA_HOSPI..Medico
		delete from DW_GUANA_HOSPI..Paciente
		delete from DW_GUANA_HOSPI..Paciente_Unidad
		delete from DW_GUANA_HOSPI..Padece
		delete from DW_GUANA_HOSPI..Persona
		delete from DW_GUANA_HOSPI..Tipo_Intervencion
		delete from DW_GUANA_HOSPI..Unidad
		
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Consulta OUT C:\BCP\Consulta.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Enfermedad OUT C:\BCP\Enfermedad.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Intervenciones OUT C:\BCP\Intervenciones.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Medico OUT C:\BCP\Medico.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Paciente OUT C:\BCP\Paciente.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Paciente_Unidad OUT C:\BCP\Paciente_Unidad.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Padece OUT C:\BCP\Padece.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Persona OUT C:\BCP\Persona.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Tipo_Intervencion OUT C:\BCP\Tipo_Intervencion.txt -T -c'
 EXEC master..xp_cmdshell 'BCP GUANA_HOSPI.dbo.Unidad OUT C:\BCP\Unidad.txt -T -c'


 BULK INSERT DW_GUANA_HOSPI.dbo.Consulta  FROM 'C:\BCP\Consulta.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Enfermedad FROM 'C:\BCP\Enfermedad.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Intervenciones FROM 'C:\BCP\Intervenciones.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Medico FROM 'C:\BCP\Medico.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Paciente FROM 'C:\BCP\Paciente.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Paciente_Unidad FROM 'C:\BCP\Paciente_Unidad.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Padece FROM 'C:\BCP\Padece.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Persona FROM 'C:\BCP\Persona.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Tipo_Intervencion FROM 'C:\BCP\Tipo_Intervencion.txt'
 BULK INSERT DW_GUANA_HOSPI.dbo.Unidad FROM 'C:\BCP\Unidad.txt'
 
GO


EXEC SP_LLenarDW


