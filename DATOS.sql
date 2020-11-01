USE GUANA_HOSPI
GO

CREATE PROC SP_Seed_GuanaHospi
AS
    -----------------PERSONA--------------------------------
    EXEC SP_Crear_Persona '1', 'Tatiana', 'Morales', 'Mendez', 19
    EXEC SP_Crear_Persona '2', 'Luis', 'Rodriguez', 'Baltodano', 21
    EXEC SP_Crear_Persona '3', 'Arlen', 'Vargas', 'Galvez', 19
    EXEC SP_Crear_Persona '4', 'Ricardo', 'Morataya', 'Morataya', 20
    EXEC SP_Crear_Persona '5', 'Enrique', 'Arias', 'Salgado', 20

    EXEC SP_Crear_Persona '6', 'Erick', 'Parra', 'Sequeira', 20
    EXEC SP_Crear_Persona '7', 'Emilio', 'Galvez', 'Vargas', 45
    EXEC SP_Crear_Persona '8', 'Daniel', 'Sequeira', 'Parra', 38
    EXEC SP_Crear_Persona '9', 'Carlos', 'Salgado', 'Arias', 31
    EXEC SP_Crear_Persona '10','Jafet', 'Morataya', 'Galvez', 51

    ----------------------ESPECIALIDAD--------------------------
    EXEC SP_Crear_Especialidad 'Dermatologia'
    EXEC SP_Crear_Especialidad 'Urologia'
    EXEC SP_Crear_Especialidad 'Ginecologia'
    EXEC SP_Crear_Especialidad 'Otorrinolaringologia'
    EXEC SP_Crear_Especialidad 'Oftalmologia'

    -----------------------MEDICO-------------------------------
    EXEC SP_Crear_Medico 1234, 1
    EXEC SP_Crear_Medico 2323, 2
    EXEC SP_Crear_Medico 5344, 3
    EXEC SP_Crear_Medico 6453, 4
    EXEC SP_Crear_Medico 4656, 5

    -----------------------Roles-------------------------------
    EXEC SP_Crear_Role 'Administrador'
    EXEC SP_Crear_Role 'Medico'

    -----------------Medico Especialid--------------------------
    EXEC SP_Crear_Medico_Especialidad 1, 1
	EXEC SP_Crear_Medico_Especialidad 2, 4
	EXEC SP_Crear_Medico_Especialidad 2, 3
    EXEC SP_Crear_Medico_Especialidad 2, 2
    EXEC SP_Crear_Medico_Especialidad 3, 3
    EXEC SP_Crear_Medico_Especialidad 4, 4
    EXEC SP_Crear_Medico_Especialidad 5, 5

    -----------------------UNIDAD-------------------------------
    EXEC SP_Crear_Unidad 'Sala A1', 1, 1
    EXEC SP_Crear_Unidad 'Sala B1', 1, 2
    EXEC SP_Crear_Unidad 'Sala C1', 1, 3
    EXEC SP_Crear_Unidad 'Sala D1', 1, 4
    EXEC SP_Crear_Unidad 'Sala A2', 2, 4
    EXEC SP_Crear_Unidad 'Sala B2', 2, 5
    EXEC SP_Crear_Unidad 'Sala C2', 2
    EXEC SP_Crear_Unidad 'Sala D2', 2

    -----------------------SINTOMA----------------------------------
    EXEC SP_Crear_Sintoma 'Dolor de cabeza'
    EXEC SP_Crear_Sintoma 'Nauseas'
    EXEC SP_Crear_Sintoma 'Dolor'
    EXEC SP_Crear_Sintoma 'Somnolencia'
    EXEC SP_Crear_Sintoma 'Tos'
    EXEC SP_Crear_Sintoma 'Fiebre'
    EXEC SP_Crear_Sintoma 'Dearrea'
    EXEC SP_Crear_Sintoma 'Dificulta respiratoria'
    EXEC SP_Crear_Sintoma 'Dolor de estomago'

    -----------------------PACIENTE----------------------------------
    EXEC SP_Crear_Paciente 2332, '2020/09/5', '6'	
    EXEC SP_Crear_Paciente 3839, '2020/08/20', '7'
    EXEC SP_Crear_Paciente 4039, '2020/07/3', '8'
    EXEC SP_Crear_Paciente 9284, '2020/06/16', '9'

    -----------------------CONSULTA-----------------------------------
    EXEC SP_Crear_Consulta '2020/09/5', 1, 1
    EXEC SP_Crear_Consulta '2020/09/5', 2, 2
    EXEC SP_Crear_Consulta '2020/09/5', 3, 3
    EXEC SP_Crear_Consulta '2020/09/5', 4, 4
	EXEC SP_Crear_Consulta '2020/09/5', 1, 4
	EXEC SP_Crear_Consulta '2020/09/5', 1, 4
    -----------------------PRESENTE----------------------------------
    EXEC SP_Crear_Presenta 1, 1, 'Tiene que consumir mas agua'
    EXEC SP_Crear_Presenta 2, 2, 'Tiene que caminar'
    EXEC SP_Crear_Presenta 3, 3, 'Tiene que dormir mas'
    EXEC SP_Crear_Presenta 4, 4, 'Tiene que consumir drogas'

    ----------------------ENFERMEDAD---------------------------------
    EXEC SP_Crear_Enfermedad 'Cancer'
    EXEC SP_Crear_Enfermedad 'Dengue'
    EXEC SP_Crear_Enfermedad 'Cockbig'
    EXEC SP_Crear_Enfermedad 'Asma'
    EXEC SP_Crear_Enfermedad 'Ebola'
    EXEC SP_Crear_Enfermedad 'Diabetes'
    EXEC SP_Crear_Enfermedad 'Sida'

    ------------------------PADECE--------------------------------------
    EXEC SP_Crear_Padece 1, 1
    EXEC SP_Crear_Padece 2, 2
    EXEC SP_Crear_Padece 3, 3
    EXEC SP_Crear_Padece 4, 4
	EXEC SP_Crear_Padece 1, 1
	EXEC SP_Crear_Padece 2, 1

    --------------------------TIPO INTERVENCION--------------------------
    EXEC SP_Crear_Tipo_Intervencion 'Cirugia'
    EXEC SP_Crear_Tipo_Intervencion 'Dieta'
    EXEC SP_Crear_Tipo_Intervencion 'Ejercicio'
    EXEC SP_Crear_Tipo_Intervencion 'Medicamento'
    EXEC SP_Crear_Tipo_Intervencion 'Salud'

    ------------------------------INTERVENCION-----------------------------
    EXEC SP_Crear_Intervencion 'Tomar dos pastillas cada 6 horas', 1, 1
    EXEC SP_Crear_Intervencion 'Comer frutas y tomar 2 litos de agua', 2, 2
    EXEC SP_Crear_Intervencion 'Caminar 20 minutos por dia', 3, 3
    EXEC SP_Crear_Intervencion 'Evitar comida chatarra', 4, 4
GO


EXEC SP_Seed_GuanaHospi