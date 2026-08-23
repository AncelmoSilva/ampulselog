unit uampulselogreg;
//uAmpulseLogReg


{---------------------------------------------------------------------------
  Component: AmpulseLog (Derived from TCustomListBox)
  Copyright (C) 2026 R. Ancelmo Silva
  https://github.com/AncelmoSilva/ampulselog
  Contacts: suporte@raquel.adm.br

  This component is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License (LGPL) as
  modified by the Free Pascal Team (FPC modified LGPL v2 or later).

  As a special exception, the copyright holder permits the static linking
  of this component into commercial or closed-source executables without
  the obligation to open the main application source code.
---------------------------------------------------------------------------}


{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  uampulselog;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Common Controls', [TAmpulseLog]);
end;


initialization
  {$R uampulselogreg.rc}

end.
