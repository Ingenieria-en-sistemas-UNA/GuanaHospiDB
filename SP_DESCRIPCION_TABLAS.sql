USE GUANA_HOSPI

-- simplify syntax for maintaining data dictionary
-- Fuente: https://stackoverflow.com/questions/17173260/check-if-extended-property-description-already-exists-before-adding

IF OBJECT_ID('dbo.usp_addorupdatedescription', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_addorupdatedescription;
GO

CREATE PROCEDURE usp_addorupdatedescription @table nvarchar(128), -- table name
                                            @column nvarchar(128), -- column name, NULL if description for table
                                            @descr sql_variant -- description text
AS
	BEGIN
		SET NOCOUNT ON;

		IF @column IS NOT NULL
			IF NOT EXISTS(SELECT NULL
						  FROM SYS.EXTENDED_PROPERTIES
						  WHERE [major_id] = OBJECT_ID(@table)
							AND [name] = N'MS_Description'
							AND [minor_id] = (SELECT [column_id]
											  FROM SYS.COLUMNS
											  WHERE [name] = @column
												AND [object_id] = OBJECT_ID(@table)))
				EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = @descr,
						@level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE',
						@level1name = @table, @level2type = N'COLUMN', @level2name = @column;
			ELSE
				EXECUTE sp_updateextendedproperty @name = N'MS_Description',
						@value = @descr, @level0type = N'SCHEMA', @level0name = N'dbo',
						@level1type = N'TABLE', @level1name = @table,
						@level2type = N'COLUMN', @level2name = @column;
		ELSE
			IF NOT EXISTS(SELECT NULL
						  FROM SYS.EXTENDED_PROPERTIES
						  WHERE [major_id] = OBJECT_ID(@table)
							AND [name] = N'MS_Description'
							AND [minor_id] = 0)
				EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = @descr,
						@level0type = N'SCHEMA', @level0name = N'dbo',
						@level1type = N'TABLE', @level1name = @table;
			ELSE
				EXECUTE sp_updateextendedproperty @name = N'MS_Description', @value = @descr,
						@level0type = N'SCHEMA', @level0name = N'dbo',
						@level1type = N'TABLE', @level1name = @table;
	END
GO

EXEC usp_addorupdatedescription 'Persona', 'dni_persona', 'Es el numero de cedula de la persona que funciona como PK'
EXEC usp_addorupdatedescription 'Persona', 'nombre_persona', 'Es el nombre de la persona'
EXEC usp_addorupdatedescription 'Persona', 'apellido_1', 'Es el primer apellido de la persona'
EXEC usp_addorupdatedescription 'Persona', 'apellido_2', 'Es el segundo apellido de la persona'
EXEC usp_addorupdatedescription 'Persona', 'edad', 'Es la edad de la persona'