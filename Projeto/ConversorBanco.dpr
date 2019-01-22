program ConversorBanco;

uses
  Vcl.Forms,
  uPrincipal in '..\Fontes\uPrincipal.pas' {frmConversor},
  uDM in '..\Fontes\uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConversor, frmConversor);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
