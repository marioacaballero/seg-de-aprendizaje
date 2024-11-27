
Unit stadistics_menu;

Interface

Uses crt;

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
          clrscr;
          Case here Of 
            1: WriteLn('Distribucion de evaluaciones por discapacidad');
            2: WriteLn('Discapacidad con mayor grado de dificultad');
            3: WriteLn('Otro');
            Else
              Begin
                key := chr(5);
                textcolor(green);
                WriteLn('Volviendo al Menu Principal!');
                writeln('');
                WriteLn('<------------------------------------------');
              End;
          End;
          readkey;
        End;
  Until key = chr(5);
End;

End.
