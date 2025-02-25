
Unit CRUD_test;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, test_entity, test_utils, init_test_file, test_display,
general_displays;

Procedure createTest(leg: String; pos: word);
Procedure allTestByStudent(leg: String);
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
      WriteLn;
      line(104);
      showTestTitle();
      line(104);
      showTest(test.numLegajo, test.fechaEval, test.seguimiento, test.
               observacion);
      line(104);
    End;
End;

Procedure allTestByStudent(leg: String);

Var 
  f: T_File_Test;
  test: T_Test;
Begin
  Assign(f, path_test);
  Reset(f);
  WriteLn;
  line(104);
  showTestTitle();
  line(104);
  While Not Eof(f) Do
    Begin
      Read(f, test);
      If (test.numLegajo = leg) Then
        showTest(test.numLegajo, test.fechaEval, test.seguimiento, test.
                 observacion)
    End;
  line(104);
  closeTestFile(f);
  readkey;
End;

End.
