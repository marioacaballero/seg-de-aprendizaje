
Unit searchUnit;

Interface
{$unitPath ./}

Uses initStudents;

Procedure searchStudent(leg: String; Var find: boolean);

Implementation

Procedure searchStudent(leg: String; Var find: boolean);

Var 
  f: T_File;
  student: T_Alumno;
Begin
  Assign(f, path);
  Reset(f);
  find := false;
  While (Not Eof(f)) And (Not find) Do
    Begin
      read(f, student);
      If student.numLegajo = leg Then
        Begin
          find := true;
          showStudent(student.numLegajo, student.apellido, student.nombre,
                      student.fechaNacimiento);
        End;
    End;
  If Not find Then
    WriteLn('No se encontro el legajo ', leg);
End;

End.
