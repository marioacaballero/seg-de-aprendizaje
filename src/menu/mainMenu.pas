
Unit mainMenu;

Interface

{$unitPath ./}

Uses crt, studentsMenu;

Const 
  nOp = 5;
  opciones: array[1..nOp] Of string = ('Alumno', 'Seguimiento', 'Listados',
                                       'Estadisticas', 'Salir');

Procedure menu();

Implementation
Procedure menu();

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
    WriteLn('|  Bienvenidos al Seguimiento  |');
    WriteLn('|        de Aprendizaje        |');
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
            1: menuStudents();
            2: WriteLn('Seguimiento');
            3: WriteLn('Listados');
            4: WriteLn('Estadisticas');
            Else
              Begin
                key := chr(5);
                textcolor(green);
                WriteLn('Muchas gracias por utilizarnos. Nos vemos!');
                writeln('');
                WriteLn('<------------------------------------------');
              End;
          End;
          readkey;
        End;
  Until key = chr(5);

End;
End.
