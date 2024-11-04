
Unit initStudents;

Interface

Const 
  path = './assets/students.dat';

Type 
  T_Discapacidad = array [1..5] Of boolean;
  T_Alumno = Record
    numLegajo: string[8];
    nombre: string[30];
    apellido: string[30];
    fechaNacimiento: string[8];
    estado: Boolean;
    discapacidades: T_Discapacidad;
  End;

  T_File = File Of T_Alumno;

Procedure initStudentFile();
Procedure showAllStudents();
Function showBirthday(birthday: String): string;

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

Function showBirthday(birthday: String): string;
Begin
  If (birthday[1] >= '0') And (birthday[1] <= '9') Then
    Begin
      Write(birthday[1] + birthday[2]);
      Write('/');
      Write(birthday[3] + birthday[4]);
      Write('/');
      Write(birthday[5] + birthday[6] + birthday[7] + birthday[8]);
    End
  Else
    Write(birthday);
End;

Function showAllChars(text: String; lim: byte): string;

Var 
  i, n: byte;

Begin
  Case lim Of 
    1: n := 8;
    2: n := 30;
    3: showBirthday(text);
  End;
  For i := 1 To n Do
    Begin
      If (i <= Length(text)) Then
        write(text[i])
      Else
        Write(' ');
    End;
End;

Function showStudent(leg, apell, nomb, fecha: String): string;
Begin
  Writeln;
  Write('| ');
  showAllChars(leg, 1);
  Write(' | ');
  showAllChars(apell, 2);
  Write(' | ');
  showAllChars(nomb, 2);
  Write(' | ');
  showAllChars(fecha, 3);
  Write(' |');
End;

Function line(): string;

Var 
  i: byte;
Begin
  Writeln;
  For i:= 1 To 91 Do
    Write('-');
End;

Procedure showAllStudents();

Var 
  f: T_File;
  student: T_Alumno;
Begin
  Assign(f, path);
  Reset(f);
  line();
  showStudent('Legajo', 'Apellido', 'Nombre', 'Fec Nacim.');
  line();
  While Not Eof(f) Do
    Begin
      Read(f, student);
      showStudent(student.numLegajo, student.apellido, student.nombre, student.
                  fechaNacimiento);
    End;
  Close(f);
End;
End.
