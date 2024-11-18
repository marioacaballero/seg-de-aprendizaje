
Unit arbolUnit;

Interface

{$unitPath ../students/}

Uses initStudents;

Type 
  T_DATO_ARBOL = Record
    clave: string[100];
    //clave será o legajo o apynom
    pos_arch: word;
  End;

  T_PUNT = ^T_NODO;

  T_NODO = Record
    INFO: T_DATO_ARBOL;
    SAI,SAD: T_PUNT;
  End;

Procedure CREAR_ARBOL (Var RAIZ:T_PUNT);
Procedure AGREGAR (Var RAIZ:T_PUNT; X:T_DATO_ARBOL);
Function ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
Function ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;
Procedure suprime (Var raiz:t_punt; x:t_dato_ARBOL);
Procedure INORDEN(Var RAIZ:T_PUNT);
Procedure PREORDEN(RAIZ:T_PUNT; BUSCADO:String; Var ENC:BOOLEAN; Var X:
                   T_DATO_ARBOL
);

Implementation
Procedure CREAR_ARBOL (Var RAIZ:T_PUNT);
Begin
  RAIZ := Nil;
End;

Procedure AGREGAR (Var RAIZ:T_PUNT; X:T_DATO_ARBOL);
Begin
  If RAIZ = Nil Then
    Begin
      NEW (RAIZ);
      RAIZ^.INFO := X;
      RAIZ^.SAI := Nil;
      RAIZ^.SAD := Nil;
    End
  Else If RAIZ^.INFO.clave > X.clave Then AGREGAR (RAIZ^.SAI,X)
  Else AGREGAR (RAIZ^.SAD,X)
End;

Function ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
Begin
  ARBOL_VACIO := RAIZ = Nil;
End;

Function ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;
Begin
  ARBOL_LLENO := GETHEAPSTATUS.TOTALFREE < SIZEOF (T_NODO);
End;

Function suprime_min (Var raiz:t_punt): t_dato_ARBOL;

Var DIR: T_PUNT;
Begin
  If RAIZ^.SAI = Nil Then
    Begin
      suprime_min := raiz^.info;
      DIR := RAIZ;
      raiz := raiz^.sad;
      DISPOSE (DIR);
    End
  Else
    suprime_min := suprime_min (raiz^.sai)
End;

Procedure suprime (Var raiz:t_punt; x:t_dato_ARBOL);
Begin
  If raiz <> Nil Then
    If x.clave < raiz^.info.clave Then
      suprime (raiz^.sai,x)
  Else
    If x.clave > raiz^.info.clave Then
      suprime (raiz^.sad,x)
  Else
    If (raiz^.sai = Nil) And (raiz^.sad = Nil) Then
      raiz := Nil
  Else
    If (raiz^.sai = Nil) Then
      raiz := raiz^.sad
  Else
    If (raiz^.sad = Nil) Then
      raiz := raiz^.sai
  Else
    raiz^.info := suprime_min (raiz^.sad)
End;

Procedure PREORDEN(RAIZ:T_PUNT; BUSCADO:String; Var ENC:BOOLEAN; Var X:
                   T_DATO_ARBOL
);
Begin
  If (RAIZ = Nil) Then ENC := FALSE
  Else
    If ( RAIZ^.INFO.clave = BUSCADO) Then
      Begin
        ENC := TRUE;
        X := RAIZ^.INFO
      End
  Else If RAIZ^.INFO.clave > BUSCADO Then
         PREORDEN(RAIZ^.SAI,BUSCADO,ENC,X)
  Else
    PREORDEN(RAIZ^.SAD,BUSCADO,ENC,X)
End;

Procedure INORDEN(Var RAIZ:T_PUNT);

Var 
  f: T_File;
  student: T_Alumno;
Begin
  If RAIZ <> Nil Then
    Begin
      INORDEN (RAIZ^.SAI);
      Assign(f, path);
      reset(f);
      seek(f, RAIZ^.INFO.pos_arch);
      Read(f, student);
      showStudent(student.numLegajo, student.apellido, student.nombre, student.
                  fechaNacimiento);
      INORDEN (RAIZ^.SAD);
      Close(f);
    End;
End;

End.
