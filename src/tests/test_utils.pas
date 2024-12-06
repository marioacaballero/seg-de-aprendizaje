
Unit test_utils;

Interface

{$unitPath ../utils/}
{$unitPath ./}

Uses crt, sysutils, test_entity, general_displays, validator;

Const 
  difArray: array[1..5] Of string = (dif1,dif2,dif3,dif4,dif5);

Procedure chargeTest(Var test: T_Test; leg: String);

Implementation

Procedure checkDataTest(Var data: String; text: String);
Begin
  Case text Of 
    'obs':
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
    'fecha':
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
  checkDataTest(fechaEval, 'fecha');
  test.fechaEval := fechaEval;
  chargeDifPoints(test.seguimiento);
  write('Observaciones (60 caracteres): ');
  readln(obs);
  checkDataTest(obs, 'obs');
  test.observacion := LowerCase(obs);
  textcolor(white);
End;

End.
