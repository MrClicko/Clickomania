object frmUser: TfrmUser
  Left = 201
  Top = 114
  Width = 343
  Height = 214
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Spieler'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object panelMain: TPanel
    Left = 8
    Top = 8
    Width = 313
    Height = 129
    TabOrder = 0
    object lblName: TLabel
      Left = 8
      Top = 8
      Width = 53
      Height = 13
      Caption = 'Dein Name'
      FocusControl = editName
    end
    object lblMail: TLabel
      Left = 8
      Top = 56
      Width = 213
      Height = 13
      Caption = 'Deine E-Mail-Adresse (oder ein Kommentar...)'
      FocusControl = editMail
    end
    object editName: TEdit
      Left = 8
      Top = 24
      Width = 297
      Height = 21
      TabOrder = 0
      Text = 'editName'
    end
    object editMail: TEdit
      Left = 8
      Top = 72
      Width = 297
      Height = 21
      TabOrder = 1
    end
  end
  object bttOK: TButton
    Left = 168
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
  end
  object bttCancel: TButton
    Left = 248
    Top = 144
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    TabOrder = 2
  end
end
