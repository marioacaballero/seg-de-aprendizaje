
Unit CRUD_test;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, test_entity, test_utils, init_test_file, test_display,
general_displays;

Procedure createTest(leg: String; pos: word);
Procedure allTest();
Procedure readTest(leg: String; Var date: String);

Implementation

Procedure createTest(leg: String; pos: word);

Var 
  test: T_Test;
  f: T_File_Test;
Begin
  Assign(f, path_test);
  Reset(f);
  chargeTest(test, leg, pos);
  Seek(f, FileSize(f));
  Write(f, test);
  closeTestFile(f);
  WriteLn;
  writeln('Evaluacion cargada correctamente');
End;

Procedure readTest(leg: String; Var date: String);

Var 
  pos: integer;
  test: T_Test;
Begin
  WriteLn;
  write('Fecha de evaluación (DDMMAAAA): ');
  readln(date);
  validateDate(date);
  findSeg(leg, date, pos);
  If (pos = -1) Then
    WriteLn('No se encontró evaluación para la fecha')
  Else
    Begin
      testMemo(test, pos);
      showTest(test.numLegajo, test.fechaEval, test.seguimiento, test.
               observacion);
    End;
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
