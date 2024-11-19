
Unit validator;

Interface

Uses sysutils;

Function legValidator(leg: String): Boolean;
// Function birthdayValidator(birthday: String): Boolean;
Function nameAndLastValidator(name: String): Boolean;

Implementation

Function legValidator(leg: String): Boolean;
Begin
  legValidator := Length(leg) = 8;
End;

// Function birthdayValidator(birthday: String): Boolean;

// Var 
//   day, month, year: string;
// Begin
//   day := StrToInt(Copy(birthday, 1, 2));
//   month := StrToInt(Copy(birthday, 3, 2));
//   year := Copy(birthday, 5, 4);




//   birthdayValidator := (day > 0) And (day < 32) And (month > 0) And (month < 13)
//                        And (Length(year) > 0) And (Length(year) < 5);
// End;

Function nameAndLastValidator(name: String): Boolean;
Begin
  nameAndLastValidator := Length(name) > 2;
End;

End.
