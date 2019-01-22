unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.Buttons, Vcl.ComCtrls;

type
  TfrmConversor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    rgSistemas: TRadioGroup;
    gbInfor: TGroupBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    gbOrigem: TGroupBox;
    gbDestino: TGroupBox;
    Label1: TLabel;
    lblCliImpor: TLabel;
    btnFechar: TButton;
    btnConverter: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtCaminhoOri: TEdit;
    edtUsuarioOri: TEdit;
    edtSenhaOri: TEdit;
    edtServerOri: TEdit;
    edtPortaOri: TEdit;
    dbtPesquisar: TSpeedButton;
    btnConectarOri: TButton;
    cbusarPadraoOri: TCheckBox;
    Label10: TLabel;
    lblStatusOri: TLabel;
    Label11: TLabel;
    edtCaminhoDes: TEdit;
    Label12: TLabel;
    edtUsuarioDes: TEdit;
    Label13: TLabel;
    edtSenhaDes: TEdit;
    edtPortaDes: TEdit;
    Label14: TLabel;
    edtServerDes: TEdit;
    Label15: TLabel;
    SpeedButton1: TSpeedButton;
    cbusarPadraoDes: TCheckBox;
    lblStatusDes: TLabel;
    Label17: TLabel;
    btnConectarDes: TButton;
    Progress: TProgressBar;
    pnlMensagem: TPanel;
    Label3: TLabel;
    lblProImpor: TLabel;
    lblTodosPro: TLabel;
    Label4: TLabel;
    lblTodosCli: TLabel;
    Label18: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbusarPadraoOriClick(Sender: TObject);
    procedure cbusarPadraoDesClick(Sender: TObject);
    procedure rgSistemasClick(Sender: TObject);
    procedure dbtPesquisarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnConectarOriClick(Sender: TObject);
    procedure btnConectarDesClick(Sender: TObject);
    procedure btnConverterClick(Sender: TObject);
  private
    { Private declarations }
    iCodigo: Integer;
    procedure Limpar;    
    procedure Habilitar(Tipo: Boolean);
    procedure MenssagemStat(Texto: string; Mostrar: Boolean);
    procedure ZeraContador;
    procedure IniciarProgresso(Max: integer);  
    procedure ProximoProgresso;
    procedure BuscaCepDestino(cep, logradouro, bairro, cidade, cidadeibge, uf, ufibge, paisibge: string);
    procedure CriarCassificacao;
    function ProximoID(Tabela, Campo: string): Integer;
    function TiraPontos(texto : String) : String;

  public
    { Public declarations } 
    procedure Status(Tipo, Status: string);
  end;

var
  frmConversor: TfrmConversor;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmConversor.btnConectarDesClick(Sender: TObject);
begin
  with DM do
    begin
      if (edtCaminhoDes.Text = '') or (edtUsuarioDes.Text = '') or (edtSenhaDes.Text = '') or
         (edtServerDes.Text = '') or (edtPortaDes.Text = '') then
        begin
          ShowMessage('Por Favor Preencher Todos o Campos.');
          exit;
        end
      else
        begin
          ConDestino.Connected :=  False;
          try
            with ConDestino.Params do
              begin
                Values['Database']   :=  edtCaminhoDes.Text;
                Values['User_Name']  :=  AnsiLowerCase(edtUsuarioDes.Text);
                Values['Password']   :=  AnsiLowerCase(edtSenhaDes.Text);
                Values['Server']     :=  edtServerDes.Text;
                Values['Port']       :=  edtPortaDes.Text;
              end;
            ConDestino.Connected := True;
            ShowMessage('Conexão Feita com Sucesso!');
          except
           on E: exception do
            begin
              ShowMessage('Falha ao Conectar!'+#13+E.Message);
            end;
          end;
        end;
    end;
end;

procedure TfrmConversor.btnConectarOriClick(Sender: TObject);
begin
  with DM do
    begin
      if (edtCaminhoOri.Text = '') or (edtUsuarioOri.Text = '') or (edtSenhaOri.Text = '') or
         (edtServerOri.Text = '') or (edtPortaOri.Text = '') then
        begin
          ShowMessage('Por Favor Preencher Todos o Campos.');
          exit;
        end
      else
        begin
          ConOrigem.Connected :=  False;
          try
            with ConOrigem.Params do
              begin
                Values['Database']   :=  edtCaminhoOri.Text;
                Values['User_Name']  :=  AnsiLowerCase(edtUsuarioOri.Text);
                Values['Password']   :=  AnsiLowerCase(edtSenhaOri.Text);
                Values['Server']     :=  edtServerOri.Text;
                Values['Port']       :=  edtPortaOri.Text;
              end;
            ConOrigem.Connected := True;
            ShowMessage('Conexão Feita com Sucesso!');
          except
           on E: exception do
            begin
              ShowMessage('Falha ao Conectar!'+#13+E.Message);
            end;
          end;
        end;
    end;
end;

procedure TfrmConversor.btnConverterClick(Sender: TObject);
  function BuscaCPFCNPJ(ID: integer; Tipo: Integer): string; //CompuFour Software
  begin
    //Tipo:
    //0 : CPF/CNPJ
    //1 : RG/IE
    with dm.QAuxOrigem do
      begin
        //CPF
        Close;
        SQL.Clear;
        sql.Add('select * from tb_cli_pf where id_cliente = :id');
        ParamByName('id').AsInteger :=  ID;
        Open;
        if not IsEmpty then
          begin
            if Tipo = 0 then
              Result  :=  FieldByName('cpf').AsString
            else if Tipo = 1 then
              Result  :=  FieldByName('identidade').AsString;
          end
        else
          begin
            //CNPJ
            Close;
            SQL.Clear;
            sql.Add('select * from tb_cli_pj where id_cliente = :id');
            ParamByName('id').AsInteger :=  ID;
            Open;
            if not IsEmpty then
              begin
                if Tipo = 0 then
                  Result  :=  FieldByName('cnpj').AsString
                else if Tipo = 1 then
                  Result  :=  FieldByName('insc_estad').AsString;
              end
            else
              Result  :=  '';
          end;
      end;
  end;
  function BuscaCidadeUF(ID: string; Tipo: Integer): string; //CompuFour Software
  begin
    //Tipo:
    //0 : Cidade
    //1 : UF
    with dm.QAuxOrigem do
      begin
        Close;
        SQL.Clear;
        sql.Add('select * from tb_cidade_sis where id_cidade = :cid');
        ParamByName('cid').AsString :=  ID;
        Open;
        if IsEmpty then
          Result  :=  ''
        else
          begin
            if Tipo = 0 then
              Result  :=  FieldByName('nome').AsString
            else
              Result  :=  FieldByName('sigla_uf').AsString;
          end;
      end;
  end;
var
  I: integer;
begin
  //Informação para Usuario
  if Application.MessageBox('O Banco de DESTINO está limpo?'+#13+'Se Não Por favor Limpar para Evitar Erros!', 'A T E N Ç Ã O !', MB_YESNO+MB_ICONQUESTION) = IDNO then
    Exit;
  case rgSistemas.ItemIndex of
    0:  //CompuFour Software
      begin
        if (dm.ConOrigem.Connected = False) or (dm.ConDestino.Connected = False) then
          begin
            ShowMessage('Por favor verifique se o Destino e Origem estão conectados!');
            Exit;
          end;
        try
          //Importar Clientes
          MenssagemStat('Importando Cliente...', True);
          with dm.QOrigem do
            begin
              Close;
              sql.Clear;
              sql.Add(
                      'select ' +
                      'c.id_cliente, ' +
                      'c.id_tipo, ' +
                      'c.nome, ' +
                      'c.end_lograd, ' +
                      'c.end_numero, ' +
                      'c.end_comple, ' +
                      'c.end_bairro, ' +
                      'c.id_cidade, ' +
                      'c.end_cep, ' +
                      'c.fone_resid, ' +
                      'c.fone_fax, ' +
                      'c.fone_celul ' +
                      'from tb_cliente c ' +
                      'order by c.id_cliente ');
              Open;
            end;
          if dm.QOrigem.IsEmpty then
            MenssagemStat('Não Encontrados Clientes...', True)
          else
            begin
              with  dm  do
                begin
                  I :=  0;
                  iCodigo :=  ProximoID('pessoas', 'codigo');
                  lblTodosCli.Caption :=  IntToStr(QOrigem.RecordCount);
                  lblTodosCli.Refresh;
                  IniciarProgresso(QOrigem.RecordCount);
                  QOrigem.First;
                  while not QOrigem.Eof do
                    begin
                      with QDestino do
                        begin
                          close;
                          sql.Clear;
                          sql.Add(
                                  'insert into pessoas ( ' +
                                  'codigo, ' +
                                  'tipo, ' +
                                  'tipopessoa, ' +
                                  'nomefantasia, ' +
                                  'razaosocial, ' +
                                  'cnpj, ' +
                                  'inscricaoestadual, ' +
                                  'logradouroresidencial, ' +
                                  'numerolocalresidencial, ' +
                                  'complementoresidencial, ' +
                                  'bairroresidencial, ' +
                                  'cidaderesidencial, ' +
                                  'ufresidencial, ' +
                                  'cepresidencial, ' +
                                  'pontoreferenciaresidencial, ' +
                                  'contatoresidencial, ' +
                                  'emailresidencial, ' +
                                  'telefoneresidencial, ' +
                                  'faxresidencial, ' +
                                  'celularresidencial, ' +
                                  'observacoes, ' +
                                  'bloqueado, ' +
                                  'usuario, ' +
                                  'cadastro, ' +
                                  'alteracao, ' +
                                  'numeroestacao, ' +
                                  'ESTADOCIVIL, ' +
                                  'SEXO, ' +
                                  'UFENTREGA, ' +
                                  'CEPENTREGA, ' +
                                  'UFCOBRANCA, ' +
                                  'CEPCOBRANCA, ' +
                                  'LIMITECREDITO, ' +
                                  'MENSALISTA, ' +
                                  'REGISTRODEBITOS) ' +
                                  'values ( ' +
                                  ':codigo, ' +
                                  ':tipo, ' +
                                  ':tipopessoa, ' +
                                  ':nomefantasia, ' +
                                  ':razaosocial, ' +
                                  ':cnpj, ' +
                                  ':inscricaoestadual, ' +
                                  ':logradouroresidencial, ' +
                                  ':numerolocalresidencial, ' +
                                  ':complementoresidencial, ' +
                                  ':bairroresidencial, ' +
                                  ':cidaderesidencial, ' +
                                  ':ufresidencial, ' +
                                  ':cepresidencial, ' +
                                  ':pontoreferenciaresidencial, ' +
                                  ':contatoresidencial, ' +
                                  ':emailresidencial, ' +
                                  ':telefoneresidencial, ' +
                                  ':faxresidencial, ' +
                                  ':celularresidencial, ' +
                                  ':observacoes, ' +
                                  ':bloqueado, ' +
                                  ':usuario, ' +
                                  ':cadastro, ' +
                                  ':alteracao, ' +
                                  ':numeroestacao, ' +
                                  ':ESTADOCIVIL, ' +
                                  ':SEXO, ' +
                                  ':UFENTREGA, ' +
                                  ':CEPENTREGA, ' +
                                  ':UFCOBRANCA, ' +
                                  ':CEPCOBRANCA, ' +
                                  ':LIMITECREDITO, ' +
                                  ':MENSALISTA, ' +
                                  ':REGISTRODEBITOS) ');
                          ParamByName('codigo').AsInteger                   :=  iCodigo;
                          if Length(TiraPontos(BuscaCPFCNPJ(QOrigem.FieldByName('id_cliente').AsInteger, 0))) > 13 then
                            begin
                              ParamByName('tipo').AsString                    := '4';
                              ParamByName('tipopessoa').AsString              := 'J';
                            end
                          else
                            begin
                              ParamByName('tipo').AsString                    := '1';
                              ParamByName('tipopessoa').AsString              := 'F';
                            end;
                          ParamByName('nomefantasia').AsString                :=  QOrigem.FieldByName('nome').AsString;
                          ParamByName('razaosocial').AsString                 :=  QOrigem.FieldByName('nome').AsString;
                          ParamByName('cnpj').AsString                        :=  BuscaCPFCNPJ(QOrigem.FieldByName('id_cliente').AsInteger, 0);
                          ParamByName('inscricaoestadual').AsString           :=  BuscaCPFCNPJ(QOrigem.FieldByName('id_cliente').AsInteger, 1);
                          ParamByName('logradouroresidencial').AsString       :=  QOrigem.FieldByName('end_lograd').AsString;
                          ParamByName('numerolocalresidencial').AsString      :=  QOrigem.FieldByName('end_numero').AsString;
                          ParamByName('complementoresidencial').AsString      :=  QOrigem.FieldByName('end_comple').AsString;
                          ParamByName('bairroresidencial').AsString           :=  QOrigem.FieldByName('end_bairro').AsString;
                          ParamByName('cidaderesidencial').AsString           :=  BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 0);
                          ParamByName('ufresidencial').AsString               :=  BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 1);
                          //Buscar CEP ou Cadastrar CEP
                          BuscaCepDestino(QOrigem.FieldByName('end_cep').AsString, QOrigem.FieldByName('end_lograd').AsString,
                          QOrigem.FieldByName('end_bairro').AsString, BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 0),
                          QOrigem.FieldByName('id_cidade').AsString, BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 1),
                          Copy(QOrigem.FieldByName('id_cidade').AsString, 1, 2), '1058');
                          //Fim - Busca CEP
                          ParamByName('cepresidencial').AsString              :=  QOrigem.FieldByName('end_cep').AsString;
                          ParamByName('pontoreferenciaresidencial').Value     :=  Null;
                          ParamByName('contatoresidencial').Value             :=  Null;
                          ParamByName('emailresidencial').Value               :=  Null;
                          ParamByName('telefoneresidencial').AsString         :=  QOrigem.FieldByName('fone_resid').AsString;
                          ParamByName('faxresidencial').AsString              :=  QOrigem.FieldByName('fone_fax').AsString;
                          ParamByName('celularresidencial').AsString          :=  QOrigem.FieldByName('fone_celul').AsString;
                          ParamByName('observacoes').Value                    :=  Null;
                          ParamByName('bloqueado').AsString                   :=  'N';
                          ParamByName('usuario').AsInteger                    :=  1;
                          ParamByName('cadastro').AsDate                      :=  Now;
                          ParamByName('alteracao').AsDate                     :=  Now;
                          ParamByName('numeroestacao').AsInteger              :=  1;
                          ParamByName('ESTADOCIVIL').AsString                 :=  'I';
                          ParamByName('SEXO').AsString                        :=  'I';
                          ParamByName('UFENTREGA').AsString                   :=  BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 1);
                          ParamByName('CEPENTREGA').AsString                  :=  QOrigem.FieldByName('end_cep').AsString;
                          ParamByName('UFCOBRANCA').AsString                  :=  BuscaCidadeUF(QOrigem.FieldByName('id_cidade').AsString, 1);
                          ParamByName('CEPCOBRANCA').AsString                 :=  QOrigem.FieldByName('end_cep').AsString;
                          ParamByName('LIMITECREDITO').AsString               :=  'N';
                          ParamByName('MENSALISTA').AsString                  :=  'N';
                          ParamByName('REGISTRODEBITOS').AsString             :=  'N';
                          ExecSQL;
                        end;
                      I :=  I + 1;
                      lblCliImpor.Caption :=  IntToStr(I);
                      lblCliImpor.Refresh;
                      ProximoProgresso;
                      iCodigo :=  iCodigo + 1;
                      QOrigem.Next;
                    end;
                  MenssagemStat('Importação de Cliente Concluida..', True);
                end;
            end;
          //Fim - Importar Clientes

          //Importar Produtos
          MenssagemStat('Importando Produtos...', True);
          with dm.QOrigem do
            begin
              Close;
              sql.Clear;
              sql.Add(
                      'select ' +
                      'e.id_estoque, ' +
                      'e.descricao, ' +
                      'e.prc_venda, ' +
                      'e.prc_custo, ' +
                      'e.uni_medida, ' +
                      'e.cfop, ' +
                      'p.cod_barra, ' +
                      'p.referencia, ' +
                      'p.qtd_atual, ' +
                      'p.cod_ncm, ' +
                      'p.cod_cest, ' +
                      'p.csosn, ' +
                      'p.cst, ' +
                      'p.ippt, ' +
                      'p.iat, ' +
                      'p.qtd_minim ' +
                      'from tb_estoque e ' +
                      'inner join tb_est_identificador i on (e.id_estoque = i.id_estoque) ' +
                      'inner join tb_est_produto p on (i.id_identificador = p.id_identificador) ');
              Open;
            end;
          if dm.QOrigem.IsEmpty then
            MenssagemStat('Não Encontrados Produtos...', True)
          else
            begin
              with  dm  do
                begin
                  MenssagemStat('Criando Classificação Fiscal...', True);
                  CriarCassificacao; //1: Tributado 2: Substituição
                  I :=  0;
                  iCodigo :=  ProximoID('produtos', 'codigo');
                  lblTodosPro.Caption :=  IntToStr(QOrigem.RecordCount);
                  lblTodosPro.Refresh;
                  IniciarProgresso(QOrigem.RecordCount);
                  QOrigem.First;
                  while not QOrigem.Eof do
                    begin
                      with QDestino do
                        begin
                          //Produtos
                          MenssagemStat('Importando Produtos...', True);
                          close;
                          sql.Clear;
                          sql.Add(
                                  'insert into produtos ( ' +
                                  'codigo, ' +
                                  'codigobarras, ' +
                                  'ippt, ' +
                                  'iat, ' +
                                  'descricao, ' +
                                  'grupo, ' +
                                  'subgrupo, ' +
                                  'classificacaofiscal, ' +
                                  'ncm, ' +
                                  'quantidademultipla, ' +
                                  'estoqueminimo, ' +
                                  'estoquemaximo, ' +
                                  'pesoliquido, ' +
                                  'pesobruto, ' +
                                  'tipolancamento, ' +
                                  'montado, ' +
                                  'brinde, ' +
                                  'fracionado, ' +
                                  'inventariado, ' +
                                  'complementado, ' +
                                  'serial, ' +
                                  'bloqueado, ' +
                                  'usuario, ' +
                                  'cadastro, ' +
                                  'alteracao, ' +
                                  'numeroestacao) ' +
                                  'values ( ' +
                                  ':codigo, ' +
                                  ':codigobarras, ' +
                                  ':ippt, ' +
                                  ':iat, ' +
                                  ':descricao, ' +
                                  ':grupo, ' +
                                  ':subgrupo, ' +
                                  ':classificacaofiscal, ' +
                                  ':ncm, ' +
                                  ':quantidademultipla, ' +
                                  ':estoqueminimo, ' +
                                  ':estoquemaximo, ' +
                                  ':pesoliquido, ' +
                                  ':pesobruto, ' +
                                  ':tipolancamento, ' +
                                  ':montado, ' +
                                  ':brinde, ' +
                                  ':fracionado, ' +
                                  ':inventariado, ' +
                                  ':complementado, ' +
                                  ':serial, ' +
                                  ':bloqueado, ' +
                                  ':usuario, ' +
                                  ':cadastro, ' +
                                  ':alteracao, ' +
                                  ':numeroestacao) ');
                          ParamByName('codigo').AsInteger               :=  iCodigo;
                          ParamByName('codigobarras').AsString          :=  QOrigem.FieldByName('cod_barra').AsString;
                          ParamByName('ippt').AsString                  :=  QOrigem.FieldByName('ippt').AsString;
                          ParamByName('iat').AsString                   :=  QOrigem.FieldByName('iat').AsString;
                          ParamByName('descricao').AsString             :=  QOrigem.FieldByName('descricao').AsString;
                          ParamByName('grupo').AsInteger                :=  1;
                          ParamByName('subgrupo').AsInteger             :=  1;
                          if QOrigem.FieldByName('descricao').AsString = '5405' then
                            ParamByName('classificacaofiscal').AsInteger:=  2
                          else
                            ParamByName('classificacaofiscal').AsInteger:=  1;
                          ParamByName('ncm').AsString                   :=  QOrigem.FieldByName('cod_ncm').AsString;
                          ParamByName('quantidademultipla').AsFloat     :=  1;
                          ParamByName('estoqueminimo').AsFloat          :=  QOrigem.FieldByName('qtd_minim').AsFloat;
                          ParamByName('estoquemaximo').AsFloat          :=  100;
                          ParamByName('pesoliquido').AsFloat            :=  0;
                          ParamByName('pesobruto').AsFloat              :=  0;
                          ParamByName('tipolancamento').AsString        :=  'M';
                          ParamByName('montado').AsString               :=  'N';
                          ParamByName('brinde').AsString                :=  'N';
                          ParamByName('fracionado').AsString            :=  'N';
                          ParamByName('inventariado').AsString          :=  'S';
                          ParamByName('complementado').AsString         :=  'N';
                          ParamByName('serial').AsString                :=  'N';
                          ParamByName('bloqueado').AsString             :=  'N';
                          ParamByName('usuario').AsInteger              :=  1;
                          ParamByName('cadastro').AsDate                :=  Now;
                          ParamByName('alteracao').AsDate               :=  Now;
                          ParamByName('numeroestacao').AsInteger        :=  1;
                          ExecSQL;
                          with QAuxDestino do
                            begin
                              //Derivações
                              MenssagemStat('Criando Derivação...', True);
                              close;
                              sql.Clear;
                              sql.Add(
                                      'insert into derivacoes ( ' +
                                      'codigo, ' +
                                      'produto, ' +
                                      'unidademedida, ' +
                                      'descricao, ' +
                                      'codigobarras, ' +
                                      'bloqueado, ' +
                                      'usuario, ' +
                                      'alteracao, ' +
                                      'numeroestacao) ' +
                                      'values ( ' +
                                      ':codigo, ' +
                                      ':produto, ' +
                                      ':unidademedida, ' +
                                      ':descricao, ' +
                                      ':codigobarras, ' +
                                      ':bloqueado, ' +
                                      ':usuario, ' +
                                      ':alteracao, ' +
                                      ':numeroestacao) ');
                              ParamByName('codigo').AsString             := 'U';
                              ParamByName('produto').AsInteger           := iCodigo;
                              ParamByName('unidademedida').AsString      := QOrigem.FieldByName('uni_medida').AsString;
                              ParamByName('descricao').AsString          := 'U';
                              ParamByName('codigobarras').AsString       := QOrigem.FieldByName('cod_barra').AsString;
                              ParamByName('bloqueado').AsString          := 'N';
                              ParamByName('usuario').AsInteger           := 1;
                              ParamByName('alteracao').AsDate            := Now;
                              ParamByName('numeroestacao').AsInteger     := 1;
                              ExecSQL;

                              //Preco Compra
                              MenssagemStat('Criando Preço Compra...', True);
                              close;
                              sql.Clear;
                              sql.Add(
                                      'insert into itensprecoscompras ( ' +
                                      'codigo, ' +
                                      'preco, ' +
                                      'produto, ' +
                                      'derivacao, ' +
                                      'descricao, ' +
                                      'precofornecedor, ' +
                                      'precocompra, ' +
                                      'precomedio, ' +
                                      'usuario, ' +
                                      'alteracao, ' +
                                      'numeroestacao) ' +
                                      'values ( ' +
                                      ':codigo, ' +
                                      ':preco, ' +
                                      ':produto, ' +
                                      ':derivacao, ' +
                                      ':descricao, ' +
                                      ':precofornecedor, ' +
                                      ':precocompra, ' +
                                      ':precomedio, ' +
                                      ':usuario, ' +
                                      ':alteracao, ' +
                                      ':numeroestacao) ');
                              ParamByName('codigo').AsInteger              := ProximoID('itensprecoscompras', 'codigo');
                              ParamByName('preco').AsInteger               := 1;
                              ParamByName('produto').AsInteger             := iCodigo;
                              ParamByName('derivacao').AsString            := 'U';
                              ParamByName('descricao').AsString            := '-';
                              ParamByName('precofornecedor').AsFloat       := QOrigem.FieldByName('prc_custo').AsFloat;
                              ParamByName('precocompra').AsFloat           := QOrigem.FieldByName('prc_custo').AsFloat;
                              ParamByName('precomedio').AsFloat            := QOrigem.FieldByName('prc_custo').AsFloat;
                              ParamByName('usuario').AsInteger             := 1;
                              ParamByName('alteracao').AsDate              := Now;
                              ParamByName('numeroestacao').AsInteger       := 1;
                              ExecSQL;

                              //Preco Venda
                              MenssagemStat('Criando Preço Venda...', True);
                              close;
                              sql.Clear;
                              sql.Add(
                                      'insert into itensprecosvendas ( ' +
                                      'codigo, ' +
                                      'preco, ' +
                                      'produto, ' +
                                      'derivacao, ' +
                                      'descricao, ' +
                                      'percentuallucro, ' +
                                      'precominimo, ' +
                                      'preconormal, ' +
                                      'usuario, ' +
                                      'alteracao, ' +
                                      'numeroestacao) ' +
                                      'values ( ' +
                                      ':codigo, ' +
                                      ':preco, ' +
                                      ':produto, ' +
                                      ':derivacao, ' +
                                      ':descricao, ' +
                                      ':percentuallucro, ' +
                                      ':precominimo, ' +
                                      ':preconormal, ' +
                                      ':usuario, ' +
                                      ':alteracao, ' +
                                      ':numeroestacao) ');
                              ParamByName('codigo').AsInteger              := ProximoID('itensprecosvendas', 'codigo');
                              ParamByName('preco').AsInteger               := 1;
                              ParamByName('produto').AsInteger             := iCodigo;
                              ParamByName('derivacao').AsString            := 'U';
                              ParamByName('descricao').AsString            := '-';
                              ParamByName('percentuallucro').AsFloat       := 0;
                              ParamByName('precominimo').AsFloat           := 0;
                              ParamByName('preconormal').AsFloat            := QOrigem.FieldByName('prc_venda').AsFloat;
                              ParamByName('usuario').AsInteger             := 1;
                              ParamByName('alteracao').AsDate              := Now;
                              ParamByName('numeroestacao').AsInteger       := 1;
                              ExecSQL;

                              //Estoque
                              MenssagemStat('Atualizando Estoque...', True);
                              close;
                              sql.Clear;
                              sql.Add('update estoques set quantidade = :qtd where (produto = :pro)');
                              ParamByName('qtd').AsFloat   := QOrigem.FieldByName('qtd_atual').AsFloat;
                              ParamByName('pro').AsInteger := iCodigo;
                              ExecSQL;
                            end;
                        end;
                      I :=  I + 1;
                      lblProImpor.Caption :=  IntToStr(I);
                      lblProImpor.Refresh;
                      ProximoProgresso;
                      iCodigo :=  iCodigo + 1;
                      QOrigem.Next;
                    end;
                end
            end;
          MenssagemStat('Importação de Produtos Concluida..', True);
          //Fim - Importar Produtos

          //Fim da Conversão
          MenssagemStat('Conversão Concluida! Aguarde 10 seg.', True);
          BlockInput(True);
          Sleep(10000);
          BlockInput(False);
          Limpar;
          ZeraContador;
          MenssagemStat('', False);
        except
          on E: exception do
            begin
              ShowMessage('Foi Encontrado um problema na Conversão.'+#13+'Erro:'+#13+E.Message);
              MenssagemStat('',False);
              ZeraContador;
            end;
        end;
      end;
  end;
end;

procedure TfrmConversor.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConversor.BuscaCepDestino(cep, logradouro, bairro, cidade, cidadeibge, uf, ufibge, paisibge: string);
begin
  with dm.QAuxDestino do
    begin
      close;
      sql.Clear;
      sql.Add('select * from ufs where codigo = :uf');
      ParamByName('uf').AsString :=  uf;
      Open;
      if IsEmpty then
        begin
          close;
          sql.Clear;
          sql.Add(
                  'insert into UFS ( ' +
                  'CODIGO, ' +
                  'DESCRICAO, ' +
                  'BLOQUEADO, ' +
                  'USUARIO, ' +
                  'ALTERACAO, ' +
                  'NUMEROESTACAO) ' +
                  'values ( ' +
                  ':CODIGO, ' +
                  ':DESCRICAO, ' +
                  ':BLOQUEADO, ' +
                  ':USUARIO, ' +
                  ':ALTERACAO, ' +
                  ':NUMEROESTACAO) ');
          ParamByName('CODIGO').AsString          :=  uf;
          ParamByName('DESCRICAO').AsString       :=  uf;
          ParamByName('BLOQUEADO').AsString       :=  'N';
          ParamByName('USUARIO').AsInteger        :=  1;
          ParamByName('ALTERACAO').AsDate         :=  Now;
          ParamByName('NUMEROESTACAO').AsInteger  :=  1;
          ExecSQL;
        end;

      close;
      sql.Clear;
      sql.Add('select * from ceps where codigo = :cep');
      ParamByName('cep').AsString :=  cep;
      Open;
      if IsEmpty then
        begin
          close;
          sql.Clear;
          sql.Add(
                  'insert into CEPS ( ' +
                  'CODIGO, ' +
                  'LOGRADOURO, ' +
                  'BAIRRO, ' +
                  'CIDADE, ' +
                  'CIDADEIBGE, ' +
                  'UF, ' +
                  'UFIBGE, ' +
                  'PAISIBGE) ' +
                  'values ( ' +
                  ':CODIGO, ' +
                  ':LOGRADOURO, ' +
                  ':BAIRRO, ' +
                  ':CIDADE, ' +
                  ':CIDADEIBGE, ' +
                  ':UF, ' +
                  ':UFIBGE, ' +
                  ':PAISIBGE) ');
          ParamByName('CODIGO').AsString       := cep;
          ParamByName('LOGRADOURO').AsString   := logradouro;
          ParamByName('BAIRRO').AsString       := bairro;
          ParamByName('CIDADE').AsString       := cidade;
          ParamByName('CIDADEIBGE').AsString   := cidadeibge;
          ParamByName('UF').AsString           := uf;
          ParamByName('UFIBGE').AsString       := ufibge;
          ParamByName('PAISIBGE').AsString     := paisibge;
          ExecSQL;
        end;
    end;
end;

procedure TfrmConversor.cbusarPadraoDesClick(Sender: TObject);
begin
  if cbusarPadraoDes.Checked then
    begin
      edtUsuarioDes.Text := 'sysdba';
      edtSenhaDes.Text   := 'masterkey';
      edtServerDes.Text  := '127.0.0.1';
      edtPortaDes.Text   := '3050';
    end
  else
    begin
      edtUsuarioDes.Clear;
      edtSenhaDes.Clear;
      edtServerDes.Clear;
      edtPortaDes.Clear;
    end;
end;

procedure TfrmConversor.cbusarPadraoOriClick(Sender: TObject);
begin
  if cbusarPadraoOri.Checked then
    begin
      edtUsuarioOri.Text := 'sysdba';
      edtSenhaOri.Text   := 'masterkey';
      edtServerOri.Text  := '127.0.0.1';
      edtPortaOri.Text   := '3050';
    end
  else
    begin
      edtUsuarioOri.Clear;
      edtSenhaOri.Clear;
      edtServerOri.Clear;
      edtPortaOri.Clear;
    end;
end;

procedure TfrmConversor.CriarCassificacao;
begin
  try
    with dm.QAuxDestino do
      begin
        close;
        sql.Clear;
        sql.Add('delete from PRODUTOS');
        ExecSQL;

        close;
        sql.Clear;
        sql.Add('delete from ITENSCLASSIFICACOESFISCAIS');
        ExecSQL;

        close;
        sql.Clear;
        sql.Add('delete from CLASSIFICACOESFISCAIS');
        ExecSQL;

        close;
        sql.Clear;
        sql.Add(
                'insert into CLASSIFICACOESFISCAIS ( ' +
                'CODIGO, ' +
                'DESCRICAO, ' +
                'BLOQUEADO, ' +
                'USUARIO, ' +
                'ALTERACAO, ' +
                'NUMEROESTACAO) ' +
                'values ( ' +
                ':CODIGO, ' +
                ':DESCRICAO, ' +
                ':BLOQUEADO, ' +
                ':USUARIO, ' +
                ':ALTERACAO, ' +
                ':NUMEROESTACAO) ');
        ParamByName('CODIGO').AsInteger        := ProximoID('CLASSIFICACOESFISCAIS', 'CODIGO');
        ParamByName('DESCRICAO').AsString      := 'TRIBUTADO INTEGRALMENTE';
        ParamByName('BLOQUEADO').AsString      := 'N';
        ParamByName('USUARIO').AsInteger       := 1;
        ParamByName('ALTERACAO').AsDate        := Now;
        ParamByName('NUMEROESTACAO').AsInteger := 1;
        ExecSQL;

        close;
        sql.Clear;
        sql.Add(
                'insert into CLASSIFICACOESFISCAIS ( ' +
                'CODIGO, ' +
                'DESCRICAO, ' +
                'BLOQUEADO, ' +
                'USUARIO, ' +
                'ALTERACAO, ' +
                'NUMEROESTACAO) ' +
                'values ( ' +
                ':CODIGO, ' +
                ':DESCRICAO, ' +
                ':BLOQUEADO, ' +
                ':USUARIO, ' +
                ':ALTERACAO, ' +
                ':NUMEROESTACAO) ');
        ParamByName('CODIGO').AsInteger        := ProximoID('CLASSIFICACOESFISCAIS', 'CODIGO');
        ParamByName('DESCRICAO').AsString      := 'SUBSTITUIÇÃO TRIBUTÁRIA';
        ParamByName('BLOQUEADO').AsString      := 'N';
        ParamByName('USUARIO').AsInteger       := 1;
        ParamByName('ALTERACAO').AsDate        := Now;
        ParamByName('NUMEROESTACAO').AsInteger := 1;
        ExecSQL;

        close;
        sql.Clear;
        sql.Add(
                'insert into ITENSCLASSIFICACOESFISCAIS ( ' +
                'CODIGO, ' +
                'CLASSIFICACAOFISCAL, ' +
                'TIPO, ' +
                'UF, ' +
                'CFOP, ' +
                'MENSAGEM, ' +
                'CST, ' +
                'PERCENTUALICMS, ' +
                'PERCENTUALRBCICMS, ' +
                'PERCENTUALICMSST, ' +
                'PERCENTUALRBCICMSST, ' +
                'PERCENTUALIPI, ' +
                'PERCENTUALRBCIPI, ' +
                'ITECF, ' +
                'ITECFN, ' +
                'CFOPISS, ' +
                'PERCENTUALISS, ' +
                'PERCENTUALRBCISS, ' +
                'ITECFISS, ' +
                'ITECFNISS, ' +
                'CSOSN, ' +
                'USUARIO, ' +
                'ALTERACAO, ' +
                'NUMEROESTACAO, ' +
                'PERCENTUALIBPTFED, ' +
                'PERCENTUALIBPTEST) ' +
                'values ( ' +
                ':CODIGO, ' +
                ':CLASSIFICACAOFISCAL, ' +
                ':TIPO, ' +
                ':UF, ' +
                ':CFOP, ' +
                ':MENSAGEM, ' +
                ':CST, ' +
                ':PERCENTUALICMS, ' +
                ':PERCENTUALRBCICMS, ' +
                ':PERCENTUALICMSST, ' +
                ':PERCENTUALRBCICMSST, ' +
                ':PERCENTUALIPI, ' +
                ':PERCENTUALRBCIPI, ' +
                ':ITECF, ' +
                ':ITECFN, ' +
                ':CFOPISS, ' +
                ':PERCENTUALISS, ' +
                ':PERCENTUALRBCISS, ' +
                ':ITECFISS, ' +
                ':ITECFNISS, ' +
                ':CSOSN, ' +
                ':USUARIO, ' +
                ':ALTERACAO, ' +
                ':NUMEROESTACAO, ' +
                ':PERCENTUALIBPTFED, ' +
                ':PERCENTUALIBPTEST) ');
        ParamByName('CODIGO').AsInteger                 :=  ProximoID('ITENSCLASSIFICACOESFISCAIS', 'CODIGO');
        ParamByName('CLASSIFICACAOFISCAL').AsInteger    :=  1;
        ParamByName('TIPO').AsString                    :=  'S';
        ParamByName('UF').AsString                      :=  'ES';
        ParamByName('CFOP').AsInteger                   :=  5102;
        ParamByName('MENSAGEM').Value                   :=  Null;
        ParamByName('CST').AsString                     :=  '040';
        ParamByName('PERCENTUALICMS').AsFloat           :=  0;
        ParamByName('PERCENTUALRBCICMS').AsFloat        :=  0;
        ParamByName('PERCENTUALICMSST').AsFloat         :=  0;
        ParamByName('PERCENTUALRBCICMSST').AsFloat      :=  0;
        ParamByName('PERCENTUALIPI').AsFloat            :=  0;
        ParamByName('PERCENTUALRBCIPI').AsFloat         :=  0;
        ParamByName('ITECF').AsString                   :=  'T';
        ParamByName('ITECFN').AsString                  :=  '00';
        ParamByName('CFOPISS').AsInteger                :=  5102;
        ParamByName('PERCENTUALISS').AsFloat            :=  0;
        ParamByName('PERCENTUALRBCISS').AsFloat         :=  0;
        ParamByName('ITECFISS').AsString                :=  'T';
        ParamByName('ITECFNISS').AsString               :=  '00';
        ParamByName('CSOSN').AsString                   :=  '102';
        ParamByName('USUARIO').AsInteger                :=  1;
        ParamByName('ALTERACAO').AsDate                 :=  Now;
        ParamByName('NUMEROESTACAO').AsInteger          :=  1;
        ParamByName('PERCENTUALIBPTFED').AsFloat        :=  0;
        ParamByName('PERCENTUALIBPTEST').AsFloat        :=  0;
        ExecSQL;

        close;
        sql.Clear;
        sql.Add(
                'insert into ITENSCLASSIFICACOESFISCAIS ( ' +
                'CODIGO, ' +
                'CLASSIFICACAOFISCAL, ' +
                'TIPO, ' +
                'UF, ' +
                'CFOP, ' +
                'MENSAGEM, ' +
                'CST, ' +
                'PERCENTUALICMS, ' +
                'PERCENTUALRBCICMS, ' +
                'PERCENTUALICMSST, ' +
                'PERCENTUALRBCICMSST, ' +
                'PERCENTUALIPI, ' +
                'PERCENTUALRBCIPI, ' +
                'ITECF, ' +
                'ITECFN, ' +
                'CFOPISS, ' +
                'PERCENTUALISS, ' +
                'PERCENTUALRBCISS, ' +
                'ITECFISS, ' +
                'ITECFNISS, ' +
                'CSOSN, ' +
                'USUARIO, ' +
                'ALTERACAO, ' +
                'NUMEROESTACAO, ' +
                'PERCENTUALIBPTFED, ' +
                'PERCENTUALIBPTEST) ' +
                'values ( ' +
                ':CODIGO, ' +
                ':CLASSIFICACAOFISCAL, ' +
                ':TIPO, ' +
                ':UF, ' +
                ':CFOP, ' +
                ':MENSAGEM, ' +
                ':CST, ' +
                ':PERCENTUALICMS, ' +
                ':PERCENTUALRBCICMS, ' +
                ':PERCENTUALICMSST, ' +
                ':PERCENTUALRBCICMSST, ' +
                ':PERCENTUALIPI, ' +
                ':PERCENTUALRBCIPI, ' +
                ':ITECF, ' +
                ':ITECFN, ' +
                ':CFOPISS, ' +
                ':PERCENTUALISS, ' +
                ':PERCENTUALRBCISS, ' +
                ':ITECFISS, ' +
                ':ITECFNISS, ' +
                ':CSOSN, ' +
                ':USUARIO, ' +
                ':ALTERACAO, ' +
                ':NUMEROESTACAO, ' +
                ':PERCENTUALIBPTFED, ' +
                ':PERCENTUALIBPTEST) ');
        ParamByName('CODIGO').AsInteger                 :=  ProximoID('ITENSCLASSIFICACOESFISCAIS', 'CODIGO');
        ParamByName('CLASSIFICACAOFISCAL').AsInteger    :=  2;
        ParamByName('TIPO').AsString                    :=  'S';
        ParamByName('UF').AsString                      :=  'ES';
        ParamByName('CFOP').AsInteger                   :=  5405;
        ParamByName('MENSAGEM').Value                   :=  Null;
        ParamByName('CST').AsString                     :=  '060';
        ParamByName('PERCENTUALICMS').AsFloat           :=  0;
        ParamByName('PERCENTUALRBCICMS').AsFloat        :=  0;
        ParamByName('PERCENTUALICMSST').AsFloat         :=  0;
        ParamByName('PERCENTUALRBCICMSST').AsFloat      :=  0;
        ParamByName('PERCENTUALIPI').AsFloat            :=  0;
        ParamByName('PERCENTUALRBCIPI').AsFloat         :=  0;
        ParamByName('ITECF').AsString                   :=  'F';
        ParamByName('ITECFN').AsString                  :=  '00';
        ParamByName('CFOPISS').AsInteger                :=  5405;
        ParamByName('PERCENTUALISS').AsFloat            :=  0;
        ParamByName('PERCENTUALRBCISS').AsFloat         :=  0;
        ParamByName('ITECFISS').AsString                :=  'F';
        ParamByName('ITECFNISS').AsString               :=  '00';
        ParamByName('CSOSN').AsString                   :=  '500';
        ParamByName('USUARIO').AsInteger                :=  1;
        ParamByName('ALTERACAO').AsDate                 :=  Now;
        ParamByName('NUMEROESTACAO').AsInteger          :=  1;
        ParamByName('PERCENTUALIBPTFED').AsFloat        :=  0;
        ParamByName('PERCENTUALIBPTEST').AsFloat        :=  0;
        ExecSQL;
      end;
  except
    on E: exception do
      ShowMessage('Não Foi Possivel Criar a Classificação Fiscal'+#13+'Erro: '+#13+E.Message);
  end;
end;

procedure TfrmConversor.dbtPesquisarClick(Sender: TObject);
begin
  with dm do
    begin
      OpenDialog1.Title := 'Selecione a FDB';
      OpenDialog1.DefaultExt := '*.FDB';
      OpenDialog1.Filter := 'Arquivos FDB (*.FDB)|*.FDB|Arquivos FDB (*.FDB)|*.FDB|Todos os Arquivos (*.*)|*.*';
      OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);;
      if OpenDialog1.Execute then
      begin
        edtCaminhoOri.Text  :=  OpenDialog1.FileName;
      end;
    end;
end;

procedure TfrmConversor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

procedure TfrmConversor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Application.MessageBox('Deseja realmente Sair do Programa?', 'Conversor Evoluir', MB_YESNO + MB_ICONQUESTION) = IDNO then
    abort;
end;

procedure TfrmConversor.Habilitar(Tipo: Boolean);
begin
  gbOrigem.Enabled  :=  Tipo;
  gbDestino.Enabled :=  Tipo;
  btnConverter.Enabled  :=  Tipo;
end;

procedure TfrmConversor.IniciarProgresso(Max: integer);
begin
  Progress.Visible  :=  True;
  Progress.Min  :=  0;
  Progress.Max  :=  Max;
  Progress.Position :=  0;  
end;

procedure TfrmConversor.Limpar;
begin
  edtCaminhoOri.Clear;
  edtUsuarioOri.Clear;
  edtSenhaOri.Clear;
  edtServerOri.Clear;
  edtPortaOri.Clear;
  edtCaminhoDes.Clear;
  edtUsuarioDes.Clear;
  edtSenhaDes.Clear;
  edtServerDes.Clear;
  edtPortaDes.Clear;
  cbusarPadraoOri.Checked :=  False;
  cbusarPadraoDes.Checked :=  False;
  ZeraContador;
  rgSistemas.ItemIndex  :=  -1;
  dm.ConOrigem.Connected  :=  False;
  dm.ConDestino.Connected :=  False;
  Progress.Visible  :=  False;
end;

procedure TfrmConversor.MenssagemStat(Texto: string; Mostrar: Boolean);
begin
  pnlMensagem.Visible :=  Mostrar;
  if Mostrar then
    begin
      pnlMensagem.Caption :=  Texto;
      pnlMensagem.Refresh;
    end;
end;

function TfrmConversor.ProximoID(Tabela, Campo: string): Integer;
var
  con: TFDConnection;
  qry: TFDQuery;
begin
  try
    con :=  TFDConnection.Create(nil);
    con.Params.Assign(dm.ConDestino.Params);
    con.LoginPrompt :=  False;
    con.Connected :=  True;
    qry :=  TFDQuery.Create(nil);
    qry.Connection  :=  con;
    try
      with qry do
        begin
          Close;
          sql.Clear;
          sql.Add('SELECT MAX('+Campo+') AS ID FROM '+Tabela);
          Open;
        end;
      if qry.IsEmpty then
        Result  :=  1
      else
        Result  :=  qry.FieldByName('ID').AsInteger + 1;
    finally
      qry.Close;
      qry.Free;
      con.Free;
    end;          
  except
    qry.Close;
    qry.Free;
    con.Free;
  end;
end;

procedure TfrmConversor.ProximoProgresso;
begin
  if Progress.Position < Progress.Max then    
    Progress.Position :=  Progress.Position + 1
  else if Progress.Position = Progress.Max then
    begin
      MenssagemStat('Progresso Concluido...', True);
      Progress.Visible  := False;
    end;
end;

procedure TfrmConversor.rgSistemasClick(Sender: TObject);
begin
  Habilitar(True);
end;

procedure TfrmConversor.SpeedButton1Click(Sender: TObject);
begin
  with dm do
    begin
      OpenDialog1.Title := 'Selecione a FDB';
      OpenDialog1.DefaultExt := '*.FDB';
      OpenDialog1.Filter := 'Arquivos FDB (*.FDB)|*.FDB|Arquivos FDB (*.FDB)|*.FDB|Todos os Arquivos (*.*)|*.*';
      OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);;
      if OpenDialog1.Execute then
      begin
        edtCaminhoDes.Text  :=  OpenDialog1.FileName;
      end;
    end;
end;

procedure TfrmConversor.Status(Tipo, Status: string);
begin
  if Tipo = 'Origem' then
    begin
      if Status = 'Desconectado' then
        begin
          lblStatusOri.Caption  :=  Status;
          lblStatusOri.Font.Color :=  clRed;
        end
      else if Status = 'Conectado' then
        begin
          lblStatusOri.Caption  :=  Status;
          lblStatusOri.Font.Color :=  clGreen;
        end;
    end
  else if Tipo = 'Destino' then
    begin
      if Status = 'Desconectado' then
        begin
          lblStatusDes.Caption  :=  Status;
          lblStatusDes.Font.Color :=  clRed;
        end
      else if Status = 'Conectado' then
        begin
          lblStatusDes.Caption  :=  Status;
          lblStatusDes.Font.Color :=  clGreen;
        end;
    end;
end;

function TfrmConversor.TiraPontos(texto: String): String;
begin
  While pos('-', Texto) <> 0 Do
    delete(Texto,pos('-', Texto),1);

  While pos('.', Texto) <> 0 Do
    delete(Texto,pos('.', Texto),1);

  While pos('/', Texto) <> 0 Do
    delete(Texto,pos('/', Texto),1);

  While pos(',', Texto) <> 0 Do
    delete(Texto,pos(',', Texto),1);

  Result := Texto;
end;

procedure TfrmConversor.ZeraContador;
begin
  lblCliImpor.Caption :=  '000';
  lblProImpor.Caption :=  '000';
  lblTodosCli.Caption :=  '000';
  lblTodosPro.Caption :=  '000';
  lblCliImpor.Refresh;
  lblProImpor.Refresh;
  lblTodosCli.Refresh;
  lblTodosPro.Refresh;
end;

end.
