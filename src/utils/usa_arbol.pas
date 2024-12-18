
Unit usa_arbol;

Interface

{$unitPath ../students/}
{$unitPath ../tests/}
{$unitPath ./}

Uses crt, arbol_unit, stud_entity, init_stud_file, stud_display,
general_displays, test_entity, init_test_file;

Procedure CARGAR_ARBOL(Var root:T_PUNT; X: T_DATO_ARBOL);
Procedure BUSCAR (root:T_PUNT; leg: String; Var find: Boolean);
Procedure LISTAR (root:T_PUNT);
Procedure initTree(Var root: T_PUNT);
Procedure initTreeApYNom(Var root: T_PUNT);
Procedure initTreeTest(Var root: T_PUNT);
Procedure LISTAR_DIF (root:T_PUNT; dif: Integer);

Implementation
Procedure CARGAR_ARBOL(Var root:T_PUNT; X: T_DATO_ARBOL);

Begin
  If (Not ARBOL_LLENO(root)) Then
    AGREGAR (root,X);
End;

Procedure BUSCAR (root:T_PUNT; leg: String; Var find: Boolean);

Var 
  X: T_DATO_ARBOL;
Begin
  If ARBOL_VACIO (root) Then WRITE ('No hay registros')
  Else PREORDEN (root, leg, find, X);;
End;

Procedure LISTAR (root:T_PUNT);
Begin
  If Not ARBOL_VACIO (root) Then
    Begin
      showDifficulties();
      line(96);
      showStudentTitle();
      line(96);
      INORDEN (root);
      line(96);
    End
  Else WRITELN ('No hay registros');
  readkey;
End;

Procedure LISTAR_DIF (root:T_PUNT; dif: Integer);
Begin
  If Not ARBOL_VACIO (root) Then
    Begin
      showDifficulties();
      line(96);
      showStudentTitle();
      line(96);
      INORDEN_DIF (root, dif);
      line(96);
    End
  Else WRITELN ('No hay registros');
  readkey;
End;

Procedure initTree(Var root: T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(root);
  Assign(f, path_alum);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(root)) Do
    Begin
      Read(f, student);
      treeData.clave := student.numLegajo;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(root, treeData);
    End;
  closeStudFile(f);
End;

Procedure initTreeApYNom(Var root: T_PUNT);

Var 
  f: T_File_Alum;
  student: T_Alumno;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(root);
  Assign(f, path_alum);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(root)) Do
    Begin
      Read(f, student);
      treeData.clave := student.apellido + ' ' + student.nombre;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(root, treeData);
    End;
  closeStudFile(f);
End;


Procedure initTreeTest(Var root: T_PUNT);

Var 
  f: T_File_Test;
  test: T_Test;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(root);
  Assign(f, path_test);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(root)) Do
    Begin
      Read(f, test);
      treeData.clave := test.numLegajo;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(root, treeData);
    End;
  closeTestFile(f);
End;


End.
