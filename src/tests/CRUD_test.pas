
Unit CRUD_test;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, test_entity, test_utils, init_test_file, test_display,
general_displays;

Procedure createTest(leg: String);
Procedure allTest();

Implementation

Procedure createTest(leg: String);

Var 
  test: T_Test;
  f: T_File_Test;
Begin
  Assign(f, path_test);
  Reset(f);
  chargeTest(test, leg);
  Seek(f, FileSize(f));
  Write(f, test);
  closeTestFile(f);
  WriteLn;
  writeln('Evaluacion cargada correctamente');
End;

Procedure readTest(leg, );
Begin

End;

Procedure updateTest(Var test: T_Test);
Begin

End;

Procedure allTest();

Var 
  f: T_File_Test;
  test: T_Test;
Begin
  Assign(f, path_test);
  Reset(f);
  line(104);
  showTestTitle();
  line(104);
  While Not Eof(f) Do
    Begin
      Read(f, test);
      showTest(test.numLegajo, test.fechaEval, test.seguimiento, test.
               observacion)
    End;
  line(104);
  closeTestFile(f);
  readkey;
End;

End.
