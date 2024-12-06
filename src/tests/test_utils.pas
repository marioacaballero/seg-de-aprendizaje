
Unit test_utils;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, sysutils, test_entity, general_displays, validator;

Const 
  difArray: array[1..5] Of string = (dif1,dif2,dif3,dif4,dif5);

Procedure chargeTest(Var test: T_Test; leg: String);
Procedure findSeg(leg, date: String; Var pos: cardinal);

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

Procedure checkDate(Var data: String; leg: String);

Var pos: Cardinal;
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

Procedure chargeDifPoints(Var dif: T_Seguimiento);

Var 
  i: integer;
  points: string;
  text: string;
Begin
  textcolor(white);
  WriteLn;
  writeln('Valoracion de dificultades, complete con numero de 0 a 4');
  //consultar los valores
  writeln('Siendo 0 si.. y 4 si..');
  textcolor(green);
  WriteLn;
  For i:= 1 To 5 Do
    Begin
      text := IntToStr(i) + '. ' + difArray[i] + ': ';
      Write(text);
      ReadLn(points);
      checkPoints(points, text);
      dif[i] := StrToInt(points);
    End;
  WriteLn;
End;

Procedure chargeTest(Var test: T_Test; leg: String);

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
  chargeDifPoints(test.seguimiento);
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
  While (Not Eof(f)) And (Not findSeg) Do
    Begin
      read(f, test);
      If (test.numLegajo = leg) And (test.fechaEval = date) Then
        pos := FilePos(f) - 1;
    End;
End;

End.
