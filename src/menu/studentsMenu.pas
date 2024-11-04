
Unit studentsMenu;

Interface

Uses crt;

Const 
  nOp = 5;
  opciones: array[1..nOp] Of string = ('Alta', 'Baja', 'Modificacion',
                                       'Consulta', 'Salir');
Procedure menuStudents();

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
          Case here Of 
            1: WriteLn('Alta');
            2: WriteLn('Baja');
            3: WriteLn('Modificacion');
            4: WriteLn('Consulta');
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
