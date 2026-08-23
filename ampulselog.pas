{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit AmpulseLog;

{$warn 5023 off : no warning about unused units}
interface

uses
  uampulselog, uampulselogreg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uampulselogreg', @uampulselogreg.Register);
end;

initialization
  RegisterPackage('AmpulseLog', @Register);
end.
