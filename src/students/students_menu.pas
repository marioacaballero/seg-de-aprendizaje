
Unit students_menu;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, CRUD_stud, validator, arbol_unit, usa_arbol;

Const 
  nOp1 = 2;
  nOp2 = 3;
  opciones1: array[1..nOp1] Of string = ('Dar de alta', 'Ingresar Otro');
  opciones2: array[1..nOp2] Of string = ('Modificar', 'Dar de baja',
                                         'Ingresar Otro');

Procedure menuStudents(Var rootLeg, rootName: T_PUNT);

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

Procedure findSubMenu(leg: String; Var rootLeg:
                      T_PUNT);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleText();
    textcolor(green);
    CONSULTA(rootLeg, leg, '');
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
          clrscr;
          Case here Of 
            1: updateStudent(leg);
            2: deleteStudent();
            Else
              Begin
                key := chr(27);
              End;
          End;
        End;
  Until key = chr(27);

End;

Procedure notFindSubMenu(leg: String; Var rootLeg, rootName:
                         T_PUNT);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleText();
    textcolor(green);
    CONSULTA(rootLeg, leg, 'No se encontro el legajo: ' + leg);
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
              Case here Of 
                1: createStudent(leg, key, rootLeg, rootName);
                Else
                  Begin
                    key := chr(27);
                  End;
              End;
              readkey;
            End;
      End;
  Until key = chr(27);

End;

Procedure menuStudents(Var rootLeg, rootName: T_PUNT);

Var 
  w, leg: string;
  find: boolean;
  key: Char;
Begin
  Repeat
    clrscr;
    Begin
      titleText();
      textcolor(lightgray);
      WriteLn('Presione ENTER para ingresar el legajo o ESC para volver');
      key := ReadKey;
      If key <> chr(27) Then
        Begin
          WriteLn('');
          Write('Numero de legajo: ');
          textcolor(green);
          ReadLn(leg);
          If (legValidator(leg)) Then
            Begin
              BUSCAR(rootLeg,leg, find);
              If (find) Then
                findSubMenu(leg, rootLeg)
              Else
                notFindSubMenu(leg, rootLeg, rootName);
            End
          Else
            Begin
              textcolor(red);
              WriteLn;
              WriteLn('Debe contener 8 digitos');
              textcolor(green);
              readkey;
            End;
        End;
    End;
  Until key = chr(27);
  key := chr(0);
  clrscr();
  textcolor(green);
  WriteLn('Volviendo al Menu Principal!');
  writeln('');
  WriteLn('<------------------------------------------');
End;
End.
