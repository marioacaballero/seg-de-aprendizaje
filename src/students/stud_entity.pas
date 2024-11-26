
Unit stud_entity;

Interface

Const 
  path_alum = './assets/students.dat';

Type 
  T_Discapacidad = array [1..5] Of boolean;
  T_Alumno = Record
    numLegajo: string[8];
    nombre: string[20];
    apellido: string[20];
    fechaNacimiento: string[8];
    estado: Boolean;
    discapacidades: T_Discapacidad;
  End;

  T_File_Alum = File Of T_Alumno;

Implementation

End.
