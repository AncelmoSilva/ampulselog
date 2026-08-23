unit uampulselog;
//uAmpulseLog


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
  SysUtils,
  Controls,
  Graphics,
  StdCtrls,
  LCLType,
  Types,
  Clipbrd;

type

 
  { Log levels - Níveis do log }
  
  TLogLevel = (
    llInfo,
    llSuccess,
    llWarning,
    llError
  );

  { Internal record of each message }
  { Registro interno de cada mensagem }

  TLogItem = record
  ID: Int64;
  DataHora: TDateTime;
  Texto: string;
  Cor: TColor;
  Nivel: TLogLevel;
   end;



  { TAmpulseLog }

  TAmpulseLog = class(TCustomListBox)
  private
    FLog: array of TLogItem;

    { Font colors - Cores da fonte }
    FInfoColor: TColor;
    FSuccessColor: TColor;
    FWarningColor: TColor;
    FErrorColor: TColor;

    { Background colors - Cores do fundo }
    FInfoBackColor: TColor;
    FSuccessBackColor: TColor;
    FWarningBackColor: TColor;
    FErrorBackColor: TColor;

    { Behavior - Comportamento }
    FAutoScroll: Boolean;
    FMaxItems: Integer;

    { Display - Exibição }
    FShowTime: Boolean;
    FShowLevel: Boolean;
    FTimeFormat: string;

    { Controle interno de gravação }
	{ Internal recording control }
    FNextID: Int64;
    FLastSavedID: Int64;

    { Color setters - Setters das cores }
    procedure SetInfoColor(AValue: TColor);
    procedure SetSuccessColor(AValue: TColor);
    procedure SetWarningColor(AValue: TColor);
    procedure SetErrorColor(AValue: TColor);
    procedure SetInfoBackColor(AValue: TColor);
    procedure SetSuccessBackColor(AValue: TColor);
    procedure SetWarningBackColor(AValue: TColor);
    procedure SetErrorBackColor(AValue: TColor);

    { Behavior setters - Setters de comportamento }
    procedure SetAutoScroll(AValue: Boolean);
    procedure SetMaxItems(AValue: Integer);

    { Show Setters - Setters de exibição }
    procedure SetShowTime(AValue: Boolean);
    procedure SetShowLevel(AValue: Boolean);
    procedure SetTimeFormat(const AValue: string);

    { Internal methods - Métodos internos }
    procedure AddItem(
      const ATexto: string;
      ACor: TColor;
      ANivel: TLogLevel
    );

    function GetPrefixo(ANivel: TLogLevel): string;
    function GetCorNivel(ANivel: TLogLevel): TColor;
    function GetCorFundoNivel(ANivel: TLogLevel): TColor;
    function GetTextoExibicao(AIndex: Integer): string;

    protected
    procedure DrawItem(
      Index: Integer;
      ARect: TRect;
      State: TOwnerDrawState
    ); override;

    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Add a personalized message }
    { Adiciona uma mensagem personalizada }
    procedure Add(
      const ATexto: string;
      ACor: TColor
    );

    { Levels - Níveis }
    procedure Info(const ATexto: string);
    procedure Success(const ATexto: string);
    procedure Warning(const ATexto: string);
    procedure Error(const ATexto: string);

    { Control - Controle }
    procedure Clear; reintroduce;
    function Count: Integer;

    { File - Arquivo }
    procedure SaveToFile(const AFileName: string);
    procedure AppendToFile(const AFileName: string);

    { Clipboard - Área de transferência }
    procedure CopyToClipboard;

    published


    { Properties inherited from TCustomListBox -
     Propriedades herdadas do TCustomListBox }

    property Align;
    property Anchors;
    property BorderStyle;
    property BorderSpacing;
    property Color;
    property Constraints;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;



    {  Font colors - Cores da fonte }
	
    property InfoColor: TColor
      read FInfoColor
      write SetInfoColor
      default clBlue;

    property SuccessColor: TColor
      read FSuccessColor
      write SetSuccessColor
      default clGreen;

    property WarningColor: TColor
      read FWarningColor
      write SetWarningColor
      default clOlive;

    property ErrorColor: TColor
      read FErrorColor
      write SetErrorColor
      default clRed;


    {  Background colors - Cores do fundo }

    property InfoBackColor: TColor
      read FInfoBackColor
      write SetInfoBackColor
      default clWindow;

    property SuccessBackColor: TColor
      read FSuccessBackColor
      write SetSuccessBackColor
      default clWindow;

    property WarningBackColor: TColor
      read FWarningBackColor
      write SetWarningBackColor
      default clWindow;

    property ErrorBackColor: TColor
      read FErrorBackColor
      write SetErrorBackColor
      default clWindow;


    {  Component behavior - Comportamento }

    property AutoScroll: Boolean
      read FAutoScroll
      write SetAutoScroll
      default True;

    property MaxItems: Integer
      read FMaxItems
      write SetMaxItems
      default 0;


     { Display -  Exibição }

    property ShowTime: Boolean
      read FShowTime
      write SetShowTime
      default True;

    property ShowLevel: Boolean
      read FShowLevel
      write SetShowLevel
      default True;

    property TimeFormat: string
      read FTimeFormat
      write SetTimeFormat;

 
     { Events - Eventos }

    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
	
  end;


implementation


 
 { TAmpulseLog }
 { ------------------------- }
constructor TAmpulseLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

    { Standard font colors -  Cores padrão da fonte }
  FInfoColor := clBlue;
  FSuccessColor := clGreen;
  FWarningColor := clOlive;
  FErrorColor := clRed;


    { Standard background colors - Cores padrão do fundo }
  FInfoBackColor := clWindow;
  FSuccessBackColor := clWindow;
  FWarningBackColor := clWindow;
  FErrorBackColor := clWindow;


    { Behavior - Comportamento }
  FAutoScroll := True;
  FMaxItems := 0;


    { Display - Exibição }
  FShowTime := True;
  FShowLevel := True;
  FTimeFormat := 'hh:nn:ss';

     { Internal control - Controle interno }
   FNextID := 1;
   FLastSavedID := 0;

    { Visual configuration - Configuração visual }
  Style := lbOwnerDrawFixed;
  ItemHeight := 20;
  BorderStyle := bsSingle;
  IntegralHeight := False;

end;


destructor TAmpulseLog.Destroy;
begin
  SetLength(FLog, 0);

  inherited Destroy;
end;



 { SETTERS - FONT COLORS - CORES DA FONTE }

procedure TAmpulseLog.SetInfoColor(AValue: TColor);
begin
  if FInfoColor = AValue then
    Exit;

  FInfoColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetSuccessColor(AValue: TColor);
begin
  if FSuccessColor = AValue then
    Exit;

  FSuccessColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetWarningColor(AValue: TColor);
begin
  if FWarningColor = AValue then
    Exit;

  FWarningColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetErrorColor(AValue: TColor);
begin
  if FErrorColor = AValue then
    Exit;

  FErrorColor := AValue;

  Invalidate;
end;



 { SETTERS BACKGROUND COLORS - SETTERS CORES DO FUNDO }

procedure TAmpulseLog.SetInfoBackColor(AValue: TColor);
begin
  if FInfoBackColor = AValue then
    Exit;

  FInfoBackColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetSuccessBackColor(AValue: TColor);
begin
  if FSuccessBackColor = AValue then
    Exit;

  FSuccessBackColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetWarningBackColor(AValue: TColor);
begin
  if FWarningBackColor = AValue then
    Exit;

  FWarningBackColor := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetErrorBackColor(AValue: TColor);
begin
  if FErrorBackColor = AValue then
    Exit;

  FErrorBackColor := AValue;

  Invalidate;
end;



 { SETTERS  BEHAVIOR - SETTERS COMPORTAMENTO }

procedure TAmpulseLog.SetAutoScroll(AValue: Boolean);
begin
  if FAutoScroll = AValue then
    Exit;

  FAutoScroll := AValue;
end;


procedure TAmpulseLog.SetMaxItems(AValue: Integer);
var
  I: Integer;
  RemoveCount: Integer;
begin
  { We do not allow negative values -
  Não permitimos valor negativo }
  if AValue < 0 then
    AValue := 0;

  if FMaxItems = AValue then
    Exit;

  FMaxItems := AValue;

  { 0 = unlimited - 0 = ilimitado }
  if FMaxItems = 0 then
  begin
    Invalidate;
    Exit;
  end;

  { when there is nothing to remove
    - Nada para remover }
  if Length(FLog) <= FMaxItems then
  begin
    Invalidate;
    Exit;
  end;

  { Number of old items that need to go - 
  Quantidade de itens antigos que precisam sair }
  RemoveCount := Length(FLog) - FMaxItems;

  { Removes the oldest records -
  Remove os registros mais antigos }
  for I := RemoveCount to High(FLog) do
    FLog[I - RemoveCount] := FLog[I];

  SetLength(FLog, FMaxItems);

  { Keeps the ListBox synchronized -
   Mantém o ListBox sincronizado }
  while Items.Count > FMaxItems do
    Items.Delete(0);


  Invalidate;
end;


 
  { SETTERS SCREENING -
  EXIBIÇÃO }
 
procedure TAmpulseLog.SetShowTime(AValue: Boolean);
begin
  if FShowTime = AValue then
    Exit;

  FShowTime := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetShowLevel(AValue: Boolean);
begin
  if FShowLevel = AValue then
    Exit;

  FShowLevel := AValue;

  Invalidate;
end;


procedure TAmpulseLog.SetTimeFormat(const AValue: string);
begin
  if FTimeFormat = AValue then
    Exit;

  FTimeFormat := AValue;

  Invalidate;
end;



  { INTERNAL METHODS - MÉTODOS INTERNOS }

function TAmpulseLog.GetPrefixo(ANivel: TLogLevel): string;
begin
  case ANivel of

    llInfo:
      Result := '[INFO]';

    llSuccess:
      Result := '[OK]';

    llWarning:
      Result := '[AVISO]';

    llError:
      Result := '[ERRO]';

  else
    Result := '[INFO]';

  end;
end;


function TAmpulseLog.GetCorNivel(ANivel: TLogLevel): TColor;
begin
  case ANivel of

    llInfo:
      Result := FInfoColor;

    llSuccess:
      Result := FSuccessColor;

    llWarning:
      Result := FWarningColor;

    llError:
      Result := FErrorColor;

  else
    Result := clBlack;

  end;
end;


function TAmpulseLog.GetCorFundoNivel(ANivel: TLogLevel): TColor;
begin
  case ANivel of

    llInfo:
      Result := FInfoBackColor;

    llSuccess:
      Result := FSuccessBackColor;

    llWarning:
      Result := FWarningBackColor;

    llError:
      Result := FErrorBackColor;

  else
    Result := clWindow;

  end;
end;


function TAmpulseLog.GetTextoExibicao(AIndex: Integer): string;
var
  S: string;
begin
  Result := '';

  if (AIndex < 0) or
     (AIndex >= Length(FLog)) then
    Exit;

  S := '';

  { Time - Hora }
  if FShowTime then
  begin
    S := FormatDateTime(
      FTimeFormat,
      FLog[AIndex].DataHora
    );
  end;

  { Level- Nível }
  if FShowLevel then
  begin
    if S <> '' then
      S := S + '  ';

    S := S + GetPrefixo(FLog[AIndex].Nivel);
  end;

  { Message - Mensagem }
  if S <> '' then
    S := S + '  ';

  S := S + FLog[AIndex].Texto;

  Result := S;
end;



  { ADDITION OF ITEM - ADIÇÃO DE ITEM }

procedure TAmpulseLog.AddItem(
  const ATexto: string;
  ACor: TColor;
  ANivel: TLogLevel
);
var
  I: Integer;
begin
 
   { Record limit - Limite de registros }
  if (FMaxItems > 0) and
     (Length(FLog) >= FMaxItems) then
  begin

    { Removes the oldest record -
	Remove o registro mais antigo }
    for I := 1 to High(FLog) do
      FLog[I - 1] := FLog[I];

    SetLength(
      FLog,
      Length(FLog) - 1
    );

    { Removes the corresponding visual item -
	Remove o item visual correspondente }
    if Items.Count > 0 then
      Items.Delete(0);

  end;



   { Adds the new record - Adiciona o novo registro }

  I := Length(FLog);

  SetLength(
    FLog,
    I + 1
  );

  FLog[I].ID := FNextID;
  FLog[I].DataHora := Now;
  FLog[I].Texto := ATexto;
  FLog[I].Cor := ACor;
  FLog[I].Nivel := ANivel;

  Inc(FNextID);


  { The visual content will be designed using DrawItem. 
    O conteúdo visual será desenhado pelo DrawItem. }
  Items.Add('');


  { AutoScroll }
  if FAutoScroll then
    ItemIndex := Items.Count - 1;

    { Remove the selection after DrawItem.
   remove a seleção após DrawItem. }
  ClearSelection;

  Invalidate;
end;



 { DRAWING - DESENHO }

procedure TAmpulseLog.DrawItem(
  Index: Integer;
  ARect: TRect;
  State: TOwnerDrawState
);
var
  X: Integer;
  TextoHora: string;
  TextoNivel: string;
  TextoMensagem: string;
  MostrarHora: Boolean;
  MostrarNivel: Boolean;
begin

  if (Index < 0) or
     (Index >= Length(FLog)) then
    Exit;

  { Background color - Fundo }
  if odSelected in State then
    Canvas.Brush.Color := clHighlight
  else
    Canvas.Brush.Color :=
      GetCorFundoNivel(FLog[Index].Nivel);

  Canvas.FillRect(ARect);

    { Texts - Textos }
  TextoHora := '';
  TextoNivel := '';
 TextoMensagem := FLog[Index].Texto;

  MostrarHora := FShowTime;
  MostrarNivel := FShowLevel;

  if MostrarHora then
    TextoHora :=
      FormatDateTime(
        FTimeFormat,
        FLog[Index].DataHora
      );


  if MostrarNivel then
    TextoNivel :=
      GetPrefixo(FLog[Index].Nivel);


  X := ARect.Left + 4;

    { Time - Hora }

  if MostrarHora then
  begin

    if odSelected in State then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clGray;

    Canvas.TextOut(
      X,
      ARect.Top + 2,
      TextoHora
    );

    Inc(
      X,
      Canvas.TextWidth(TextoHora) + 10
    );
  end;


   { Level - Nível }
   
  if MostrarNivel then
  begin

    if odSelected in State then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color :=
        GetCorNivel(FLog[Index].Nivel);

    Canvas.TextOut(
      X,
      ARect.Top + 2,
      TextoNivel
    );

    Inc(
      X,
      Canvas.TextWidth(TextoNivel) + 10
    );
  end;


   { Message - Mensagem }

  if odSelected in State then
    Canvas.Font.Color := clHighlightText
  else
    Canvas.Font.Color := FLog[Index].Cor;

  Canvas.TextOut(
    X,
    ARect.Top + 2,
    TextoMensagem
  );

end;


{ PUBLIC METHODS - LEVELS
  MÉTODOS PÚBLICOS - NÍVEIS }

procedure TAmpulseLog.Add(
  const ATexto: string;
  ACor: TColor
);
begin
  AddItem(
    ATexto,
    ACor,
    llInfo
  );
end;


procedure TAmpulseLog.Info(const ATexto: string);
begin
  AddItem(
    ATexto,
    FInfoColor,
    llInfo
  );
end;


procedure TAmpulseLog.Success(const ATexto: string);
begin
  AddItem(
    ATexto,
    FSuccessColor,
    llSuccess
  );
end;


procedure TAmpulseLog.Warning(const ATexto: string);
begin
  AddItem(
    ATexto,
    FWarningColor,
    llWarning
  );
end;


procedure TAmpulseLog.Error(const ATexto: string);
begin
  AddItem(
    ATexto,
    FErrorColor,
    llError
  );
end;


{ COUNT }
function TAmpulseLog.Count: Integer;
begin
  Result := Length(FLog);
end;


{ Clears logs - Limpa registros }
procedure TAmpulseLog.Clear;
begin
  SetLength(
    FLog,
    0
  );

  Items.Clear;

  Invalidate;
end;



{ SAVE TO FILE - SALVAR EM ARQUIVO }

procedure TAmpulseLog.SaveToFile(
  const AFileName: string
);
var
  SL: TStringList;
  I: Integer;
  Linha: string;
begin
  SL := TStringList.Create;

  try

    for I := 0 to High(FLog) do
    begin

      Linha :=
        FormatDateTime(
          'dd/mm/yyyy hh:nn:ss',
          FLog[I].DataHora
        ) +
        '  ' +
        GetPrefixo(FLog[I].Nivel) +
        '  ' +
        FLog[I].Texto;

      SL.Add(Linha);
    end;

    if FLog <> nil then
    SL.SaveToFile(AFileName);

  finally
    SL.Free;
  end;
end;


{ APPEND TO FILE - ADICIONAR AO ARQUIVO }

procedure TAmpulseLog.AppendToFile(const AFileName: string);
var
  F: TextFile;
  I: Integer;
  Linha: string;
begin

  { If there are no records, there is nothing to add  -
  Se não existem registros, não há nada para acrescentar }
  if Length(FLog) = 0 then
    Exit;

  { If the file does not yet exist, write all records -
  Se o arquivo ainda não existe, grava todos os registros }
  if not FileExists(AFileName) then
    FLastSavedID := 0;

  AssignFile(F, AFileName);

  if FileExists(AFileName) then
    Append(F)
  else
    Rewrite(F);

  try

    for I := 0 to High(FLog) do
    begin

      { Only records entries that have not yet been saved -
	  Só grava registros que ainda não foram salvos }
      if FLog[I].ID > FLastSavedID then
      begin

        Linha :=
          FormatDateTime(
            'dd/mm/yyyy hh:nn:ss',
            FLog[I].DataHora
          ) +
          '  ' +
          GetPrefixo(FLog[I].Nivel) +
          '  ' +
          FLog[I].Texto;

        WriteLn(F, Linha);

        FLastSavedID := FLog[I].ID;
      end;

    end;

  finally
    CloseFile(F);
  end;
end;


{ CLIPBOARD - ÁREA DE TRANSFERÊNCIA }

procedure TAmpulseLog.CopyToClipboard;
var
  SL: TStringList;
  I: Integer;
begin
  SL := TStringList.Create;

  try

    for I := 0 to High(FLog) do
    begin

      SL.Add(
        FormatDateTime(
          'dd/mm/yyyy hh:nn:ss',
          FLog[I].DataHora
        ) +
        '  ' +
        GetPrefixo(FLog[I].Nivel) +
        '  ' +
        FLog[I].Texto
      );

    end;

    Clipboard.AsText := SL.Text;

  finally
    SL.Free;
  end;
end;



end.
