
Unit students_submenus;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, stud_entity, stud_display, students_utils, general_displays, validator
;

Const 
  nOp1 = 4;
  nOp2 = 6;
  opciones1: array[1..nOp1] Of string = ('Datos personales', 'Dificultades',
                                         'Dar de baja', 'Volver');
  opciones2: array[1..nOp1] Of string = ('Datos personales', 'Dificultades',
                                         'Dar de alta', 'Volver');
  opciones3: array[1..nOp1] Of string = ('Nombres', 'Apellidos',
                                         'Fecha de Nacimiento', 'Volver');
  opciones4: array[1..nOp2] Of string = (dif1,dif2,dif3,dif4,dif5,'Volver');

Procedure chargeSubMenu(Var student: T_Alumno);
Procedure updateSubMenu(Var student: T_Alumno);

Implementation

Function submenuTitles(student: T_Alumno; show: Boolean): string;
Begin
  titleText();
  textcolor(green);
  If (show) Then
    Begin
      line(96);
      showStudentTitle();
      line(96);
      showStudent(student.numLegajo, student.apellido, student.nombre, student.
                  fechaNacimiento, student.estado, student.discapacidades);
      line(96);
    End
  Else
    Begin
      WriteLn('Legajo: ', student.numLegajo);
      If (Length(student.nombre) > 3) Then
        WriteLn('Nombres: ', student.nombre);
      If (Length(student.apellido) > 3) Then
        WriteLn('Apellidos: ', student.apellido);
      If (Length(student.fechaNacimiento) > 3) Then
        WriteLn('Fecha de Nacimiento (DDMMAAAA): ', student.fechaNacimiento);
    End;
  writeln('');
End;

Procedure changeNameMenu(Var student: T_Alumno; show: Boolean);

Var 
  name: String;
  key: Char;
Begin
  name := '';
  Repeat
    clrscr;
    submenuTitles(student, show);
    Write('Nombres: ', name);
    key := readkey;
    If (key <> chr(27)) Then
      If (key = chr(8)) Then
        Begin
          clrscr;
          // Para quitarle uno al string uso la funcion Delete
          Delete(name, Length(name), 1);
        End
    Else If (key = chr(13)) Then
           Begin
             If (nameValidator(name)) Then
               Begin
                 student.nombre := name;
                 key := chr(27);
                 WriteLn;
                 WriteLn;
                 textcolor(white);
                 WriteLn('Guardado, enter para continuar');
                 textcolor(green);
                 If (show) Then
                   readkey;
               End
             Else
               Begin
                 textcolor(red);
                 WriteLn;
                 WriteLn;
                 WriteLn('Debe contener al menos 3 letras sin numeros');
                 textcolor(green);
                 readkey;
                 clrscr;
               End;
           End
    Else
      Begin
        clrscr;
        name := name + key;
      End;
  Until key = chr(27);
  If show Then
    clrscr();
End;

Procedure changeLastnameMenu(Var student: T_Alumno; show: Boolean);

Var 
  lastname: string;
  key: Char;
Begin
  lastname := '';
  Repeat
    clrscr;
    submenuTitles(student, show);
    Write('Apellidos: ', lastname);
    key := readkey;
    If (key <> chr(27)) Then
      If (key = chr(8)) Then
        Begin
          clrscr;
          // Para quitarle uno al string uso la funcion Delete
          Delete(lastname, Length(lastname), 1);
        End
    Else If (key = chr(13)) Then
           Begin
             If (lastNameValidator(lastname)) Then
               Begin
                 student.apellido := lastname;
                 key := chr(27);
                 WriteLn;
                 WriteLn;
                 textcolor(white);
                 WriteLn('Guardado, enter para continuar');
                 textcolor(green);
                 If (show) Then
                   readkey;
               End
             Else
               Begin
                 textcolor(red);
                 WriteLn;
                 WriteLn;
                 WriteLn('Debe contener al menos 3 letras sin numeros');
                 textcolor(green);
                 readkey;
                 clrscr;
               End;
           End
    Else
      Begin
        clrscr;
        lastname := lastname + key;
      End;
  Until key = chr(27);
  If show Then
    clrscr();
End;

Procedure changeBirthdayMenu(Var student: T_Alumno; show: Boolean);

Var 
  birthday: string;
  key: Char;
Begin
  birthday := '';
  Repeat
    clrscr;
    submenuTitles(student, show);
    Write('Fecha de nacimiento (DDMMAAAA): ', birthday);
    key := readkey;
    If (key <> chr(27)) Then
      If (key = chr(8)) Then
        Begin
          clrscr;
          // Para quitarle uno al string uso la funcion Delete
          Delete(birthday, Length(birthday), 1);
        End
    Else If (key = chr(13)) Then
           Begin
             If (birthdayValidator(birthday)) Then
               Begin
                 student.fechaNacimiento := birthday;
                 key := chr(27);
                 WriteLn;
                 WriteLn;
                 textcolor(white);
                 WriteLn('Guardado, enter para continuar');
                 textcolor(green);
                 If (show) Then
                   readkey;
               End
             Else
               Begin
                 textcolor(red);
                 WriteLn;
                 WriteLn;
                 WriteLn('Fecha invalida');
                 textcolor(green);
                 readkey;
                 clrscr;
               End;
           End
    Else
      Begin
        clrscr;
        birthday := birthday + key;
      End;
  Until key = chr(27);
  If show Then
    clrscr();
End;

Procedure personalDataMenu(Var student: T_Alumno);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    submenuTitles(student, true);
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
          Case here Of 
            1: changeNameMenu(student, True);
            2: changeLastnameMenu(student, True);
            3: changeBirthdayMenu(student, True);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
  clrscr;
End;

Procedure difficultsMenu(Var student: T_Alumno);

Var 
  i, here: integer;
  key: Char;
  haveDif: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    submenuTitles(student, true);
    For i:= 1 To nOp2 Do
      Begin
        If i = here Then
          textcolor(white)
        Else
          textcolor(green);
        If (i < 6) Then
          Begin
            If (student.discapacidades[i]) Then
              haveDif := 'S'
            Else
              haveDif := 'N';
            WriteLn(i, '. ', opciones4[i], ' (', haveDif,')');
          End
        Else
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
            chargeDif(student, here)
          Else
            key := chr(27);
        End;
  Until key = chr(27);
  clrscr;
End;

Procedure chargeSubMenu(Var student: T_Alumno);

Var 
  key: Char;
Begin
  Repeat
    If (key <> Chr(27)) Then
      Begin
        changeNameMenu(student, false);
        key := readkey;
        If (key <> Chr(27)) Then
          Begin
            changeLastnameMenu(student, False);
            key := readkey;
            If (key <> Chr(27)) Then
              Begin
                changeBirthdayMenu(student, False);
                key := readkey;
                If (key = chr(13)) Then
                  Begin
                    WriteLn('');
                    textcolor(white);
                    WriteLn('Alumno dado de alta');
                    key := chr(27);
                    readkey;
                  End;
              End;
          End;
      End;
  Until key = chr(27);
End;

Procedure updateSubMenu(Var student: T_Alumno);

Var 
  i, here: integer;
  key: Char;
Begin
  here := 1;
  Repeat
    clrscr;
    submenuTitles(student, true);
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
            2: difficultsMenu(student);
            3: changeState(student);
            Else
              key := chr(27);
          End;
        End;
  Until key = chr(27);
  clrscr;
End;

End.
