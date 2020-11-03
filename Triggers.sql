USE GUANA_HOSPI
GO

CREATE TRIGGER TR_Insertar_Medico
ON Medico AFTER INSERT
 AS
     DECLARE @Id_Usuario NVARCHAR
	 DECLARE @Email NVARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS NVARCHAR)
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha creado un medico!!')

GO

-- DROP TRIGGER TR_Insertar_Medico