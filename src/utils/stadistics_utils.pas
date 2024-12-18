
Unit stadistics_utils;

Interface

{$unitPath ../utils/}

Uses crt, sysutils, dateutils, init_test_file, test_entity, validator;

Procedure difStadistics();
Procedure highDifStadistics();

Implementation

Function StringToDate(data: String): TDateTime;

Var 
  day, month, year: Word;
Begin
  day := StrToInt(Copy(data, 1, 2));
  month := StrToInt(Copy(data, 3, 2));
  year := StrToInt(Copy(data, 5, 4));
  StringToDate := EncodeDate(year, month, day);
End;

Function CompareDates(fechaIni, fechaFin: String): Integer;

Var 
  fechaIniDate, fechaFinDate: TDateTime;
Begin
  fechaIniDate := StringToDate(fechaIni);
  fechaFinDate := StringToDate(fechaFin);
  CompareDates := CompareDate(fechaIniDate, fechaFinDate);
End;

Procedure validateDateIni(Var data: String);
Begin
  While (Not dateValidator(data)) Do
    Begin
      textcolor(red);
      WriteLn('Fecha invalida');
      WriteLn;
      textcolor(green);
      write('Ingrese fecha de inicio (DDMMAAAA): ');
      readln(data);
    End;
End;

Procedure validateDateFin(Var data: String; fechaIni: String);
Begin
  While (Not dateValidator(data)) Do
    Begin
      textcolor(red);
      WriteLn('Fecha invalida');
      WriteLn;
      textcolor(green);
      write('Ingrese fecha de fin (DDMMAAAA): ');
      readln(data);
    End;
  While (data <= fechaIni) Do
    Begin
      textcolor(red);
      WriteLn('La fecha de fin debe ser mayor o igual a la fecha de inicio');
      WriteLn;
      textcolor(green);
      write('Ingrese fecha de fin (DDMMAAAA): ');
      readln(data);
    End;
End;

Procedure difStadistics();

Var 
  f: T_File_Test;
  fechaIni, fechaFin: string;
  test: T_Test;
  difC: array[1..5] Of word;
  testC: word;
  i: byte;
Begin
  testC := 0;
  For i:= 1 To 5 Do
    difC[i] := 0;
  WriteLn;
  Write('Ingrese fecha de inicio (DDMMAAAA): ');
  readln(fechaIni);
  validateDateIni(fechaIni);
  Write('Ingrese fecha de fin (DDMMAAAA): ');
  readln(fechaFin);
  validateDateFin(fechaFin, fechaIni);
  Assign(f, path_test);
  Reset(f);
  While (Not Eof(f)) Do
    Begin
      Read(f, test);
      If (CompareDates(test.fechaEval, fechaIni) >= 0) And (CompareDates(test.
         fechaEval, fechaFin) <= 0) Then
        Begin
          For i:= 1 To 5 Do
            Begin
              If (test.seguimiento[i] >= 0) And (test.seguimiento[i] <= 4) Then
                difC[i] := difC[i] + 1;
            End;
          testC := testC + 1;
        End;
    End;
  closeTestFile(f);
  WriteLn;
  If (testC = 0) Then
    WriteLn('No hay evaluaciones en el rango de fechas ingresado')
  Else
    Begin
      WriteLn('Cantidad de evaluaciones en el rango de fechas: ', testC);
      writeln;
      For i:= 1 To 5 Do
        WriteLn('La dificultad ', i, ' estuvo presente en ', difC[i],
                ' evaluaciones del total.');
    End;
  readkey;
End;

Procedure highDifStadistics();

Var 
  f: T_File_Test;
  fechaIni, fechaFin: string;
  test: T_Test;
  difC: array[1..5] Of word;
  testC: word;
  i: byte;
Begin
  testC := 0;
  For i:= 1 To 5 Do
    difC[i] := 0;
  WriteLn;
  Write('Ingrese fecha de inicio (DDMMAAAA): ');
  readln(fechaIni);
  validateDateIni(fechaIni);
  Write('Ingrese fecha de fin (DDMMAAAA): ');
  readln(fechaFin);
  validateDateFin(fechaFin, fechaIni);
  Assign(f, path_test);
  Reset(f);
  While (Not Eof(f)) Do
    Begin
      Read(f, test);
      If (CompareDates(test.fechaEval, fechaIni) >= 0) And (CompareDates(test.
         fechaEval, fechaFin) <= 0) Then
        Begin
          For i:= 1 To 5 Do
            Begin
              If (test.seguimiento[i] > 2) And (test.seguimiento[i] <= 4) Then
                difC[i] := difC[i] + 1;
            End;
          testC := testC + 1;
        End;
    End;
  closeTestFile(f);
  WriteLn;
  If (testC = 0) Then
    WriteLn('No hay evaluaciones en el rango de fechas ingresado')
  Else
    Begin
      WriteLn('Cantidad de evaluaciones en el rango de fechas: ', testC);
      writeln;
      For i:= 1 To 5 Do
        If (difC[i] > 0) Then
          WriteLn('La dificultad ', i,
                  ' posee una ponderacion de 3 o 4 puntos y representa el ',
                  difC[i]/testC*100:0:1,
                  '% del total de evaluaciones que la poseen.');
    End;
  readkey;
End;

End.
