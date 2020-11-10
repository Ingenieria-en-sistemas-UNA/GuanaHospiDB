USE GUANA_HOSPI
GO

-- Fuente de SP: https://stackoverflow.com/questions/6487885/generating-data-dictionary-for-sql-server-database

CREATE PROC SP_obtener_diccionario_tabla @NombreTabla varchar(20),
                                         @NombreDB varchar(20)
AS
    IF @NombreTabla = ''
        BEGIN
            PRINT 'EL NOMBRE DE LA TABLA ES OBLIGATORIO'
        END
    ELSE
        IF @NombreDB = ''
            BEGIN
                PRINT 'EL NOMBRE DE LA BASE DE DATOS ES OBLIGATORIO'
            END
        ELSE
            IF NOT EXISTS(SELECT *
                          FROM INFORMATION_SCHEMA.TABLES
                          WHERE TABLE_NAME = @NombreTabla)
                BEGIN
                    PRINT CONCAT('NO EXISTE UNA TABLA CON EL NOMBRE: ', @NombreTabla, ', EN LA BASE DE DATOS: ', @NombreDB)
                END
            ELSE
                BEGIN
                    SELECT IC.COLUMN_NAME AS 'Nombre de las Columnas',
                           IC.Data_TYPE AS 'Tipo de Dato',
                           EP.[Value] AS 'Descripción del campo',
                           IKU.CONSTRAINT_NAME AS 'Nombre del Constraint',
                           ITC.CONSTRAINT_TYPE AS 'Tipo de Constraint',
                           IC.IS_NULLABLE AS 'Permite Nulo'
                    FROM INFORMATION_SCHEMA.COLUMNS IC
                             INNER JOIN sys.columns sc
                                        ON OBJECT_ID(QUOTENAME(IC.TABLE_SCHEMA) + '.' + QUOTENAME(IC.TABLE_NAME)) =
                                           sc.[object_id] AND IC.COLUMN_NAME = sc.name
                             LEFT OUTER JOIN sys.extended_properties EP
                                             ON sc.[object_id] = EP.major_id AND sc.[column_id] = EP.minor_id AND
                                                EP.name = 'MS_Description' AND EP.class = 1
                             LEFT OUTER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE IKU
                                             ON IKU.COLUMN_NAME = IC.COLUMN_NAME and IKU.TABLE_NAME = IC.TABLE_NAME and
                                                IKU.TABLE_CATALOG = IC.TABLE_CATALOG
                             LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS ITC
                                             ON ITC.TABLE_NAME = IKU.TABLE_NAME and
                                                ITC.CONSTRAINT_NAME = IKU.CONSTRAINT_NAME
                    WHERE IC.TABLE_CATALOG = @NombreDB
                      and IC.TABLE_SCHEMA = 'dbo'
                      and IC.TABLE_NAME = @NombreTabla
                    order by IC.ORDINAL_POSITION
                END
GO

EXEC SP_obtener_diccionario_tabla 'Persona', 'GUANA_HOSPI'
/*
EXEC SP_obtener_diccionario_tabla 'Auditoria', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Consulta', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Enfermedad', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Especialidad', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Intervenciones', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Medico', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Medico_Especialidad', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Paciente', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Padece', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Roles', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Tipo_Intervencion', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'Unidad', 'GUANA_HOSPI'
EXEC SP_obtener_diccionario_tabla 'users', 'GUANA_HOSPI'
*/