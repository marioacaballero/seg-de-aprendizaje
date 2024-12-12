
Unit test_submenus;

Interface

{$unitPath ../utils/}
{$unitPath ./students/}
{$unitPath ./}

Uses crt, sysutils, validator, usa_arbol, arbol_unit, CRUD_stud,
general_displays, CRUD_test, test_display, test_utils, test_entity;

Const 
  nOp1 = 1;
  nOp2 = 2;
  nOp3 = 7;
  opciones1: array[1..nOp1] Of string = ('Ingresar Otro');
  opciones2: array[1..nOp2] Of string = ('Cargar Datos', 'Ingresar Otro');
  opciones3: array[1..nOp3] Of string = (dif1,dif2,dif3,dif4,dif5,'Observacion',
                                         'Volver');

Procedure createSubMenu(Var rootLeg: T_PUNT);
Procedure readSubMenu(Var rootLeg: T_PUNT);
Procedure updateSubMenu(Var rootLeg: T_PUNT);

Implementation

Procedure findMenu(leg:String; Var rootLeg:T_PUNT);

Var 
  i, here: integer;
  key: Char;
  x: T_DATO_ARBOL;
  enc: Boolean;
Begin
  here := 1;
  Repeat
    clrscr;
    titleTestText();
    textcolor(green);
    showDifficulties();
    readStudent(leg, rootLeg);
    PREORDEN(rootLeg, leg, enc, x);
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
            1: createTest(leg, x.pos_arch);
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
  leg: string;
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

Procedure readSubMenu(Var rootLeg: T_PUNT);

Var 
  leg, date: string;
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
                   Begin
                     readTest(leg, date);
                     readkey;
                   End
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

Procedure selectDif(leg: String);

Var 
  i, here: integer;
  key: Char;
  haveDif, date: string;
  pos: integer;
  test: T_Test;
Begin
  here := 1;
  readTest(leg, date);
  findSeg(leg, date, pos);
  If pos >= 0 Then
    Begin
      testMemo(test, pos);
      Repeat
        clrscr;
        titleTestText();
        textcolor(green);
        writeln('');
        For i:= 1 To nOp3 Do
          Begin
            If i = here Then
              textcolor(white)
            Else
              textcolor(green);
            If (i < 6) Then
              Begin
                If (test.seguimiento[i] >= 0) Then
                  Begin
                    haveDif := IntToStr(test.seguimiento[i]);
                    WriteLn(opciones3[i], ': ', haveDif);
                  End;
                // Else
                //   haveDif := 'No corresponde';
              End
            Else
              WriteLn(opciones3[i]);
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
                       here := nOp3;
                   End;
              #80:
                   Begin
                     If (here < nOp3) Then
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
                chargeOneDif(here, test, pos)
              Else If (here = 6) Then
                     chargeObs(test, pos)
              Else
                key := chr(27);
            End;
      Until key = chr(27);
      clrscr;
    End;
End;

Procedure updateSubMenu(Var rootLeg: T_PUNT);

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
                   Begin
                     selectDif(leg);
                   End
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
