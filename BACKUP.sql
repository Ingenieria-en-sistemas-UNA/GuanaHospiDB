---Backup Full
BACKUP DATABASE [GUANA_HOSPI] TO  DISK = N'C:\Backup\Full_Backup_GuanaHospi' WITH NOFORMAT, NOINIT,  NAME = N'GUANA_HOSPI-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'GUANA_HOSPI' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'GUANA_HOSPI' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''GUANA_HOSPI'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Backup\Full_Backup_GuanaHospi' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO


---Backup Diferencial
BACKUP DATABASE [GUANA_HOSPI] TO  DISK = N'C:\Backup\Backup_Diferencial_GuanaHospi' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'GUANA_HOSPI-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'GUANA_HOSPI' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'GUANA_HOSPI' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''GUANA_HOSPI'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Backup\Backup_Diferencial_GuanaHospi' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

---Backup Transaccional
BACKUP LOG [GUANA_HOSPI] TO  DISK = N'C:\Backup\TRN_GuanaHospi' WITH NOFORMAT, NOINIT,  NAME = N'GUANA_HOSPI-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'GUANA_HOSPI' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'GUANA_HOSPI' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''GUANA_HOSPI'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Backup\TRN_GuanaHospi' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

