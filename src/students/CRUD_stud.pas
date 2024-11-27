
Unit CRUD_stud;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, sysutils, stud_entity, init_stud_file, usa_arbol, arbol_unit,
validator, stud_display;

Procedure createStudent(leg: String; Var key: Char; Var rootLeg, rootName:
                        T_PUNT);
Procedure readStudent(leg: String; Var root:T_PUNT);
Procedure updateStudent(root: T_PUNT);
Procedure deleteStudent();
Procedure showFindStudent(root: T_PUNT);

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

Procedure chargeStudent(Var student: T_Alumno; leg: String);

Var 
  name, lastName, date: string;
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
  student.estado := True;
  initDiscapacidades(student);
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
  chargeStudent(student, leg);
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

// Function showState(state: Boolean): string;
// Begin
//   If state Then
//     Write('Activo')
//   Else
//     Write('Inactivo');
// End;

Procedure showFindStudent(root: T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
Begin
  Assign(f, path_alum);
  Reset(f);
  Seek(f, root^.INFO.pos_arch);
  Read(f, student);
  showStudent(student.numLegajo, student.apellido, student.nombre, student.
              fechaNacimiento, student.discapacidades);
  closeStudFile(f);
End;

Procedure readStudent(leg: String; Var root:T_PUNT);

Begin
  CONSULTA(root, leg);
End;

Procedure updateStudent(root: T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
Begin
  clrscr;
  Assign(f, path_alum);
  Reset(f);
  Seek(f, root^.INFO.pos_arch);
  Read(f, student);
  showStudent(student.numLegajo, student.apellido, student.nombre, student.
              fechaNacimiento, student.discapacidades);
  chargeStudent(student, student.numLegajo);
  // para dejarlo donde estaba hago un seek
  Seek(f, filepos(f) - 1);
  Write(f, student);
  textcolor(white);
  WriteLn('Se actualizo el alumno');
  closeStudFile(f);
End;

Procedure deleteStudent();

Var 
  f: T_File_Alum;
  student: T_Alumno;
  legajo: string;
  flag: Boolean;
Begin
  Assign(f, path_alum);
  Reset(f);
  write('Legajo: ');
  readln(legajo);
  flag := False;
  While (Not Eof(f)) And (Not flag) Do
    Begin
      Read(f, student);
      If (student.numLegajo = legajo) Then
        Begin
          flag := True;
          student.estado := False;
          Write(f, student);
          writeln('Se elimino el alumno');
        End;
    End;
  If Not flag Then
    WriteLn('No se encontro el legajo');
  closeStudFile(f);
End;
End.
