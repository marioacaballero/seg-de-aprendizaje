
Unit tests_menu;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, test_display, test_submenus, arbol_unit, usa_arbol;

Const 
  nOp = 4;
  opciones: array[1..nOp] Of string = ('Cargar evaluacion', 'Modificacion',
                                       'Consulta',
                                       'Salir');

Procedure menuTest(Var rootLeg: T_PUNT);

Implementation

Procedure menuTest(Var rootLeg: T_PUNT);

Var 
  w: string;
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleTestText();
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
            1: createSubMenu(rootLeg);
            2: updateSubMenu(rootLeg);
            3: readSubMenu(rootLeg);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
End;

End.
