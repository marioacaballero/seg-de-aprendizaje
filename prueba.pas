
Program prueba;

Uses crt;

Procedure test1(Var leg: String);

Var 
  key: Char;
Begin
  Repeat
    key := readkey;
    If (key <> chr(27)) Then
      If (key = chr(8)) Then
        Begin
          clrscr;
          // Para quitarle uno al string uso la funcion Delete
          Delete(leg, Length(leg), 1);
          write('leg: ', leg);
        End
    Else
      Begin
        clrscr;
        leg := leg + key;
        write('leg: ', leg);
      End
  Until key = chr(27);
End;

Var 
  leg: String;

Begin
  leg := '';
  write('leg: ');
  test1(leg);
  writeln('Saliste');
  writeln(leg);
End.
