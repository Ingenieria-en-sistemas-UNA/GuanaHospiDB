USE GUANA_HOSPI
GO
-----------------PERSONA--------------------------------
EXEC SP_CrearPersona '1', 'Tatiana', 'Morales', 'Mendez', 19
EXEC SP_CrearPersona '2', 'Luis', 'Rodriguez', 'Baltodano', 21
EXEC SP_CrearPersona '3', 'Arlen', 'Vargas', 'Galvez', 19
EXEC SP_CrearPersona '4', 'Ricardo', 'Morataya', 'Morataya', 20
EXEC SP_CrearPersona '5', 'Enrique', 'Arias', 'Salgado', 20

EXEC SP_CrearPersona '6', 'Erick', 'Parra', 'Sequeira', 20
EXEC SP_CrearPersona '7', 'Emilio', 'Galvez', 'Vargas', 45
EXEC SP_CrearPersona '8', 'Daniel', 'Sequeira', 'Parra', 38
EXEC SP_CrearPersona '9', 'Carlos', 'Salgado', 'Arias', 31
EXEC SP_CrearPersona '10','Jafet', 'Morataya', 'Galvez', 51

----------------------USUARIO------------------------------
EXEC SP_CrearUsuario 'tamo', '12345'
EXEC SP_CrearUsuario 'luis1', 'password'
EXEC SP_CrearUsuario 'Nelra', '54321'
EXEC SP_CrearUsuario 'ricmor', 'contrasenna'
EXEC SP_CrearUsuario 'enrique777', 'abcdef'

----------------------ESPECIALIDAD--------------------------
EXEC SP_CrearEspecialidad 'Dermatolog�a'
EXEC SP_CrearEspecialidad 'Urolog�a'
EXEC SP_CrearEspecialidad 'Ginecolog�a'
EXEC SP_CrearEspecialidad 'Otorrinolaringolog�a'
EXEC SP_CrearEspecialidad 'Oftalmolog�a'

-----------------------MEDICO-------------------------------
EXEC SP_CrearMedico 1234, 1, 1, '1'
EXEC SP_CrearMedico 2323, 2, 2, '2'
EXEC SP_CrearMedico 5344, 3, 3, '3'
EXEC SP_CrearMedico 6453, 4, 4, '4'
EXEC SP_CrearMedico 4656, 5, 5, '5'

-----------------------UNIDAD-------------------------------
EXEC SP_CrearUnidad 'Sala A1', 1
EXEC SP_CrearUnidad 'Sala B1', 1
EXEC SP_CrearUnidad 'Sala C1', 1
EXEC SP_CrearUnidad 'Sala D1', 1
EXEC SP_CrearUnidad 'Sala A2', 2
EXEC SP_CrearUnidad 'Sala B2', 2
EXEC SP_CrearUnidad 'Sala C2', 2
EXEC SP_CrearUnidad 'Sala D2', 2

----------------------UNIDAD MEDICO---------------------------
EXEC SP_CrearUnidadMedico 1, 1
EXEC SP_CrearUnidadMedico 2, 2
EXEC SP_CrearUnidadMedico 3, 3
EXEC SP_CrearUnidadMedico 4, 4

-----------------------SINTOMA----------------------------------
EXEC SP_CrearSintoma 'Dolor de cabeza'
EXEC SP_CrearSintoma 'Nauseas'
EXEC SP_CrearSintoma 'Dolor'
EXEC SP_CrearSintoma 'Somnolencia'
EXEC SP_CrearSintoma 'Tos'
EXEC SP_CrearSintoma 'Fiebre'
EXEC SP_CrearSintoma 'Dearrea'
EXEC SP_CrearSintoma 'Dificulta respiratoria'
EXEC SP_CrearSintoma 'Dolor de estomago'

-----------------------PACIENTE----------------------------------
EXEC SP_CrearPaciente 2332, '2020/09/5', '6'	
EXEC SP_CrearPaciente 3839, '2020/08/20', '7'
EXEC SP_CrearPaciente 4039, '2020/07/3', '8'
EXEC SP_CrearPaciente 9284, '2020/06/16', '9'

-----------------------CONSULTA-----------------------------------
EXEC SP_CrearConsulta '2020/09/5', 'DOLOR DE CABEZA', 1, 1
EXEC SP_CrearConsulta '2020/09/5', 'DOLOR DE CUELLO', 2, 2
EXEC SP_CrearConsulta '2020/09/5', 'DOLOR DE ESPALDA', 3, 3
EXEC SP_CrearConsulta '2020/09/5', 'DOLOR DE MUELA', 4, 4

-----------------------PRESENTE----------------------------------
EXEC SP_CrearPresenta 1, 1, 'Tiene que consumir mas agua'
EXEC SP_CrearPresenta 2, 2, 'Tiene que caminar'
EXEC SP_CrearPresenta 3, 3, 'Tiene que dormir mas'
EXEC SP_CrearPresenta 4, 4, 'Tiene que consumir drogas'

----------------------ENFERMEDAD---------------------------------
EXEC SP_CrearEnfermedad 'Cancer'
EXEC SP_CrearEnfermedad 'Dengue'
EXEC SP_CrearEnfermedad 'Cockbig'
EXEC SP_CrearEnfermedad 'Asma'
EXEC SP_CrearEnfermedad 'Ebola'
EXEC SP_CrearEnfermedad 'Diabetes'
EXEC SP_CrearEnfermedad 'Sida'

------------------------PADECE--------------------------------------
EXEC SP_CrearPadece 1, 1
EXEC SP_CrearPadece 2, 2
EXEC SP_CrearPadece 3, 3
EXEC SP_CrearPadece 4, 4

--------------------------TIPO INTERVENCION--------------------------
EXEC SP_CrearTipoIntervencion 'Cirugia'
EXEC SP_CrearTipoIntervencion 'Dieta'
EXEC SP_CrearTipoIntervencion 'Ejercicio'
EXEC SP_CrearTipoIntervencion 'Medicamento'
EXEC SP_CrearTipoIntervencion 'Salud'

------------------------------INTERVENCION-----------------------------
EXEC SP_CrearIntervencion 'Tomar dos pastillas cada 6 horas', 1, 1
EXEC SP_CrearIntervencion 'Comer frutas y tomar 2 litos de agua', 2, 2
EXEC SP_CrearIntervencion 'Caminar 20 minutos por dia', 3, 3
EXEC SP_CrearIntervencion 'Evitar comida chatarra', 4, 4

--------------------------------PACIENTE UNIDAD-------------------------
EXEC SP_CrearPacienteUnidad 1, 1
EXEC SP_CrearPacienteUnidad 2, 2
EXEC SP_CrearPacienteUnidad 3, 3
EXEC SP_CrearPacienteUnidad 4, 4
