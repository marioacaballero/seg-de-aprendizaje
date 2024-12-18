
Unit general_displays;

Interface

Const 
  dif1 = 'Problemas del habla y lenguaje';
  dif2 = 'Dificultad para escribir';
  dif3 = 'Dificultades de aprendizaje visual';
  dif4 = 'Memoria y otras dificultades del pensamiento';
  dif5 = 'Destrezas sociales inadecuadas';

Function showDate(date: String): string;
Function line(tam: byte): string;
Function showDifficulties(): string;
Function showAllChars(text: String; lim: byte): string;

Implementation
Function showDate(date: String): string;
Begin
  If (date[1] >= '0') And (date[1] <= '9') Then
    Begin
      Write(date[1] + date[2]);
      Write('/');
      Write(date[3] + date[4]);
      Write('/');
      Write(date[5] + date[6] + date[7] + date[8]);
    End
  Else
    Write(date);
End;

Function showAllChars(text: String; lim: byte): string;

Var 
  i, n: byte;

Begin
  Case lim Of 
    1: n := 8;
    2: n := 20;
    3: showDate(text);
    4: n := 13;
    5: n := 6;
    6: n := 60;
  End;
  For i := 1 To n Do
    Begin
      If (i <= Length(text)) Then
        write(text[i])
      Else
        Write(' ');
    End;
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
  WriteLn('| 1. ',dif1,'                |');
  WriteLn('| 2. ',dif2,'                      |');
  WriteLn('| 3. ',dif3,'            |');
  WriteLn('| 4. ',dif4,'  |');
  WriteLn('| 5. ',dif5,'                |');
  WriteLn('|                                                  |');
  WriteLn('| En la columna estan representadas en orden       |');
  WriteLn('| [ 1 2 3 4 5 ]                                    |');
  WriteLn('|                                                  |');
  WriteLn('| Se representa con S si la tiene o N si no        |');
  WriteLn('|                                                  |');
  WriteLn('| En el seguimiento se muestra con rango de 0 a 4  |');
  WriteLn('| Siendo 0 si no hay dificultad y 4 si le cuesta.  |');
End;

Function showDifficulties(): string;
Begin
  line(52);
  difficulties();
  line(52);
  WriteLn;
End;

End.
