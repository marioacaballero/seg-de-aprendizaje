
Unit test_utils;

Interface

{$unitPath ../students/}
{$unitPath ../utils/}
{$unitPath ./}

Uses crt, sysutils, test_entity, init_test_file, stud_entity, init_stud_file,
general_displays, validator;

Const 
  difArray: array[1..5] Of string = (dif1,dif2,dif3,dif4,dif5);

Procedure chargeTest(Var test: T_Test; leg: String; pos: word);
Procedure findSeg(leg, date: String; Var pos: cardinal);
Procedure validateDate(Var data: String);

Implementation

Procedure checkObs(Var data: String);
Begin
  While (Not commentsValidator(data)) Do
    Begin
      textcolor(red);
      WriteLn('La observacion no debe exceder los 60 caracteres');
      WriteLn;
      textcolor(green);
      write('Observaciones (60 caracteres): ');
      readln(data);
    End;
End;

Procedure validateDate(Var data: String);
Begin
  While (Not dateValidator(data)) Do
    Begin
      textcolor(red);
      WriteLn('Fecha invalida');
      WriteLn;
      textcolor(green);
      write('Fecha de evaluación (DDMMAAAA): ');
      readln(data);
    End;
End;

Procedure checkDate(Var data: String; leg: String);

Var pos: Cardinal;
Begin
  validateDate(data);
  findSeg(leg, data, pos);
  While (pos >= 0) Do
    Begin
      textcolor(red);
      WriteLn('El alumno fue evaluado en la fecha');
      WriteLn;
      textcolor(green);
      write('Fecha de evaluación (DDMMAAAA): ');
      readln(data);
      findSeg(leg, data, pos);
    End;
End;

Procedure checkPoints(Var point: String; text: String);
Begin
  While (Not pointsValidator(point)) Do
    Begin
      textcolor(red);
      WriteLn('Ingrese un numero entre 0 y 4');
      WriteLn;
      textcolor(green);
      write(text);
      readln(point);
    End;
End;

Procedure chargeDifPoints(Var dif: T_Seguimiento; leg: String; pos: word);

Var 
  i: integer;
  points: string;
  text: string;
  f: T_File_Alum;
  stud: T_Alumno;
Begin
  textcolor(white);
  WriteLn;
  writeln('Valoracion de dificultades, complete con numero de 0 a 4');
  //consultar los valores
  writeln('Siendo 0 si.. y 4 si..');
  textcolor(green);
  WriteLn;
  Assign(f, path_alum);
  Reset(f);
  Seek(f, pos);
  read(f, stud);
  For i:= 1 To 5 Do
    Begin
      If (stud.discapacidades[i]) Then
        Begin
          text := IntToStr(i) + '. ' + difArray[i] + ': ';
          Write(text);
          ReadLn(points);
          checkPoints(points, text);
          dif[i] := StrToInt(points);
        End
      Else
        dif[i] := -1;
    End;
  WriteLn;
  closeStudFile(f);
End;

Procedure chargeTest(Var test: T_Test; leg: String; pos: word);

Var 
  fechaEval, obs: string;
Begin
  textcolor(white);
  WriteLn('');
  WriteLn('Complete los datos solicitados');
  WriteLn('');
  textcolor(green);
  WriteLn('Legajo: ', leg);
  test.numLegajo := leg;
  write('Fecha de evaluación (DDMMAAAA): ');
  readln(fechaEval);
  checkDate(fechaEval, leg);
  test.fechaEval := fechaEval;
  chargeDifPoints(test.seguimiento, leg, pos);
  write('Observaciones (60 caracteres): ');
  readln(obs);
  checkObs(obs);
  test.observacion := LowerCase(obs);
  textcolor(white);
End;

Procedure findSeg(leg, date: String; Var pos: cardinal);

Var 
  f: T_File_Test;
  test: T_Test;
Begin
  pos := -1;
  Assign(f, path_test);
  Reset(f);
  While (Not Eof(f)) And (pos = -1) Do
    Begin
      read(f, test);
      If (test.numLegajo = leg) And (test.fechaEval = date) Then
        pos := FilePos(f) - 1;
    End;
  closeTestFile(f);
End;

End.
