
Unit list_menu;

Interface

{$unitPath ../utils/}

Uses crt, usa_arbol, arbol_unit;

Const 
  nOp = 4;
  opciones: array[1..nOp] Of string = ('Alumnos A-Z',
                                       'Evaluaciones de un alumno',
                                       'Alumnos por dificultad', 'Salir');
Procedure menuLits(root: T_PUNT);

Implementation
Procedure menuLits(root: T_PUNT);

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
    WriteLn('|          LISTADOS            |');
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
            1: LISTAR(root);
            2: WriteLn('Evaluaciones  de un alumno');
            3: WriteLn('Alumnos por dificultad');
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
