object DM: TDM
  OldCreateOrder = False
  Height = 220
  Width = 274
  object ConOrigem: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    AfterConnect = ConOrigemAfterConnect
    AfterDisconnect = ConOrigemAfterDisconnect
    Left = 24
    Top = 8
  end
  object ConDestino: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    AfterConnect = ConDestinoAfterConnect
    AfterDisconnect = ConDestinoAfterDisconnect
    Left = 24
    Top = 56
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*-nfe.XML'
    Filter = 
      'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|To' +
      'dos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 23
    Top = 102
  end
  object QOrigem: TFDQuery
    Connection = ConOrigem
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 80
    Top = 8
  end
  object QDestino: TFDQuery
    Connection = ConDestino
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 80
    Top = 56
  end
  object QAuxOrigem: TFDQuery
    Connection = ConOrigem
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 136
    Top = 8
  end
  object QAuxDestino: TFDQuery
    Connection = ConDestino
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 136
    Top = 56
  end
end
