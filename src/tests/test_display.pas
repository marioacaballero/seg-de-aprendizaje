
Unit test_display;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, general_displays, test_entity;

Function titleTestText(): string;
Function showTest(leg, fecha: String; d: T_Seguimiento; obs: String): string;
Function showTestTitle(): string;

Implementation

Function titleTestText(): string;
Begin
  textcolor(white);
  WriteLn('--------------------------------');
  WriteLn('|                              |');
  WriteLn('|         SEGUIMIENTO          |');
  WriteLn('|                              |');
  WriteLn('--------------------------------');
  writeln('');
End;

Function showTestDiff(seg: T_Seguimiento): string;

Var i: byte;
Begin
  Write('[');
  For i:= 1 To 5 Do
    If (seg[i] >= 0) Then
      write(' ', seg[i])
    Else
      write(' ', '-');
  Write(' ]');
End;

Function showTest(leg, fecha: String; d: T_Seguimiento; obs: String): string;
Begin
  Write('| ');
  showAllChars(leg, 1);
  Write(' | ');
  showAllChars(fecha, 3);
  Write(' | ');
  showTestDiff(d);
  Write(' | ');
  showAllChars(obs, 6);
  Write(' |');
  Writeln;
End;

Function showTestTitle(): string;
Begin
  Write('| ');
  showAllChars('Legajo', 1);
  Write(' | ');
  showAllChars('Fech Eval.', 3);
  Write(' | ');
  showAllChars('Seguimiento ', 4);
  Write(' | ');
  showAllChars('Observaciones', 6);
  Write(' | ');
  Writeln;
End;

End.
