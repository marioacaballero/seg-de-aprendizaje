
Unit initStudents;

Interface

Const 
  path = './assets/students.dat';

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

  T_File = File Of T_Alumno;

Procedure initStudentFile();
Function showBirthday(birthday: String): string;
Function showStudent(leg, ap, nomb, fecha: String; d: T_Discapacidad): string;
Function showStudentTitle(leg, ap, nomb, fecha, dif: String): string;
Function line(tam: byte): string;
Function showDifficulties(): string;

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
    2: n := 20;
    3: showBirthday(text);
    4: n := 13;
  End;
  For i := 1 To n Do
    Begin
      If (i <= Length(text)) Then
        write(text[i])
      Else
        Write(' ');
    End;
End;

Function showStudentDiff(discap: T_Discapacidad): string;

Var i: byte;
Begin
  Write(' [');
  For i:= 1 To 5 Do
    Begin
      If (discap[i]) Then
        write(' ', 'S')
      Else
        write(' ', 'N');
    End;
  Write(' ]');
End;

Function showStudent(leg, ap, nomb, fecha: String; d: T_Discapacidad): string;
Begin
  Write('| ');
  showAllChars(leg, 1);
  Write(' | ');
  showAllChars(ap, 2);
  Write(' | ');
  showAllChars(nomb, 2);
  Write(' | ');
  showAllChars(fecha, 3);
  Write(' |');
  showStudentDiff(d);
  Write(' |');
  Writeln;
End;

Function showStudentTitle(leg, ap, nomb, fecha, dif: String): string;
Begin
  Write('| ');
  showAllChars(leg, 1);
  Write(' | ');
  showAllChars(ap, 2);
  Write(' | ');
  showAllChars(nomb, 2);
  Write(' | ');
  showAllChars(fecha, 3);
  Write(' | ');
  showAllChars(dif, 4);
  Write(' |');
  Writeln;
End;

Function line(tam: byte): string;

Var 
  i: byte;
Begin
  For i:= 1 To tam Do
    Write('-');
  Writeln;
End;

Function difficulties(): string;
Begin
  WriteLn('| Dificultades:                                    |');
  WriteLn('|                                                  |');
  WriteLn('| 1. Problemas del habla y lenguaje                |');
  WriteLn('| 2. Dificultad para escribir                      |');
  WriteLn('| 3. Dificultades de aprendizaje visual            |');
  WriteLn('| 4. Memoria y otras dificultades del pensamiento  |');
  WriteLn('| 5. Destrezas sociales inadecuadas                |');
  WriteLn('|                                                  |');
  WriteLn('| En la columna estan representadas en orden       |');
  WriteLn('| [ 1 2 3 4 5 ]                                    |');
  WriteLn('|                                                  |');
  WriteLn('| Se representa con S si la tiene o N si no        |');
End;

Function showDifficulties(): string;
Begin
  line(52);
  difficulties();
  line(52);
  WriteLn;
End;

End.
