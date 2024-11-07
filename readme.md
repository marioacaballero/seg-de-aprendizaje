# Proyecto 1: Seguimiento de aprendizaje

## Objetivo

Desarrollar un subsistema para gestionar y consultar información sobre alumnos con
problemas de aprendizaje.

## Descripción del Proyecto

Se necesita crear un sistema que permita almacenar, consultar y organizar información sobre
alumnos con problemas de aprendizaje, y las dificultades asociadas.

Las dificultades a considerar son las siguientes:

- dificultad 1: Problemas del habla y lenguaje
- dificultad 2: Dificultad para escribir
- dificultad 3: Dificultades de aprendizaje visual
- dificultad 4: Memoria y otras dificultades del pensamiento
- dificultad 5: Destrezas sociales inadecuadas

El Archivo de Alumnos debe contener

- Número Legajo
- Apellido y nombres
- Fecha de Nacimiento
- Estado (baja lógica)
- Discapacidades: array [1..5] of boolean

El Archivo de Evaluaciones debe contener

- Numero Legajo
- Fecha de Evaluación (solo una por dia por estudiante)
- Valoración de Seguimiento por Dificultad : array [1..5] of int [0..4]
- Observación (campo de texto)

## Solución esperada

La solución esperada debe contar con:

- ABMC de alumnos
- AMC de Evaluaciones
- Listados
  - ordenado por Apellido y Nombres de alumnos
  - evaluaciones de un determinado alumno
  - alumnos de una determinada discapacidad
- Estadísticas:

  - Distribución (cantidad) de evaluaciones por discapacidad entre dos fechas
  - Discapacidades que presentan mayor grado de dificultad entre dos fechas
  - Generar una opción diferente a las anteriores (libre elección)

- Distribución esperada del menú
  ![menu-distribution](/public/images/menu-distribution.png)

## Notas

- El trabajo se deberá implementar con archivos random.
- El archivo de Alumnos se mantendrá ordenado mediante árboles binarios de búsqueda (uno
  por Número de Legajo y uno por Apellido y Nombres, con clave y pos_relativa_maestro) y el
  archivo de evaluaciones, por fecha
- Debe estar modularizado en Units.
- Se puede agregar cualquier aporte que considere conveniente, justificando.
- Se presupone que el usuario será personal del área de educación, por lo que la carga y
  visualización de los datos debe ser práctica y amigable.
