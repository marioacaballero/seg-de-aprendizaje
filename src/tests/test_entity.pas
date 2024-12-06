
Unit test_entity;

Interface

Const 
  path_test = './assets/test.dat';

Type 
  T_Seguimiento = array [1..5] Of Integer;
  T_Test = Record
    numLegajo: string[8];
    fechaEval: string[8];
    observacion: string[60];
    estado: Boolean;
    seguimiento: T_Seguimiento;
  End;

  T_File_Test = File Of T_Test;

Implementation

End.
