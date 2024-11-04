
Unit CRUDStudents;

Interface

Uses sysutils;

Const 
  path = './assets/students.dat';

Type 
  T_Discapacidad = array [1..5] Of boolean;
  T_Alumno = Record
    numLegajo: string[8];
    nombre: string[50];
    apellido: string[50];
    fechaNacimiento: string[8];
    estado: Boolean;
    discapacidades: T_Discapacidad;
  End;

  T_File = File Of T_Alumno;

Procedure initStudentFile();
Procedure createStudent();
Procedure readStudent();
Procedure updateStudent();
Procedure deleteStudent();

Implementation
Procedure initStudentFile();

Var 
  f: T_File;
Begin
  Assign(f, path);
  //Para chequear se puede utilizar las directivas al compilador:
 {$I-}
  //orden al compilador que deshabilite el control de IO
  Reset(f);
{$I+}
  //orden al compilador que habilite el control de IO
  If IOResult<>0 Then Rewrite(f); {si no existe lo crea}
End;

Procedure initDiscapacidades(Var student: T_Alumno);

Var 
  i: Byte;
Begin
  For i:= 1 To 5 Do
    student.discapacidades[i] := False;
End;

Procedure chargeStudent(Var student: T_Alumno);
Begin
  write('Legajo: ');
  readln(student.numLegajo);
  write('Nombres: ');
  readln(student.nombre);
  write('Apellidos: ');
  readln(student.apellido);
  write('Fecha de nacimiento (DDMMAAAA): ');
  readln(student.fechaNacimiento);
  student.estado := True;
  initDiscapacidades(student);
End;

Procedure createStudent();

Var 
  f: T_File;
  student: T_Alumno;
Begin
  Assign(f, path);
  Reset(f);
  chargeStudent(student);
  Seek(f, FileSize(f));
  Write(f, student);
  Close(f);
End;

// Function showAllChars(text: String): string;

// Var 
//   i: byte;
// Begin
//   For i := 1 To Length(text) Do
//     Begin
//       write(text[i]);
//     End;
// End;

// Function showStudent(student: T_Alumno): string;
// Begin
//   showAllChars(student.numLegajo);
//   Write(' | ');
//   showAllChars(student.apellido);
//   Write(' | ');
//   showAllChars(student.nombre);
//   Write(' | ');
//   showAllChars(student.fechaNacimiento);
// End;

Function showBirthday(birthday: String): string;
Begin
  Write(birthday[1] + birthday[2]);
  Write('/');
  Write(birthday[3] + birthday[4]);
  Write('/');
  Write(birthday[5] + birthday[6] + birthday[7] + birthday[8]);
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

Procedure updateStudent();

Var 
  f: T_File;
  student: T_Alumno;
  legajo: string;
  flag: Boolean;
  pos: integer;
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
          pos := FilePos(f) - 1;
          // le saco 1 porque ya se movio al siguiente
        End;
    End;
  If Not flag Then
    WriteLn('No se encontro el legajo')
  Else
    Begin
      Seek(f, pos);
      chargeStudent(student);
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
