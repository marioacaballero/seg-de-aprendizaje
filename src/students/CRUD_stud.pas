
Unit CRUD_stud;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, stud_entity, init_stud_file, usa_arbol, arbol_unit,
stud_display, general_displays, students_submenus, students_utils;

Procedure createStudent(leg: String; Var key: Char; Var rootLeg, rootName:
                        T_PUNT);
Procedure readStudent(leg: String; Var root:T_PUNT);
Procedure updateStudent(Var root: T_PUNT; leg: String);
Procedure deleteStudent(Var root: T_PUNT; leg: String);

Implementation
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
  student.numLegajo := leg;
  chargeSubMenu(student);
  If (Length(student.fechaNacimiento) > 6) Then
    Begin
      student.estado := True;
      initDiscapacidades(student);
      textcolor(white);
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
    End
  Else
    Begin
      student.nombre := '';
      student.apellido := '';
      student.fechaNacimiento := '';
      key := chr(27);
    End;
End;

Procedure readStudent(leg: String; Var root:T_PUNT);

Var 
  ENC: Boolean;
  student: T_Alumno;
  f: T_File_Alum;
  x: T_DATO_ARBOL;
Begin
  PREORDEN(root, leg, enc, x);
  If Not ENC  Then WRITELN ('No encontrado')
  Else
    Begin
      Assign(f, path_alum);
      Reset(f);
      Seek(f, x.pos_arch);
      Read(f, student);
      line(96);
      showStudentTitle();
      line(96);
      showStudent(student.numLegajo, student.apellido, student.nombre, student.
                  fechaNacimiento, student.estado,student.discapacidades);
      line(96);
      closeStudFile(f);
    End;
End;

Procedure updateStudent(Var root: T_PUNT; leg: String);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  x: T_DATO_ARBOL;
  resp: byte;
  enc: Boolean;
Begin
  PREORDEN(root, leg, enc, x);
  Assign(f, path_alum);
  Reset(f);
  Seek(f, x.pos_arch);
  Read(f, student);
  updateSubMenu(student);
  Seek(f, filepos(f) - 1);
  Write(f, student);
  closeStudFile(f);
End;

Procedure deleteStudent(Var root: T_PUNT; leg: String);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  x: T_DATO_ARBOL;
  enc: Boolean;
Begin
  PREORDEN(root, leg, enc, x);
  Assign(f, path_alum);
  Reset(f);
  Seek(f, x.pos_arch);
  Read(f, student);
  student.estado := false;
  // para dejarlo donde estaba hago un seek
  Seek(f, filepos(f) - 1);
  Write(f, student);
  WriteLn('');
  WriteLn('Alumno dado de baja');
  closeStudFile(f);
  readkey;
End;

End.
