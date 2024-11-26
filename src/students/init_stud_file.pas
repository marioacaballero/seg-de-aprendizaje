
Unit init_stud_file;

Interface

Uses stud_entity;

Procedure initStudentFile();
Procedure closeStudFile(Var f: T_File_Alum);

Implementation

Procedure initStudentFile();

Var 
  f: T_File_Alum;
Begin
  Assign(f, path_alum);
  //Para chequear se puede utilizar las directivas al compilador:
 {$I-}
  //orden al compilador que deshabilite el control de IO
  Reset(f);
{$I+}
  //orden al compilador que habilite el control de IO
  If IOResult<>0 Then Rewrite(f); {si no existe lo crea}
End;

Procedure closeStudFile(Var f: T_File_Alum);
Begin
  Close(f);
End;

End.
