
Unit main_menu;

Interface

{$unitPath ../students/}
{$unitPath ../tests/}
{$unitPath ./}

Uses crt, students_menu, init_stud_file, tests_menu, list_menu, stadistics_menu,
usa_arbol, arbol_unit, init_test_file;

Const 
  nOp = 5;
  opciones: array[1..nOp] Of string = ('Alumno', 'Seguimiento', 'Listados',
                                       'Estadisticas', 'Salir');

Procedure menuMain();

Implementation
Procedure menuMain();

Var 
  w: string;
  i, here: integer;
  key: Char;
  rootLeg, rootName, rootTestLeg: T_PUNT;
Begin
  here := 1;
  // incializo el archivo de alumnos
  initStudentFile();
  // incializo el archivo de evaluaciones
  initTestFile();
  // incializo los arboles
  initTree(rootLeg);
  initTreeApYNom(rootName);
  initTreeTest(rootTestLeg);
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
            1: menuStudents(rootLeg, rootName);
            2: menuTest(rootLeg);
            3: menuLits(rootLeg, rootName);
            4: menuStadistics();
            Else
              Begin
                key := chr(5);
                textcolor(green);
                WriteLn('Muchas gracias por utilizarnos. Nos vemos!');
                writeln('');
                WriteLn('<------------------------------------------');
                readkey;
              End;
          End;
        End;
  Until key = chr(5);
End;
End.
