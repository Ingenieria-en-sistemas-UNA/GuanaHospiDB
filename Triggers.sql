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


-- DROP TRIGGER TR_Insertar_Medico   -- SELECT * FROM Auditoria