
Unit validator;

Interface

Uses crt, sysutils;

Function legValidator(leg: String): Boolean;
Function birthdayValidator(birthday: String): Boolean;
Function nameValidator(name: String): Boolean;
Function lastNameValidator(lastname: String): Boolean;

Implementation

Function legValidator(leg: String): Boolean;

Var i: byte;
Begin
  If (Length(leg) <> 8) Then
    legValidator := false
  Else
    Begin
      i := 1;
      legValidator := true;
      While (legValidator) And (i < 9) Do
        Begin
          If (leg[i] In ['0'..'9']) Then
            legValidator := true
          Else
            legValidator := false;
          Inc(i);
        End;
    End;
End;

Function dayValidator(day, month: Byte): Boolean;
Begin
  Case month Of 
    2: dayValidator := (day > 0) And (day < 29);
    1,3,5,7,8,10,12: dayValidator := (day > 0) And (day < 32);
    4,6,9,11: dayValidator := (day > 0) And (day < 31);
  End;
End;

Function monthValidator(month: byte): Boolean;
Begin
  monthValidator := (month > 0) And (month < 13);
End;

Function yearValidator(year: word): Boolean;
Begin
  yearValidator := year < 2006;
End;

Function birthdayValidator(birthday: String): Boolean;

Var 
  i, day, month: byte;
  year: word;
Begin
  i := 1;
  birthdayValidator := true;
  If (Length(birthday) = 0) Or (Length(birthday) > 8) Then
    birthdayValidator := false
  Else
    Begin
      While (i < 9) And  birthdayValidator Do
        Begin
          If Not (birthday[i] In ['0'..'9']) Then
            birthdayValidator := False;
          Inc(i);
        End;
      If (birthdayValidator) Then
        Begin
          day := StrToInt(Copy(birthday, 1, 2));
          month := StrToInt(Copy(birthday, 3, 2));
          year := StrToInt(Copy(birthday, 5, 4));
          birthdayValidator := dayValidator(day, month) And monthValidator(month
                               )
                               And yearValidator(year);
        End;
    End;
End;

Function nameValidator(name: String): Boolean;

Var i: byte;
Begin
  i := 1;
  nameValidator := True;
  If (Length(name) < 3) Then
    nameValidator := false
  Else
    Begin
      While (i <= Length(name)) And (nameValidator) Do
        Begin
          If (Not (name[i] In ['a'..'z'])) And (name[i] <> ' ') Then
            nameValidator := false;
          Inc(i);
        End;
    End;
End;

Function lastNameValidator(lastname: String): Boolean;

Var i: byte;
Begin
  i := 1;
  lastNameValidator := True;
  If (Length(lastname) < 3) Then
    lastNameValidator := false
  Else
    Begin
      While (i <= Length(lastname)) And (lastNameValidator) Do
        Begin
          If (Not (lastName[i] In ['a'..'z'])) And (lastName[i] <> ' ') Then
            lastNameValidator := false;
          Inc(i);
        End;
    End;
End;

End.
