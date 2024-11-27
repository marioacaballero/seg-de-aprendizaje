
Unit stud_display;

Interface

Uses crt, stud_entity;

Function showBirthday(birthday: String): string;
Function showStudent(leg, ap, nomb, fecha: String; stat:boolean; d:
                     T_Discapacidad): string;
Function showStudentTitle(): string;
Function line(tam: byte): string;
Function showDifficulties(): string;
Procedure showUpdateMenu(Var resp: byte; alta: Boolean);

Implementation

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
    5: n := 6;
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

Function showStudState(state: Boolean): string;
Begin
  If state Then
    write(' Alta  ')
  Else
    Write(' Baja  ');
End;

Function showStudent(leg, ap, nomb, fecha: String; stat:boolean; d:
                     T_Discapacidad): string;
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
  showStudState(stat);
  Write(' |');
  showStudentDiff(d);
  Write(' |');
  Writeln;
End;

Function showStudentTitle(): string;
Begin
  Write('| ');
  showAllChars('Legajo', 1);
  Write(' | ');
  showAllChars('Apellido', 2);
  Write(' | ');
  showAllChars('Nombre', 2);
  Write(' | ');
  showAllChars('Fec Nacim.', 3);
  Write(' | ');
  showAllChars('Estado', 5);
  Write(' | ');
  showAllChars('Dificultades', 4);
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

Procedure showUpdateMenu(Var resp: byte; alta: Boolean);
Begin
  WriteLn;
  Textcolor(white);
  WriteLn('Que desea modificar, elija 0 para salir: ');
  WriteLn;
  Textcolor(green);
  writeln('1: Datos personales');
  writeln('2: Dificultades');
  If (Not alta) Then writeln('3: Dar de alta');
  Textcolor(white);
  WriteLn;
  write('Opcion: ');
  ReadLn(resp);
  WriteLn;
End;

End.
