USE GUANA_HOSPI
GO

CREATE TRIGGER TR_Insertar_Medico
ON Medico AFTER INSERT
 AS
     DECLARE @Id_Usuario VARCHAR(MAX)
	 DECLARE @Email VARCHAR(MAX)
	 SELECT @Id_Usuario = CAST(CONTEXT_INFO() AS VARCHAR(MAX))
	 SELECT @Email = email FROM users WHERE id = CONVERT(INT, @Id_Usuario)
	 INSERT INTO Auditoria (Usuario, Fecha, Descripcion) VALUES (@Email, GETDATE(), 'Ha creado un medico!!')

GO
