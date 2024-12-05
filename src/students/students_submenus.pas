
Unit students_submenus;

Interface

{$unitPath ./}

Uses crt, stud_entity, stud_display, students_utils;

Const 
  nOp1 = 4;
  opciones1: array[1..nOp1] Of string = ('Datos personales', 'Dificultades',
                                         'Dar de baja', 'Volver');
  opciones2: array[1..nOp1] Of string = ('Datos personales', 'Dificultades',
                                         'Dar de alta', 'Volver');
  opciones3: array[1..nOp1] Of string = ('Nombres', 'Apellidos',
                                         'Fecha de Nacimiento', 'Volver');

Procedure updateSubMenu(Var student: T_Alumno);

Implementation

Procedure personalDataMenu(Var student: T_Alumno);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleText();
    textcolor(green);
    line(96);
    showStudentTitle();
    line(96);
    showStudent(student.numLegajo, student.apellido, student.nombre, student.
                fechaNacimiento, student.estado, student.discapacidades);
    line(96);
    writeln('');
    For i:= 1 To nOp1 Do
      Begin
        If i = here Then
          textcolor(white)
        Else
          textcolor(green);
        WriteLn(i, '. ', opciones3[i]);
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
          // clrscr;
          Case here Of 
            1: changeName(student);
            2: changeLastName(student);
            3: changeBirthday(student);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
  clrscr;
End;

Procedure updateSubMenu(Var student: T_Alumno);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    titleText();
    textcolor(green);
    line(96);
    showStudentTitle();
    line(96);
    showStudent(student.numLegajo, student.apellido, student.nombre, student.
                fechaNacimiento, student.estado, student.discapacidades);
    line(96);
    writeln('');
    If (student.estado) Then
      Begin
        For i:= 1 To nOp1 Do
          Begin
            If i = here Then
              textcolor(white)
            Else
              textcolor(green);
            WriteLn(i, '. ', opciones1[i]);
          End;
      End
    Else
      Begin
        For i:= 1 To nOp1 Do
          Begin
            If i = here Then
              textcolor(white)
            Else
              textcolor(green);
            WriteLn(i, '. ', opciones2[i]);
          End;
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
            1: personalDataMenu(student);
            2: chargeDif(student);
            3: changeState(student);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
  clrscr;
End;

End.
