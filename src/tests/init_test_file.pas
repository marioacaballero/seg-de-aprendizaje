
Unit init_test_file;

Interface

Uses test_entity;

Procedure initTestFile();
Procedure closeTestFile(Var f: T_File_Test);

Implementation

Procedure initTestFile();

Var 
  f: T_File_Test;
Begin
  Assign(f, path_test);
  //Para chequear se puede utilizar las directivas al compilador:
 {$I-}
  //orden al compilador que deshabilite el control de IO
  Reset(f);
{$I+}
  //orden al compilador que habilite el control de IO
  If IOResult<>0 Then Rewrite(f); {si no existe lo crea}
End;

Procedure closeTestFile(Var f: T_File_Test);
Begin
  Close(f);
End;

End.
