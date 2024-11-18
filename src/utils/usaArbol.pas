
Unit usaArbol;

Interface

{$unitPath ../students/}
{$unitPath ./}

Uses CRT, arbolUnit, initStudents;

Procedure CARGAR_ARBOL(Var RAIZ:T_PUNT; X: T_DATO_ARBOL);
// Procedure CONSULTA (Var RAIZ:T_PUNT);
Procedure LISTAR (RAIZ:T_PUNT);
// Procedure BAJA(Var RAIZ:T_PUNT);
Procedure initTree(Var raiz: T_PUNT);

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
Procedure CARGAR_ARBOL(Var RAIZ:T_PUNT; X: T_DATO_ARBOL);

Begin
  If (Not ARBOL_LLENO(RAIZ)) Then
    AGREGAR (RAIZ,X);
End;

// Procedure CONSULTA (Var RAIZ:T_PUNT);

// Var ENC: BOOLEAN;
//   CAR,X: T_DATO;
// Begin
//   WRITE('BUSCAR: ');
//   READLN (CAR);
//   PREORDEN (RAIZ,CAR,ENC,X);
//   If Not ENC  Then WRITELN ('NO SE ENCUENTRA' )
//   Else MUESTRA_DATOS (X);
//   readkey;
// End;

// Procedure BUSCAR (RAIZ:T_PUNT);
// Begin
//   If ARBOL_VACIO (RAIZ) Then WRITE ('ARBOL VACIO')
//   Else CONSULTA(RAIZ);
//   READKEY
// End;

Procedure LISTAR (RAIZ:T_PUNT);
Begin
  If Not ARBOL_VACIO (RAIZ) Then
    Begin
      line();
      showStudent('Legajo', 'Apellido', 'Nombre', 'Fec Nacim.');
      line();
      INORDEN (RAIZ)
    End
  Else WRITELN ('ARBOL VACIO');
  READKEY
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

Procedure initTree(Var raiz: T_PUNT);

Var 
  f: T_File;
  data: T_Alumno;
  treeData: T_DATO_ARBOL;
Begin
  CREAR_ARBOL(raiz);
  Assign(f, path);
  Reset(f);
  While (Not Eof(f)) And (Not ARBOL_LLENO(raiz)) Do
    Begin
      Read(f, data);
      treeData.clave := data.numLegajo;
      treeData.pos_arch := FilePos(f) - 1;
      CARGAR_ARBOL(raiz, treeData);
    End;
  Close(f);
End;

End.
