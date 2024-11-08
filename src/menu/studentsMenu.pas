
Unit studentsMenu;

Interface

{$unitPath ../students/}

Uses crt, initStudents, CRUDStudents, searchUnit;

Const 
  nOp1 = 2;
  nOp2 = 3;
  opciones1: array[1..nOp1] Of string = ('Dar de alta', 'Salir');
  opciones2: array[1..nOp2] Of string = ('Modificar', 'Dar de baja', 'Salir');

Procedure menuStudents();






{Al ingresar al menu debe solicitar el numero de legajo, en caso de que exista muestra los datos y da las opciones de modificarlos o eliminarlos (sin modificar el numero de legajo), en el caso de que no se encuentre le solicita los demas campos para darlo de alta si es que la persona lo desea.}

Implementation
Procedure menuStudents();

Var 
  w, leg: string;
  i, here: integer;
  key: Char;
  find: boolean;
Begin
  here := 1;
  Repeat
    clrscr;
    textcolor(white);
    WriteLn('--------------------------------');
    WriteLn('|                              |');
    WriteLn('|           ALUMNOS            |');
    WriteLn('|                              |');
    WriteLn('--------------------------------');
    writeln('');
    textcolor(lightgray);
    Write('Ingrese numero de legajo: ');
    textcolor(green);
    ReadLn(leg);
    searchStudent(leg, find);

    If (find) Then
      Begin
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
              initStudentFile();
              Case here Of 
                // 1: createStudent();
                1: updateStudent();
                2: deleteStudent();
                // 4: readStudent();
                Else
                  Begin
                    key := chr(27);
                    textcolor(green);
                    WriteLn('Volviendo al Menu Principal!');
                    writeln('');
                    WriteLn('<------------------------------------------');
                  End;
              End;
              readkey;
            End;
      End
    Else
      Begin
        WriteLn('probando no encontrado');
      End;
  Until key = chr(27);
  // clrscr();
  // textcolor(green);
  // WriteLn('Volviendo al Menu Principal!');
  // writeln('');
  // WriteLn('<------------------------------------------');
End;
End.
