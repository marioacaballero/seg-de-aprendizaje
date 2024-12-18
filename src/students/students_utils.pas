
Unit students_utils;

Interface

{$unitpath ../utils/}
{$unitpath ./}

Uses crt, stud_entity, validator;

Procedure initDiscapacidades(Var student: T_Alumno);
Procedure checkData(Var data: String; text: String);
Procedure chargeDif(Var student: T_Alumno; here: Integer);
Procedure chargeStudent(Var student: T_Alumno; leg: String);
Procedure changeState(Var student: T_Alumno);
Procedure changeLastName(Var student: T_Alumno);
Procedure changeName(Var student: T_Alumno);
Procedure changeBirthday(Var student: T_Alumno);

Implementation

Procedure initDiscapacidades(Var student: T_Alumno);

Var 
  i: Byte;
Begin
  For i:= 1 To 5 Do
    student.discapacidades[i] := False;
End;

Procedure checkData(Var data: String; text: String);
Begin
  Case text Of 
    'nombre':
              Begin
                While (Not nameValidator(data)) Do
                  Begin
                    textcolor(red);
                    WriteLn('El nombre debe contener al menos 3 letras');
                    WriteLn;
                    textcolor(green);
                    write('Nombres: ');
                    readln(data);
                  End;
              End;
    'apellido':
                Begin
                  While (Not lastNameValidator(data)) Do
                    Begin
                      textcolor(red);
                      WriteLn('El apellido debe contener al menos 3 letras');
                      WriteLn;
                      textcolor(green);
                      write('Apellidos: ');
                      readln(data);
                    End;
                End;
    'fecha':
             Begin
               While (Not birthdayValidator(data)) Do
                 Begin
                   textcolor(red);
                   WriteLn('Fecha invalida');
                   WriteLn;
                   textcolor(green);
                   write('Fecha de nacimiento (DDMMAAAA): ');
                   readln(data);
                 End;
             End;
  End;
End;

Procedure chargeDif(Var student: T_Alumno; here: Integer);
Begin
  student.discapacidades[here] := Not student.discapacidades[here];
End;

Procedure chargeStudent(Var student: T_Alumno; leg: String);

Var 
  name, lastName, date: string;
Begin
  textcolor(white);
  WriteLn('');
  WriteLn('Complete los datos solicitados');
  WriteLn('');
  textcolor(green);
  WriteLn('Legajo: ', leg);
  student.numLegajo := leg;
  write('Nombres: ');
  readln(name);
  checkData(name, 'nombre');
  student.nombre := LowerCase(name);
  write('Apellidos: ');
  readln(lastName);
  checkData(lastName, 'apellido');
  student.apellido := LowerCase(lastName);
  write('Fecha de nacimiento (DDMMAAAA): ');
  readln(date);
  checkData(date, 'fecha');
  student.fechaNacimiento := date;
  student.estado := True;
  initDiscapacidades(student);
  textcolor(white);
End;

Procedure changeState(Var student: T_Alumno);
Begin
  If (student.estado) Then
    student.estado := False
  Else
    student.estado := True;
End;

Procedure changeLastName(Var student: T_Alumno);

Var apellido: string;
Begin
  WriteLn;
  write('Apellidos: ');
  readln(apellido);
  student.apellido := LowerCase(apellido);
  If (Not lastNameValidator(student.apellido)) Then
    Begin
      textcolor(red);
      WriteLn('El apellido debe contener al menos 3 letras y no numeros');
      textcolor(green);
      changeLastName(student);
    End;
End;

Procedure changeName(Var student: T_Alumno);

Var nombre: string;
Begin
  WriteLn;
  write('Nombres: ');
  readln(nombre);
  student.nombre := LowerCase(nombre);
  If (Not nameValidator(student.nombre)) Then
    Begin
      textcolor(red);
      WriteLn('El nombre debe contener al menos 3 letras y no numeros');
      textcolor(green);
      changeName(student);
    End;
End;

Procedure changeBirthday(Var student: T_Alumno);
Begin
  WriteLn;
  write('Fecha de nacimiento (DDMMAAAA): ');
  readln(student.fechaNacimiento);
  If (Not birthdayValidator(student.fechaNacimiento)) Then
    Begin
      textcolor(red);
      WriteLn('Fecha invalida');
      textcolor(green);
      changeBirthday(student);
    End;
End;

End.
