object frmUser: TfrmUser
  Left = 201
  Top = 114
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 169
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panelMain: TPanel
    Left = 8
    Top = 8
    Width = 313
    Height = 121
    TabOrder = 0
    object lblName: TLabel
      Left = 8
      Top = 8
      Width = 297
      Height = 13
      AutoSize = False
      FocusControl = editName
    end
    object lblMail: TLabel
      Left = 8
      Top = 56
      Width = 297
      Height = 33
      AutoSize = False
      FocusControl = editMail
      WordWrap = True
    end
    object editName: TEdit
      Left = 8
      Top = 24
      Width = 297
      Height = 21
      MaxLength = 30
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object editMail: TEdit
      Left = 8
      Top = 88
      Width = 297
      Height = 21
      MaxLength = 50
      TabOrder = 1
    end
  end
  object bttOK: TButton
    Left = 160
    Top = 136
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object bttCancel: TButton
    Left = 248
    Top = 136
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
end
