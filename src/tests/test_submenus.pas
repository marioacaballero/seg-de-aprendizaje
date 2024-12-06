
Unit test_submenus;

Interface

{$unitPath ../utils/}
{$unitPath ./students/}
{$unitPath ./}

Uses crt, validator, usa_arbol, arbol_unit, CRUD_stud, general_displays,
CRUD_test, test_display;

Const 
  nOp1 = 1;
  nOp2 = 2;
  opciones1: array[1..nOp1] Of string = ('Ingresar Otro');
  opciones2: array[1..nOp2] Of string = ('Cargar Datos', 'Ingresar Otro');

Procedure createSubMenu(Var rootLeg: T_PUNT);

Implementation

Procedure findMenu(leg:String; Var rootLeg:T_PUNT);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleTestText();
    textcolor(green);
    showDifficulties();
    readStudent(leg, rootLeg);
    writeln('');
    writeln('');
    For i:= 1 To nOp2 Do
      Begin
        If i = here Then
          textcolor(white)
        Else
          textcolor(green);
        WriteLn(i, '. ', opciones2[i]);
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
                   here := nOp2;
               End;
          #80:
               Begin
                 If (here < nOp2) Then
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
            1: createTest(leg);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
  clrscr;
End;

Procedure notFindMenu();

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleTestText();
    textcolor(green);
    WriteLn('No se encontro');
    writeln('');
    If (key <> char(27)) Then
      Begin
        For i:= 1 To nOp1 Do
          Begin
            If i = here Then
              textcolor(white)
            Else
              textcolor(green);
            WriteLn(i, '. ', opciones1[i]);
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
                       here := nOp1;
                   End;
              #80:
                   Begin
                     If (here < nOp1) Then
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
              key := chr(27);
            End;
      End;
  Until key = chr(27);
  clrscr;
End;

Procedure createSubMenu(Var rootLeg: T_PUNT);

Var 
  w, leg: string;
  find: boolean;
  key: Char;
Begin
  leg := '';
  Repeat
    clrscr;
    titleTestText();
    textcolor(lightgray);
    WriteLn('Ingrese el legajo y presione ENTER');
    WriteLn('Debe contener solamente 8 numeros');
    WriteLn('');
    WriteLn('Presione ESC para volver');
    textcolor(green);
    WriteLn('');
    Write('Numero de legajo: ', leg);
    key := readkey;
    If (key <> chr(27)) Then
      If (key = chr(8)) Then
        Begin
          clrscr;
          // Para quitarle uno al string uso la funcion Delete
          Delete(leg, Length(leg), 1);
        End
    Else If (key = chr(13)) Then
           Begin
             If (legValidator(leg)) Then
               Begin
                 BUSCAR(rootLeg,leg, find);
                 If (find) Then
                   findMenu(leg, rootLeg)
                 Else
                   notFindMenu();
               End
             Else
               Begin
                 textcolor(red);
                 WriteLn;
                 WriteLn;
                 WriteLn('Debe contener solo 8 numeros');
                 textcolor(green);
                 readkey;
                 clrscr;
               End;
           End
    Else
      Begin
        clrscr;
        leg := leg + key;
      End;
  Until key = chr(27);
  clrscr();
End;

End.
