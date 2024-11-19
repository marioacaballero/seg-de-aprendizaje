
Unit usaArbol;

Interface

{$unitPath ../students/}
{$unitPath ./}

Uses CRT, arbolUnit, initStudents;

Procedure CARGAR_ARBOL(Var root:T_PUNT; X: T_DATO_ARBOL);
Procedure CONSULTA (Var root:T_PUNT; leg: String; text: String);
Procedure BUSCAR (root:T_PUNT; leg: String; Var find: Boolean);
Procedure LISTAR (root:T_PUNT);
// Procedure BAJA(Var RAIZ:T_PUNT);
Procedure initTree(Var root: T_PUNT);
Procedure initTreeApYNom(Var root: T_PUNT);

Implementation
// Procedure AGREGAR_NODO (Var RAIZ:T_PUNT);

// Var 
//   X: CHAR;
// Begin
//   CLRSCR;
//   WRITE ('INGRESE DATO: ');
//   READLN (X);
//   AGREGAR(RAIZ, X);
// End;

// Procedure MUESTRA_DATOS (x:T_DATO);
// Begin
//   WRITELN (X)
// End;

// Procedure CARGAR_ARBOL(Var RAIZ:T_PUNT);

// Var CAR,TECLA: CHAR;
// Begin
//   CLRSCR;
//   WRITE ('INGRESA? PRESIONE N PARA SALIR: ');
//   READLN (TECLA);
//   While Not (ARBOL_LLENO (RAIZ)) And (TECLA<> 'N') Do
//     Begin
//       CLRSCR;
//       WRITE ('INGRESA CARACTER: ');
//       READLN (CAR);
//       AGREGAR (RAIZ,CAR);
//       WRITE ('CONTINUA? PRESIONE N PARA SALIR: ');
//       READLN (TECLA);
//     End;
// End;
Procedure CARGAR_ARBOL(Var root:T_PUNT; X: T_DATO_ARBOL);

Begin
  If (Not ARBOL_LLENO(root)) Then
    AGREGAR (root,X);
End;

Procedure CONSULTA (Var root:T_PUNT; leg: String; text: String);

Var ENC: BOOLEAN;
  X: T_DATO_ARBOL;
  student: T_Alumno;
  f: T_File;
Begin
  PREORDEN (root, leg, ENC, X);
  If Not ENC  Then WRITELN (text)
  Else
    Begin
      Assign(f, path);
      Reset(f);
      Seek(f, x.pos_arch);
      Read(f, student);
      line();
      showStudent('Legajo', 'Apellido', 'Nombre', 'Fec Nacim.');
      line();
      showStudent(student.numLegajo, student.apellido, student.nombre, student.
                  fechaNacimiento);
      Close(f);
    End;
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
      line();
      showStudent('Legajo', 'Apellido', 'Nombre', 'Fec Nacim.');
      line();
      INORDEN (root)
    End
  Else WRITELN ('No hay registros');
End;

// Procedure BAJA1(Var RAIZ:T_PUNT);

// Var 
//   POS: T_PUNT;
//   ENC: BOOLEAN;
//   CAR,X: T_DATO;
//   RESP: CHAR;
// Begin
//   WRITE('BUSCAR: ');
//   READLN (CAR);
//   PREORDEN (RAIZ,CAR,ENC,X);
//   If Not ENC  Then WRITELN ('NO SE ENCUENTRA' )
//   Else
//     Begin
//       MUESTRA_DATOS (X);
//       WRITE ('ESTA SEGURO DE ELIMINAR LOS DATOS? S/N ');
//       READLN (RESP);
//       If upcase(RESP) = 'S' Then
//         SUPRIME(RAIZ,CAR);
//     End;
// End;

// Procedure BAJA(Var RAIZ:T_PUNT);
// Begin
//   If ARBOL_VACIO (RAIZ) Then WRITE ('ARBOL VACIO')
//   Else BAJA1(RAIZ);
//   READKEY
// End;

Procedure initTree(Var root: T_PUNT);

Var 
  f: T_File;
  student: T_Alumno;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(root);
  Assign(f, path);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(root)) Do
    Begin
      Read(f, student);
      treeData.clave := student.numLegajo;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(root, treeData);
    End;
  Close(f);
End;

Procedure initTreeApYNom(Var root: T_PUNT);

Var 
  f: T_File;
  student: T_Alumno;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(root);
  Assign(f, path);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(root)) Do
    Begin
      Read(f, student);
      treeData.clave := student.apellido + ' ' + student.nombre;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(root, treeData);
    End;
  Close(f);
End;

End.
