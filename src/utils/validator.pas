
Unit validator;

Interface

Uses crt, sysutils;

Function legValidator(leg: String): Boolean;
Function birthdayValidator(birthday: String): Boolean;
Procedure nameAndLastValidator(name, text: String);

Implementation

Function legValidator(leg: String): Boolean;
Begin
  legValidator := Length(leg) = 8;
End;

Function dayValidator(day: Byte): Boolean;
Begin
  dayValidator := (day > 0) And (day < 32);
End;

Function monthValidator(month: byte): Boolean;
Begin
  monthValidator := (month > 0) And (month < 13);
End;

Function yearValidator(year: word): Boolean;
Begin
  yearValidator := (year > 1970) And (year < 2006);
End;

Function birthdayValidator(birthday: String): Boolean;

Var 
  day, month: byte;
  year: word;
Begin
  day := StrToInt(Copy(birthday, 1, 2));
  month := StrToInt(Copy(birthday, 3, 2));
  year := StrToInt(Copy(birthday, 5, 4));
  birthdayValidator := dayValidator(day) And monthValidator(month) And
                       yearValidator(year);
End;

Function nameValidator(name: String): Boolean;
Begin
  nameValidator := Length(name) > 2;
End;

Procedure nameAndLastValidator(name, text: String);
Begin
  While (Not nameValidator(name)) Do
    Begin
      textcolor(red);
      WriteLn('El ', text, ' debe contener al menos 3 digitos');
      WriteLn;
      textcolor(green);
      If (text = 'nombre') Then
        write('Nombres: ')
      Else
        Write('Apellidos: ');
      readln(name);
    End;
End;

End.
