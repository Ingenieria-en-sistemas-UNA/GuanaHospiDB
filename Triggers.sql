USE GUANA_HOSPI
GO
-------------------------REGRISTRO DE INSERTAR--------------------------------
CREATE TRIGGER TR_Insertar_Medico
ON Medico AFTER INSERT
 AS
     DECLARE @Id_Usuario NVARCHAR
	 DECLARE @Email NVARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha Creado Un Medico!!')

GO

CREATE TRIGGER TR_Insertar_Paciente
On Paciente AFTER INSERT
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Agregado Un Nuevo Paciente!!')
 GO

CREATE TRIGGER TR_Insertar_Unidad
 ON Unidad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Agregado Una Nueva Unidad!!')
 GO

CREATE TRIGGER TR_Insertar_Especialidad
 ON Especialidad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Una Especialidad!!')
  GO


CREATE TRIGGER TR_Insertar_Enfermadades
ON Enfermedad AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Una Enfermedad!!')
  GO

CREATE TRIGGER TR_Insertar_User
ON users AFTER INSERT
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Un Nuevo Usuario!!')
  GO



CREATE TRIGGER TR_Insetar_Tipo_Intervencion
ON Tipo_Intervencion AFTER INSERT
	AS
		DECLARE @Id_Usuario NVARCHAR
		DECLARE @Email NVARCHAR(MAX)
		SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
		SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
		INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Añadido Un Tipo De Intervención!!')
	GO

------------------------Registros De Actualizar-------------------------------
CREATE TRIGGER TR_Actualizar_Medico
ON Medico AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos Del Medico!!')
 GO


 CREATE TRIGGER TR_Actualizar_Paciente
ON Paciente AFTER UPDATE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Actualizado Los Datos Del Paciente!!')
 GO




--------------------------ELIMINAR--------------------------
CREATE TRIGGER TR_Eliminar_Medico
ON Medico AFTER DELETE
 AS
     DECLARE @Id_Usuario NVARCHAR
	 DECLARE @Email NVARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha Eliminado Un Medico De La Lista!!')

GO


CREATE TRIGGER TR_Eliminar_Paciente
On Paciente AFTER DELETE
 AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Al Paciente!!')
 GO



 CREATE TRIGGER TR_Eliminar_Unidad
 ON Unidad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Unidad De La Lista!!')
 GO

 CREATE TRIGGER TR_Eliminar_Especialidad
 ON Especialidad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Especialidad De La Lista!!')
  GO

  CREATE TRIGGER TR_Elimina_Enfermadades
ON Enfermedad AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Enfermedad!!')
  GO


    CREATE TRIGGER TR_Eliminar_Tipo_Intervension
ON Tipo_Intervencion AFTER DELETE
  AS
    DECLARE @Id_Usuario NVARCHAR
	DECLARE @Email NVARCHAR(MAX)
	SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(),'Ha Eliminado Una Enfermedad!!')
  GO

-- DROP TRIGGER TR_Eliminar_Unidad   -- SELECT * FROM Auditoria