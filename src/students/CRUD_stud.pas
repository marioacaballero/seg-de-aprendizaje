
Unit CRUD_stud;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, sysutils, stud_entity, init_stud_file, usa_arbol, arbol_unit,
validator, stud_display;

Procedure createStudent(leg: String; Var key: Char; Var rootLeg, rootName:
                        T_PUNT);
Procedure readStudent(leg: String; Var root:T_PUNT);
Procedure updateStudent(Var root: T_PUNT; leg: String);
Procedure deleteStudent(Var root: T_PUNT; leg: String);
Procedure showFindStudent(Var root: T_PUNT);

Implementation

Procedure initDiscapacidades(Var student: T_Alumno);

Var 
  i: Byte;
Begin
  For i:= 1 To 5 Do
    student.discapacidades[i] := False;
End;

Procedure checkData(Var data: String; text: String);
Begin
  Case text Of 
    'nombre':
              Begin
                While (Not nameValidator(data)) Do
                  Begin
                    textcolor(red);
                    WriteLn('El nombre debe contener al menos 3 digitos');
                    WriteLn;
                    textcolor(green);
                    write('Nombres: ');
                    readln(data);
                  End;
              End;
    'apellido':
                Begin
                  While (Not lastNameValidator(data)) Do
                    Begin
                      textcolor(red);
                      WriteLn('El apellido debe contener al menos 3 digitos');
                      WriteLn;
                      textcolor(green);
                      write('Apellidos: ');
                      readln(data);
                    End;
                End;
    'fecha':
             Begin
               While (Not birthdayValidator(data)) Do
                 Begin
                   textcolor(red);
                   WriteLn('Fecha invalida');
                   WriteLn;
                   textcolor(green);
                   write('Fecha de nacimiento (DDMMAAAA): ');
                   readln(data);
                 End;
             End;
  End;
End;

Procedure chargeDif(Var student: T_Alumno);

Var 
  dif: array[1..5] Of string = ('Problemas del habla y lenguaje',
                                'Dificultad para escribir',
                                'Dificultades de aprendizaje visual',
                                'Memoria y otras dificultades del pensamiento',
                                'Destrezas sociales inadecuadas');
  i: byte;
  resp: string;
Begin
  textcolor(white);
  WriteLn;
  WriteLn('Dificultades:');
  WriteLn;
  textcolor(green);
  For i:= 1 To 5 Do
    Begin
      write(dif[i], ' S/N: ');
      ReadLn(resp);
      If (LowerCase(resp) = 's') Then
        student.discapacidades[i] := true;
    End;
End;

Procedure chargeStudent(Var student: T_Alumno; leg, typ: String);

Var 
  name, lastName, date, state: string;
Begin
  textcolor(white);
  WriteLn('');
  WriteLn('Complete los datos solicitados');
  WriteLn('');
  textcolor(green);
  WriteLn('Legajo: ', leg);
  student.numLegajo := leg;
  write('Nombres: ');
  readln(name);
  checkData(name, 'nombre');
  student.nombre := LowerCase(name);
  write('Apellidos: ');
  readln(lastName);
  checkData(lastName, 'apellido');
  student.apellido := LowerCase(lastName);
  write('Fecha de nacimiento (DDMMAAAA): ');
  readln(date);
  checkData(date, 'fecha');
  student.fechaNacimiento := date;
  If ( typ = 'crea') Then
    Begin
      student.estado := True;
      initDiscapacidades(student);
    End;
End;

// creo el estudiante y lo agrego al arbol de estudiantes
Procedure createStudent(leg: String; Var key: Char; Var rootLeg, rootName:
                        T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  studTreeLeg,studTreeApyN: T_DATO_ARBOL;
Begin
  Assign(f, path_alum);
  Reset(f);
  chargeStudent(student, leg, 'crea');
  Seek(f, FileSize(f));
  studTreeLeg.clave := student.numLegajo;
  studTreeLeg.pos_arch := FileSize(f);
  studTreeApyN.clave := student.apellido + ' ' + student.nombre;
  studTreeApyN.pos_arch := FileSize(f);
  Write(f, student);
  CARGAR_ARBOL(rootLeg, studTreeLeg);
  CARGAR_ARBOL(rootName, studTreeApyN);
  closeStudFile(f);
  key := chr(27);
  WriteLn('');
  textcolor(white);
  WriteLn('Alumno dado de alta');
End;

Procedure showFindStudent(Var root: T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
Begin
  Assign(f, path_alum);
  Reset(f);
  Seek(f, root^.INFO.pos_arch);
  Read(f, student);
  showStudent(student.numLegajo, student.apellido, student.nombre, student.
              fechaNacimiento, student.estado, student.discapacidades);
  closeStudFile(f);
End;

Procedure readStudent(leg: String; Var root:T_PUNT);

Var 
  x: T_DATO_ARBOL;
Begin
  CONSULTA(root, leg, x);
End;

Procedure updateStudent(Var root: T_PUNT; leg: String);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  x: T_DATO_ARBOL;
  resp: byte;
Begin
  clrscr;
  CONSULTA(root, leg, x);
  Assign(f, path_alum);
  Reset(f);
  Seek(f, x.pos_arch);
  Read(f, student);
  showUpdateMenu(resp, student.estado);
  Case resp Of 
    1: chargeStudent(student, student.numLegajo, 'mod');
    2: chargeDif(student);
    3: student.estado := True;
  End;
  // para dejarlo donde estaba hago un seek
  Seek(f, filepos(f) - 1);
  Write(f, student);
  textcolor(white);
  WriteLn('');
  If (resp <> 0) Then WriteLn('Se actualizo el alumno');
  closeStudFile(f);
End;

Procedure deleteStudent(Var root: T_PUNT; leg: String);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  x: T_DATO_ARBOL;
Begin
  clrscr;
  CONSULTA(root, leg, x);
  Assign(f, path_alum);
  Reset(f);
  Seek(f, x.pos_arch);
  Read(f, student);
  student.estado := false;
  // para dejarlo donde estaba hago un seek
  Seek(f, filepos(f) - 1);
  Write(f, student);
  textcolor(white);
  WriteLn('');
  WriteLn('Alumno dado de baja');
  closeStudFile(f);
End;
End.
