unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.Dialogs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    ConOrigem: TFDConnection;
    ConDestino: TFDConnection;
    OpenDialog1: TOpenDialog;
    QOrigem: TFDQuery;
    QDestino: TFDQuery;
    QAuxOrigem: TFDQuery;
    QAuxDestino: TFDQuery;
    procedure ConOrigemAfterDisconnect(Sender: TObject);
    procedure ConOrigemAfterConnect(Sender: TObject);
    procedure ConDestinoAfterConnect(Sender: TObject);
    procedure ConDestinoAfterDisconnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uPrincipal;

{$R *.dfm}

procedure TDM.ConDestinoAfterConnect(Sender: TObject);
begin
  frmConversor.Status('Destino', 'Conectado');
end;

procedure TDM.ConDestinoAfterDisconnect(Sender: TObject);
begin
  frmConversor.Status('Destino', 'Desconectado');
end;

procedure TDM.ConOrigemAfterConnect(Sender: TObject);
begin
  frmConversor.Status('Origem', 'Conectado');
end;

procedure TDM.ConOrigemAfterDisconnect(Sender: TObject);
begin
  frmConversor.Status('Origem', 'Desconectado');
end;

end.
