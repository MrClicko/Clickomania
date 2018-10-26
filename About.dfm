object frmAbout: TfrmAbout
  Left = 201
  Top = 114
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = bttClose
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 320
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object panelMain: TPanel
    Left = 8
    Top = 8
    Width = 273
    Height = 273
    TabOrder = 0
    object lblVers: TLabel
      Left = 176
      Top = 258
      Width = 89
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
    end
    object paintLogo: TPaintBox
      Left = 0
      Top = 0
      Width = 265
      Height = 145
      OnPaint = paintLogoPaint
    end
    object lblCopyright: TLabel
      Left = 2
      Top = 152
      Width = 265
      Height = 13
      AutoSize = False
    end
    object lblDedication: TLabel
      Left = 2
      Top = 240
      Width = 265
      Height = 13
      AutoSize = False
    end
    object lblHomepage: TLabel
      Left = 2
      Top = 168
      Width = 265
      Height = 13
      Cursor = crHandPoint
      AutoSize = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = OpenWebLink
    end
    object lblEditorInfo: TLabel
      Left = 2
      Top = 192
      Width = 265
      Height = 28
      AutoSize = False
      WordWrap = True
    end
    object lblEditorLink: TLabel
      Left = 2
      Top = 220
      Width = 265
      Height = 13
      Cursor = crHandPoint
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = OpenWebLink
    end
  end
  object bttClose: TButton
    Left = 208
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Default = True
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
end
