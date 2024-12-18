
Unit stadistics_menu;

Interface

{$unitPath ./}

Uses crt, stadistics_utils;

Const 
  nOp = 4;
  opciones: array[1..nOp] Of string = ('Evaluaciones por discapacidad',
                                       'Mayor grado de dificultad'
                                       , 'Otro', 'Salir');
Procedure menuStadistics();

Implementation
Procedure menuStadistics();

Var 
  w: string;
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    textcolor(white);
    WriteLn('--------------------------------');
    WriteLn('|                              |');
    WriteLn('|         ESTADISTICAS         |');
    WriteLn('|                              |');
    WriteLn('--------------------------------');
    writeln('');
    textcolor(lightgray);
    WriteLn('Elija una opcion:');
    writeln('');

    For i:= 1 To nOp Do
      Begin
        If i = here Then
          textcolor(white)
        Else
          textcolor(green);
        WriteLn(i, '. ', opciones[i]);
      End;
    key := ReadKey;

    If key = chr(0) Then
      Begin
        key := ReadKey;
        Case key Of 
          #72:
               Begin
                 If (here > 1) Then
                   here := here - 1
                 Else
                   here := nOp;
               End;
          #80:
               Begin
                 If (here < nOp) Then
                   here := here + 1
                 Else
                   here := 1;
               End;
        End;
      End
    Else
      If (key = chr(13)) Then
        Begin
          Case here Of 
            1: difStadistics();
            2: highDifStadistics();
            3: WriteLn('Otro');
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
End;

End.
