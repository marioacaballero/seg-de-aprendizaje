
Unit CRUDStudents;

Interface

{$unitPath ../utils}
{$unitPath ./}

Uses crt, sysutils, initStudents, usaArbol, arbolUnit;

Procedure createStudent(leg: String; Var key: Char);
Procedure readStudent();
Procedure updateStudent(leg: String);
Procedure deleteStudent();

Implementation


Procedure initDiscapacidades(Var student: T_Alumno);

Var 
  i: Byte;
Begin
  For i:= 1 To 5 Do
    student.discapacidades[i] := False;
End;

Procedure chargeStudent(Var student: T_Alumno; leg: String);
Begin
  textcolor(white);
  WriteLn('Complete los datos solicitados');
  WriteLn('');
  textcolor(green);
  WriteLn('Legajo: ', leg);
  student.numLegajo := leg;
  write('Nombres: ');
  readln(student.nombre);
  write('Apellidos: ');
  readln(student.apellido);
  write('Fecha de nacimiento (DDMMAAAA): ');
  readln(student.fechaNacimiento);
  student.estado := True;
  initDiscapacidades(student);
End;

// creo el estudiante y lo agrego al arbol de estudiantes
Procedure createStudent(leg: String; Var key: Char; Var RAIZ: T_PUNT);

Var 
  f: T_File;
  student: T_Alumno;
  stud_tree: T_DATO_ARBOL;
Begin
  Assign(f, path);
  Reset(f);
  chargeStudent(student, leg);
  Seek(f, FileSize(f));
  stud_tree.clave := student.numLegajo;
  stud_tree.pos_arch := FileSize(f);
  Write(f, student);
  CARGAR_ARBOL(RAIZ, stud_tree);
  Close(f);
  key := chr(27);
  WriteLn('');
  textcolor(white);
  WriteLn('Alumno dado de alta');
End;

Function showState(state: Boolean): string;
Begin
  If state Then
    Write('Activo')
  Else
    Write('Inactivo');
End;

Procedure readStudent();

Var 
  f: T_File;
  student: T_Alumno;
  legajo: string;
  flag: Boolean;
Begin
  Assign(f, path);
  Reset(f);
  write('Legajo: ');
  readln(legajo);
  flag := False;
  While (Not Eof(f)) And (Not flag) Do
    Begin
      Read(f, student);
      If (student.numLegajo = legajo) Then
        Begin
          flag := True;
          WriteLn('Legajo: ', student.numLegajo);
          WriteLn('Nombres: ', student.nombre);
          WriteLn('Apellidos: ', student.apellido);
          WriteLn('Fecha de nacimiento: ', showBirthday(student.fechaNacimiento)
          );
          WriteLn('Estado: ', showState(student.estado));
        End;
    End;
  If Not flag Then
    WriteLn('No se encontro el legajo');
  Close(f);
End;

Procedure updateStudent(leg: String);

Var 
  f: T_File;
  student: T_Alumno;
  // legajo: string;
  flag: Boolean;
  pos: integer;
Begin
  Assign(f, path);
  Reset(f);
  write('Legajo: ', leg);
  // readln(legajo);
  flag := False;
  While (Not Eof(f)) And (Not flag) Do
    Begin
      Read(f, student);
      If (student.numLegajo = leg) Then
        Begin
          flag := True;
          pos := FilePos(f) - 1;
          // le saco 1 porque ya se movio al siguiente
        End;
    End;
  If Not flag Then
    WriteLn('No se encontro el legajo')
  Else
    Begin
      Seek(f, pos);
      chargeStudent(student, leg);
      Write(f, student);
    End;
  WriteLn('Se actualizo el alumno');
  Close(f);

End;

Procedure deleteStudent();

Var 
  f: T_File;
  student: T_Alumno;
  legajo: string;
  flag: Boolean;
Begin
  Assign(f, path);
  Reset(f);
  write('Legajo: ');
  readln(legajo);
  flag := False;
  While (Not Eof(f)) And (Not flag) Do
    Begin
      Read(f, student);
      If (student.numLegajo = legajo) Then
        Begin
          flag := True;
          student.estado := False;
          Write(f, student);
          writeln('Se elimino el alumno');
        End;
    End;
  If Not flag Then
    WriteLn('No se encontro el legajo');
  Close(f);
End;
End.
