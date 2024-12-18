
Unit list_menu;

Interface

{$unitPath ../utils/}
{$unitPath ../tests/}

Uses crt, usa_arbol, arbol_unit, CRUD_test, validator, general_displays,
CRUD_stud;

Const 
  nOp = 4;
  nOp2 = 6;
  opciones: array[1..nOp] Of string = ('Alumnos A-Z',
                                       'Evaluaciones de un alumno',
                                       'Alumnos por dificultad', 'Salir');
  opciones4: array[1..nOp2] Of string = (dif1,dif2,dif3,dif4,dif5,'Volver');

Procedure menuLits(Var rootLeg, rootName: T_PUNT);

Implementation

Procedure testByStudentMenu(Var rootLeg: T_PUNT);

Var 
  leg: string;
  find: boolean;
  key: Char;
Begin
  leg := '';
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
                   Begin
                     writeln('');
                     showDifficulties();
                     readStudent(leg, rootLeg);
                     writeln('');
                     allTestByStudent(leg);
                   End
                 Else
                   Begin
                     WriteLn('No se encontro el alumno');
                     readkey;
                   End;
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

Procedure selectDifMenu (Var rootName: T_PUNT);

Var 
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
    WriteLn('Elija una dificultad:');
    WriteLn;
    For i:= 1 To nOp2 Do
      Begin
        If i = here Then
          textcolor(white)
        Else
          textcolor(green);
        WriteLn(i, '. ', opciones4[i]);
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
          If (here < 6) Then
            LISTAR_DIF(rootName, here)
          Else
            key := chr(27);
        End;
  Until key = chr(27);
  clrscr;
End;

Procedure menuLits(Var rootLeg, rootName: T_PUNT);

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
            1: LISTAR(rootName);
            2: testByStudentMenu(rootLeg);
            3: selectDifMenu(rootName);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
End;
End.
