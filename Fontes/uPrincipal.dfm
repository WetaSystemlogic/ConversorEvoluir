object frmConversor: TfrmConversor
  Left = 0
  Top = 0
  ActiveControl = btnFechar
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conversor de Banco de Dados Evoluir'
  ClientHeight = 377
  ClientWidth = 651
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 183
    Height = 328
    Align = alLeft
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object rgSistemas: TRadioGroup
      Left = 8
      Top = 8
      Width = 161
      Height = 169
      Caption = 'Sistemas'
      Items.Strings = (
        'CompuFour Software')
      TabOrder = 0
      OnClick = rgSistemasClick
    end
    object gbInfor: TGroupBox
      Left = 8
      Top = 183
      Width = 161
      Height = 137
      Caption = 'Informa'#231#245'es'
      TabOrder = 1
      object Label1: TLabel
        Left = 10
        Top = 16
        Width = 118
        Height = 13
        Caption = 'Clientes Importados:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCliImpor: TLabel
        Left = 16
        Top = 31
        Width = 18
        Height = 13
        Caption = '000'
      end
      object Label3: TLabel
        Left = 10
        Top = 46
        Width = 124
        Height = 13
        Caption = 'Produtos Importados:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblProImpor: TLabel
        Left = 16
        Top = 61
        Width = 18
        Height = 13
        Caption = '000'
      end
      object lblTodosPro: TLabel
        Left = 16
        Top = 120
        Width = 18
        Height = 13
        Caption = '000'
      end
      object Label4: TLabel
        Left = 10
        Top = 105
        Width = 86
        Height = 13
        Caption = 'Total Produtos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTodosCli: TLabel
        Left = 16
        Top = 90
        Width = 18
        Height = 13
        Caption = '000'
      end
      object Label18: TLabel
        Left = 10
        Top = 75
        Width = 74
        Height = 13
        Caption = 'Total Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 328
    Width = 651
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object btnFechar: TButton
      Left = 565
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnConverter: TButton
      Left = 8
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Converter'
      Enabled = False
      TabOrder = 1
      OnClick = btnConverterClick
    end
    object Progress: TProgressBar
      Left = 0
      Top = 32
      Width = 651
      Height = 17
      Align = alBottom
      TabOrder = 2
    end
    object pnlMensagem: TPanel
      Left = 123
      Top = 3
      Width = 404
      Height = 24
      BevelOuter = bvNone
      Caption = 'Mensagem'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
  end
  object Panel3: TPanel
    Left = 183
    Top = 0
    Width = 468
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 2
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 468
      Height = 160
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object gbOrigem: TGroupBox
        Left = 6
        Top = 8
        Width = 451
        Height = 145
        Caption = 'Origem'
        Enabled = False
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 19
          Width = 71
          Height = 13
          Caption = 'Caminho Base:'
        end
        object Label6: TLabel
          Left = 16
          Top = 57
          Width = 40
          Height = 13
          Caption = 'Usuario:'
        end
        object Label7: TLabel
          Left = 16
          Top = 95
          Width = 34
          Height = 13
          Caption = 'Senha:'
        end
        object Label8: TLabel
          Left = 153
          Top = 57
          Width = 36
          Height = 13
          Caption = 'Server:'
        end
        object Label9: TLabel
          Left = 153
          Top = 95
          Width = 30
          Height = 13
          Caption = 'Porta:'
        end
        object dbtPesquisar: TSpeedButton
          Left = 274
          Top = 34
          Width = 23
          Height = 21
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFEDEDEDDBDBDBD3D3D3D0D0D0CFCFCFCFCFCFD0D0D0D2D2D2DCDCDCEDED
            EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDD3D3D3E5E5E5E3E3E3E2E2E2E3
            E4E3E3E4E4E2E2E2E3E3E3E5E5E5D1D1D1DCDCDCFFFFFFFFFFFFFFFFFFE0E0E0
            E2E2E2DCDCDCD7D7D7DADADBDDDDDDDEDFDEDEDEDEDDDDDDDBDCDDD8DBE0DCDC
            DCE3E3E3E0E0E0FFFFFFF5F5F5D1D1D1DDDDDDD9D9D9DEDEDEE2E2E2E6E7E9E8
            EAEEE7E8E9E6E7EAE1E1E1D8CEBBD9D9D9DDDDDED1D1D1F5F5F5E5E5E5E9E9E9
            D9D9D9DFDFDEE5E6E7EAEEF7E8E4E0E7DECFECEBECEBEEF6DBB771D69B23DCD2
            BEDADDE2E9E9E9E5E5E5E1E1E1E7E8E7DEDEDDE4E5E7E9EAEFDCBB7ED7A33DDA
            A844D9AA4CD9AD55D79819DFBA73E5E5E5DEDFE1E8E8E8E1E1E1E3E3E3E9E9E9
            E2E2E2E9ECF5DCBA74DDAC45F2E9D2F9F7EFF2E3C3DCA733DEB459EFF2FAE8EA
            ECE2E2E1E9E9E9E3E3E3E3E3E3EBEBEBE5E7EBE6DFCEDCAD3EF3F0E6FBFFFFFD
            FEFFFFFFFFF3E7C9DFB753F0EFEFEBECEDE5E5E5ECECECE4E4E4E6E6E6EDEDED
            E6E9F1E6D8B2E4C162F6FAFFFAFAFAFCFCFDFDFEFFF9F8F6E4BF57EEE8D7EDEE
            F2E6E6E6EEEDEDE5E5E5E5E5E5EEEEEEE7E8EDEAE2CDE5C45CF3F2F0F9FBFFFA
            FAFBFCFFFFF4EEDAE7C760F0EEE9ECEDEFE7E7E7EFEFEFE7E7E7E8E8E8F1F1F1
            E6E6E7ECEDF3EAD485EBD584F4F3EFF7F8FCF4F2E5EBD272EEDEA3F1F3FBEBEC
            ECE7E7E7F1F1F1E9E9E9F2F2F2F7F7F7E5E5E5EAEBEEEEEEEBEEDB91EDD679EE
            DB87EDD778F0E1A4F2F3F7EFEFF0EBEBEBE6E5E6F8F7F7F2F2F2FDFDFDE7E7E7
            EEEEEEE8E8E8ECEDF0F0F1F7F1EDDCF2EBCDF2EFE3F2F4FBF0F0F2EDEDEDE9E9
            E9EEEEEEE9E9E9FDFDFDFFFFFFF7F7F7FAFAFAF1F1F1EAEAEAEDEDEEF0F0F5F1
            F2F8F1F1F5EFEFF0EEEEEEEAEBEBF1F1F1FAFAFAF6F6F6FFFFFFFFFFFFFFFFFF
            F7F7F7F5F5F5FFFFFFFEFEFEFDFDFDFEFEFEFEFEFEFDFDFDFEFEFEFFFFFFF5F5
            F5F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBF8F8F8F5F5F5F5
            F5F5F5F5F5F5F5F5F8F8F8FCFCFCFDFDFDFFFFFFFFFFFFFFFFFF}
          OnClick = dbtPesquisarClick
        end
        object Label10: TLabel
          Left = 292
          Top = 75
          Width = 35
          Height = 13
          Caption = 'Status:'
        end
        object lblStatusOri: TLabel
          Left = 292
          Top = 90
          Width = 80
          Height = 13
          Caption = 'Desconectado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCaminhoOri: TEdit
          Left = 16
          Top = 34
          Width = 258
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 0
        end
        object edtUsuarioOri: TEdit
          Left = 16
          Top = 72
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtSenhaOri: TEdit
          Left = 16
          Top = 110
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtServerOri: TEdit
          Left = 153
          Top = 72
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object edtPortaOri: TEdit
          Left = 153
          Top = 110
          Width = 121
          Height = 21
          TabOrder = 4
        end
        object btnConectarOri: TButton
          Left = 355
          Top = 34
          Width = 75
          Height = 25
          Caption = 'Conectar'
          TabOrder = 5
          OnClick = btnConectarOriClick
        end
        object cbusarPadraoOri: TCheckBox
          Left = 292
          Top = 114
          Width = 156
          Height = 17
          Caption = 'Usar Configura'#231#245'es Padr'#227'o'
          TabOrder = 6
          OnClick = cbusarPadraoOriClick
        end
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 168
      Width = 468
      Height = 160
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object gbDestino: TGroupBox
        Left = 6
        Top = 9
        Width = 451
        Height = 145
        Caption = 'Destino'
        Enabled = False
        TabOrder = 0
        object Label11: TLabel
          Left = 16
          Top = 17
          Width = 71
          Height = 13
          Caption = 'Caminho Base:'
        end
        object Label12: TLabel
          Left = 16
          Top = 55
          Width = 40
          Height = 13
          Caption = 'Usuario:'
        end
        object Label13: TLabel
          Left = 16
          Top = 93
          Width = 34
          Height = 13
          Caption = 'Senha:'
        end
        object Label14: TLabel
          Left = 153
          Top = 93
          Width = 30
          Height = 13
          Caption = 'Porta:'
        end
        object Label15: TLabel
          Left = 153
          Top = 55
          Width = 36
          Height = 13
          Caption = 'Server:'
        end
        object SpeedButton1: TSpeedButton
          Left = 274
          Top = 32
          Width = 23
          Height = 21
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFEDEDEDDBDBDBD3D3D3D0D0D0CFCFCFCFCFCFD0D0D0D2D2D2DCDCDCEDED
            EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDD3D3D3E5E5E5E3E3E3E2E2E2E3
            E4E3E3E4E4E2E2E2E3E3E3E5E5E5D1D1D1DCDCDCFFFFFFFFFFFFFFFFFFE0E0E0
            E2E2E2DCDCDCD7D7D7DADADBDDDDDDDEDFDEDEDEDEDDDDDDDBDCDDD8DBE0DCDC
            DCE3E3E3E0E0E0FFFFFFF5F5F5D1D1D1DDDDDDD9D9D9DEDEDEE2E2E2E6E7E9E8
            EAEEE7E8E9E6E7EAE1E1E1D8CEBBD9D9D9DDDDDED1D1D1F5F5F5E5E5E5E9E9E9
            D9D9D9DFDFDEE5E6E7EAEEF7E8E4E0E7DECFECEBECEBEEF6DBB771D69B23DCD2
            BEDADDE2E9E9E9E5E5E5E1E1E1E7E8E7DEDEDDE4E5E7E9EAEFDCBB7ED7A33DDA
            A844D9AA4CD9AD55D79819DFBA73E5E5E5DEDFE1E8E8E8E1E1E1E3E3E3E9E9E9
            E2E2E2E9ECF5DCBA74DDAC45F2E9D2F9F7EFF2E3C3DCA733DEB459EFF2FAE8EA
            ECE2E2E1E9E9E9E3E3E3E3E3E3EBEBEBE5E7EBE6DFCEDCAD3EF3F0E6FBFFFFFD
            FEFFFFFFFFF3E7C9DFB753F0EFEFEBECEDE5E5E5ECECECE4E4E4E6E6E6EDEDED
            E6E9F1E6D8B2E4C162F6FAFFFAFAFAFCFCFDFDFEFFF9F8F6E4BF57EEE8D7EDEE
            F2E6E6E6EEEDEDE5E5E5E5E5E5EEEEEEE7E8EDEAE2CDE5C45CF3F2F0F9FBFFFA
            FAFBFCFFFFF4EEDAE7C760F0EEE9ECEDEFE7E7E7EFEFEFE7E7E7E8E8E8F1F1F1
            E6E6E7ECEDF3EAD485EBD584F4F3EFF7F8FCF4F2E5EBD272EEDEA3F1F3FBEBEC
            ECE7E7E7F1F1F1E9E9E9F2F2F2F7F7F7E5E5E5EAEBEEEEEEEBEEDB91EDD679EE
            DB87EDD778F0E1A4F2F3F7EFEFF0EBEBEBE6E5E6F8F7F7F2F2F2FDFDFDE7E7E7
            EEEEEEE8E8E8ECEDF0F0F1F7F1EDDCF2EBCDF2EFE3F2F4FBF0F0F2EDEDEDE9E9
            E9EEEEEEE9E9E9FDFDFDFFFFFFF7F7F7FAFAFAF1F1F1EAEAEAEDEDEEF0F0F5F1
            F2F8F1F1F5EFEFF0EEEEEEEAEBEBF1F1F1FAFAFAF6F6F6FFFFFFFFFFFFFFFFFF
            F7F7F7F5F5F5FFFFFFFEFEFEFDFDFDFEFEFEFEFEFEFDFDFDFEFEFEFFFFFFF5F5
            F5F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBF8F8F8F5F5F5F5
            F5F5F5F5F5F5F5F5F8F8F8FCFCFCFDFDFDFFFFFFFFFFFFFFFFFF}
          OnClick = SpeedButton1Click
        end
        object lblStatusDes: TLabel
          Left = 292
          Top = 88
          Width = 80
          Height = 13
          Caption = 'Desconectado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 292
          Top = 73
          Width = 35
          Height = 13
          Caption = 'Status:'
        end
        object edtCaminhoDes: TEdit
          Left = 16
          Top = 32
          Width = 258
          Height = 21
          TabOrder = 0
        end
        object edtUsuarioDes: TEdit
          Left = 16
          Top = 70
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtSenhaDes: TEdit
          Left = 16
          Top = 108
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtPortaDes: TEdit
          Left = 153
          Top = 108
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object edtServerDes: TEdit
          Left = 153
          Top = 70
          Width = 121
          Height = 21
          TabOrder = 4
        end
        object cbusarPadraoDes: TCheckBox
          Left = 287
          Top = 112
          Width = 156
          Height = 17
          Caption = 'Usar Configura'#231#245'es Padr'#227'o'
          TabOrder = 5
          OnClick = cbusarPadraoDesClick
        end
        object btnConectarDes: TButton
          Left = 355
          Top = 32
          Width = 75
          Height = 25
          Caption = 'Conectar'
          TabOrder = 6
          OnClick = btnConectarDesClick
        end
      end
    end
  end
end
