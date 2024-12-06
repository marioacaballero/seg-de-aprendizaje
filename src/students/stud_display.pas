
Unit stud_display;

Interface

{$unitPath ../utils/}

Uses crt, stud_entity, general_displays;

Function showStudent(leg, ap, nomb, fecha: String; stat:boolean; d:
                     T_Discapacidad): string;
Function showStudentTitle(): string;
Function titleText(): string;

Implementation

Function titleText(): string;
Begin
  textcolor(white);
  WriteLn('--------------------------------');
  WriteLn('|                              |');
  WriteLn('|           ALUMNOS            |');
  WriteLn('|                              |');
  WriteLn('--------------------------------');
  writeln('');
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

End.
