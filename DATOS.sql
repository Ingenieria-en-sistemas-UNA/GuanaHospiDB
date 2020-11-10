USE GUANA_HOSPI
GO
-----------------PERSONA--------------------------------
--dni_persona / nombre / apellido1 / apellido2 / edad

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
--nombre_role

EXEC SP_Crear_Role 'Administrador'
EXEC SP_Crear_Role 'Medico'

-----------------------Usuario Administrador-------------------------------
-- La contraseña es: 12345678
--email / password / id_medico / id_role 

EXEC SP_Crear_User 'admin@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 1, null, 1
    

-----------------------MEDICO-------------------------------
--codigo_medico / dni_persona / estado(BIT 1 o 0) 

EXEC SP_Crear_Medico 1234, 1, 1
EXEC SP_Crear_Medico 2323, 2, 1
EXEC SP_Crear_Medico 5344, 3, 1
EXEC SP_Crear_Medico 6453, 4, 1
EXEC SP_Crear_Medico 4656, 5, 1
EXEC SP_Crear_Medico 4852, 89, 1

-----------------------Usuarios Medicos------------------------------

EXEC SP_Crear_User 'medico@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 1, 1
EXEC SP_Crear_User 'medico2@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 2, 1
EXEC SP_Crear_User 'medico3@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 3, 1
EXEC SP_Crear_User 'medico4@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 4, 1
EXEC SP_Crear_User 'medico5@gmail.com', '$2y$10$zt96rq87c6gXdbGZXryRm.IiLkpSzcx.FOZ1UxsPWZCHMwj02uWqW', 2, 5, 1


----------------------ESPECIALIDAD--------------------------
--nombre_especialidad / id_usuario 

EXEC SP_Crear_Especialidad 'Dermatologia', 1
EXEC SP_Crear_Especialidad 'Urologia', 1
EXEC SP_Crear_Especialidad 'Ginecologia', 1
EXEC SP_Crear_Especialidad 'Otorrinolaringologia', 1
EXEC SP_Crear_Especialidad 'Oftalmologia', 1

-----------------Medico Especialid--------------------------
--id_medico / id_especialidad

EXEC SP_Crear_Medico_Especialidad 1, 1
EXEC SP_Crear_Medico_Especialidad 2, 4
EXEC SP_Crear_Medico_Especialidad 2, 3
EXEC SP_Crear_Medico_Especialidad 2, 2
EXEC SP_Crear_Medico_Especialidad 3, 3
EXEC SP_Crear_Medico_Especialidad 4, 4
EXEC SP_Crear_Medico_Especialidad 5, 5

-----------------------UNIDAD-------------------------------
--nombre_unidad / numero_planta / id_medico / id_usuario

EXEC SP_Crear_Unidad 'Sala A1', 1, 1, 1
EXEC SP_Crear_Unidad 'Sala B1', 1, 2, 1
EXEC SP_Crear_Unidad 'Sala C1', 1, 3, 1
EXEC SP_Crear_Unidad 'Sala D1', 1, 4, 1
EXEC SP_Crear_Unidad 'Sala E1', 1, 4, 1
EXEC SP_Crear_Unidad 'Sala A2', 2, 5, 1
EXEC SP_Crear_Unidad 'Sala B2', 2, null, 1
EXEC SP_Crear_Unidad 'Sala C2', 2, null, 1
EXEC SP_Crear_Unidad 'Sala D2', 2, null, 1
EXEC SP_Crear_Unidad 'Sala E2', 2, null, 1

-----------------------PACIENTE----------------------------------
--numero_seguro_social / fecha_ingreso / dni_persona / id_usuario

EXEC SP_Crear_Paciente 2332, '2020-11-08 23:22:46', '6', 1
EXEC SP_Crear_Paciente 3839, '2020-11-08 23:22:46', '7', 1
EXEC SP_Crear_Paciente 5022, '2020-11-08 23:22:46', '10', 1
EXEC SP_Crear_Paciente 4039, '2020-11-08 23:22:46', '8', 1
EXEC SP_Crear_Paciente 9284, '2020-11-08 23:22:46' ,'9', 1
EXEC SP_Crear_Paciente 7451, '2020-11-08 23:22:46' ,'89', 1

-----------------------CONSULTA-----------------------------------
--descripcion / id_paciente / id_unidad / id_medico /estado_consulta/ id_usuario

EXEC SP_Crear_Consulta 'Se presentó con dolor', 1, 1, 1,1
EXEC SP_Crear_Consulta 'Se presentó malestar estomacal', 1, 2, 2,1
EXEC SP_Crear_Consulta 'Fiebre', 1, 2, 2,1

EXEC SP_Crear_Consulta 'Pierna rota', 2, 2, 1, 1
EXEC SP_Crear_Consulta 'Brazo roto', 2, 2, 2, 1
EXEC SP_Crear_Consulta 'Sudoración', 2, 3, 3, 1

EXEC SP_Crear_Consulta 'Brazo roto', 3, 3, 1, 2
EXEC SP_Crear_Consulta 'Dolor abdominal', 4, 4, 2, 2
EXEC SP_Crear_Consulta 'Sangrado anal', 1, 4, 2, 2
EXEC SP_Crear_Consulta 'Dolor de cabeza', 1, 4, 2, 3

SELECT m.id_medico, m.dni_persona, u.id_unidad FROM Medico m
INNER JOIN Unidad u ON m.id_medico = u.id_medico 
----------------------ENFERMEDAD---------------------------------
--nombre_enfermedad / id_usuario / apellido1 / apellido2 / edad

EXEC SP_Crear_Enfermedad 'Cancer', 2
EXEC SP_Crear_Enfermedad 'Dengue', 2
EXEC SP_Crear_Enfermedad 'Cockbig', 2
EXEC SP_Crear_Enfermedad 'Asma', 2
EXEC SP_Crear_Enfermedad 'Ebola', 2
EXEC SP_Crear_Enfermedad 'Diabetes', 2
EXEC SP_Crear_Enfermedad 'Sida', 2
EXEC SP_Crear_Enfermedad 'Leucenia', 2

------------------------PADECE--------------------------------------
--id_paciente / id_enfermedad / id_consulta

EXEC SP_Crear_Padece 1, 1, 1
EXEC SP_Crear_Padece 2, 2, 2
EXEC SP_Crear_Padece 3, 3, 1
EXEC SP_Crear_Padece 4, 4, 3
EXEC SP_Crear_Padece 1, 1, 2
EXEC SP_Crear_Padece 2, 2, 1
EXEC SP_Crear_Padece 5, 1, 1
EXEC SP_Crear_Padece 6, 1, 1
EXEC SP_Crear_Padece 1, 4, 1

--------------------------TIPO INTERVENCION--------------------------
--nombre_tipo_intervencion / id_usuario 

EXEC SP_Crear_Tipo_Intervencion 'Cirugia', 1
EXEC SP_Crear_Tipo_Intervencion 'Dieta', 1
EXEC SP_Crear_Tipo_Intervencion 'Ejercicio', 1
EXEC SP_Crear_Tipo_Intervencion 'Medicamento', 1
EXEC SP_Crear_Tipo_Intervencion 'Salud', 1

------------------------------INTERVENCION-----------------------------
--tratamiento / id_tipo_intervencion / id_consulta 

EXEC SP_Crear_Intervencion 'Tomar dos pastillas cada 6 horas', 1, 1
EXEC SP_Crear_Intervencion 'Comer frutas y tomar 2 litos de agua', 2, 2
EXEC SP_Crear_Intervencion 'Caminar 20 minutos por dia', 3, 3
EXEC SP_Crear_Intervencion 'Hacer ejercicio', 4, 4
EXEC SP_Crear_Intervencion 'Tomar pastillas cada dos horas', 1, 7
EXEC SP_Crear_Intervencion 'Comer sano', 1, 6

	