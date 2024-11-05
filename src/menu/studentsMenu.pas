
Unit studentsMenu;

Interface

{$unitPath ../students/}

Uses crt, initStudents, CRUDStudents;

Const 
  nOp = 5;
  opciones: array[1..nOp] Of string = ('Alta', 'Baja', 'Modificacion',
                                       'Consulta', 'Salir');
Procedure menuStudents();

{Al ingresar al menu debe solicitar el numero de legajo, en caso de que exista muestra los datos y da las opciones de modificarlos o eliminarlos (sin modificar el numero de legajo), en el caso de que no se encuentre le solicita los demas campos para darlo de alta si es que la persona lo desea.}

Implementation
Procedure menuStudents();

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
    WriteLn('|           ALUMNOS            |');
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
          initStudentFile();
          Case here Of 
            1: createStudent();
            2: deleteStudent();
            3: updateStudent();
            4: readStudent();
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
