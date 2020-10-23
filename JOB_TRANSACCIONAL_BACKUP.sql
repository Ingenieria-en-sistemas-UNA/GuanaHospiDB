USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'TRN_Backup_GuanaHospi', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Respaldo transaccional de la base de datos GuanaHospi', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-GPACOU6\Luis', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'TRN_Backup_GuanaHospi', @server_name = N'DESKTOP-GPACOU6\PRACTICA'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'TRN_Backup_GuanaHospi', @step_name=N'TRN_Backup_GuanaHospi', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP LOG [GUANA_HOSPI] TO  DISK = N''C:\Backup\TRN_GuanaHospi'' WITH NOFORMAT, NOINIT,  NAME = N''GUANA_HOSPI-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N''GUANA_HOSPI'' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N''GUANA_HOSPI'' )
if @backupSetId is null begin raiserror(N''Verify failed. Backup information for database ''''GUANA_HOSPI'''' not found.'', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N''C:\Backup\TRN_GuanaHospi'' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO', 
		@database_name=N'GUANA_HOSPI', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'TRN_Backup_GuanaHospi', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Respaldo transaccional de la base de datos GuanaHospi', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'DESKTOP-GPACOU6\Luis', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'TRN_Backup_GuanaHospi', @name=N'TRN_Backup_GuanaHospi', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=127, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20201022, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
