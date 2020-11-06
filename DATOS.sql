USE GUANA_HOSPI
GO
-----------------PERSONA--------------------------------
EXEC SP_Crear_Persona '1', 'Tatiana', 'Morales', 'Mendez', 19
EXEC SP_Crear_Persona '2', 'Luis', 'Rodriguez', 'Baltodano', 21
EXEC SP_Crear_Persona '3', 'Arlen', 'Vargas', 'Galvez', 19
EXEC SP_Crear_Persona '4', 'Ricardo', 'Morataya', 'Morataya', 20
EXEC SP_Crear_Persona '5', 'Enrique', 'Arias', 'Salgado', 20
EXEC SP_Crear_Persona '5022', 'Enrique', 'Arias', 'Salgado', 20

EXEC SP_Crear_Persona '6', 'Erick', 'Parra', 'Sequeira', 20
EXEC SP_Crear_Persona '7', 'Emilio', 'Galvez', 'Vargas', 45
EXEC SP_Crear_Persona '8', 'Daniel', 'Sequeira', 'Parra', 38
EXEC SP_Crear_Persona '9', 'Carlos', 'Salgado', 'Arias', 31
EXEC SP_Crear_Persona '10','Jafet', 'Morataya', 'Galvez', 51
EXEC SP_Crear_Persona '89','Jafet', 'Morataya', 'Galvez', 53

-----------------------Roles-------------------------------
EXEC SP_Crear_Role 'Administrador'
EXEC SP_Crear_Role 'Medico'

-----------------------Usuario Administrador-------------------------------
-- La contraseña es: 12345678

EXEC SP_Crear_User 'admin@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 1
    

-----------------------MEDICO-------------------------------
EXEC SP_Crear_Medico 1234, 1, 1
EXEC SP_Crear_Medico 2323, 2, 1
EXEC SP_Crear_Medico 5344, 3, 1
EXEC SP_Crear_Medico 6453, 4, 1
EXEC SP_Crear_Medico 4656, 5, 1
EXEC SP_Crear_Medico 4852, 89, 1
-----------------------Usuarios Medicos------------------------------

EXEC SP_Crear_User 'medico@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 1
EXEC SP_Crear_User 'medico2@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 2
EXEC SP_Crear_User 'medico3@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 3
EXEC SP_Crear_User 'medico4@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 4
EXEC SP_Crear_User 'medico5@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 5


----------------------ESPECIALIDAD--------------------------
EXEC SP_Crear_Especialidad 'Dermatologia'
EXEC SP_Crear_Especialidad 'Urologia'
EXEC SP_Crear_Especialidad 'Ginecologia'
EXEC SP_Crear_Especialidad 'Otorrinolaringologia'
EXEC SP_Crear_Especialidad 'Oftalmologia'
-----------------Medico Especialid--------------------------
EXEC SP_Crear_Medico_Especialidad 1, 1
EXEC SP_Crear_Medico_Especialidad 2, 4
EXEC SP_Crear_Medico_Especialidad 2, 3
EXEC SP_Crear_Medico_Especialidad 2, 2
EXEC SP_Crear_Medico_Especialidad 3, 3
EXEC SP_Crear_Medico_Especialidad 4, 4
EXEC SP_Crear_Medico_Especialidad 5, 5

-----------------------UNIDAD-------------------------------
EXEC SP_Crear_Unidad 'Sala A1', 1, 1, 1
EXEC SP_Crear_Unidad 'Sala B1', 1, 2, 1
EXEC SP_Crear_Unidad 'Sala C1', 1, 3, 1
EXEC SP_Crear_Unidad 'Sala D1', 1, 4, 1
EXEC SP_Crear_Unidad 'Sala A2', 2, 5, 1
EXEC SP_Crear_Unidad 'Sala B2', 2
EXEC SP_Crear_Unidad 'Sala C2', 2
EXEC SP_Crear_Unidad 'Sala D2', 2

-----------------------PACIENTE----------------------------------
EXEC SP_Crear_Paciente 2332, '2020/09/5', '6', 1
EXEC SP_Crear_Paciente 3839, '2020/08/20', '7', 1
EXEC SP_Crear_Paciente 5022, '2020/08/20', '5022', 1
EXEC SP_Crear_Paciente 4039, '2020/07/3', '8', 1
EXEC SP_Crear_Paciente 9284, '2020/06/16', '9', 1

-----------------------CONSULTA-----------------------------------
EXEC SP_Crear_Consulta 'Se presentó con dolor', 1, 1
EXEC SP_Crear_Consulta 'Pierna rota', 2, 2
EXEC SP_Crear_Consulta 'Brazo roto', 3, 3
EXEC SP_Crear_Consulta 'Dolor abdominal', 4, 4
EXEC SP_Crear_Consulta 'Sangrado anal', 1, 4
EXEC SP_Crear_Consulta 'Dolor de cabeza', 1, 4
-----------------------PRESENTE----------------------------------
EXEC SP_Crear_Presenta 1, 1, 'Tiene que consumir mas agua'
EXEC SP_Crear_Presenta 2, 2, 'Tiene que caminar'
EXEC SP_Crear_Presenta 3, 3, 'Tiene que dormir mas'
EXEC SP_Crear_Presenta 4, 4, 'Tiene que consumir drogas'

----------------------ENFERMEDAD---------------------------------
EXEC SP_Crear_Enfermedad 'Cancer', 2
EXEC SP_Crear_Enfermedad 'Dengue', 2
EXEC SP_Crear_Enfermedad 'Cockbig', 2
EXEC SP_Crear_Enfermedad 'Asma', 2
EXEC SP_Crear_Enfermedad 'Ebola', 2
EXEC SP_Crear_Enfermedad 'Diabetes', 2
EXEC SP_Crear_Enfermedad 'Sida', 2
EXEC SP_Crear_Enfermedad 'Leucenia', 2

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