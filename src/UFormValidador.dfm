object FormValidador: TFormValidador
  Left = 0
  Top = 0
  Caption = 'Validador de CPF e CNPJ'
  ClientHeight = 304
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object TlblStatus: TLabel
    Left = 8
    Top = 144
    Width = 32
    Height = 15
    Alignment = taCenter
    BiDiMode = bdLeftToRight
    Caption = 'Status'
    ParentBiDiMode = False
    Layout = tlCenter
  end
  object TLblUfCPF: TLabel
    Left = 8
    Top = 248
    Width = 3
    Height = 15
    Alignment = taCenter
    Layout = tlCenter
  end
  object TtxtPjPf: TLabeledEdit
    Left = 8
    Top = 48
    Width = 204
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 15
    EditLabel.Caption = 'Digite CPF ou CNPJ'
    TabOrder = 0
    Text = ''
    OnKeyUp = TtxtPjPfKeyUp
  end
  object TBtnValidar: TButton
    Left = 72
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Validar'
    TabOrder = 1
    OnClick = TBtnValidarClick
  end
  object TEditNumeroFormatado: TEdit
    Left = 8
    Top = 200
    Width = 204
    Height = 23
    Alignment = taCenter
    TabOrder = 2
  end
end
