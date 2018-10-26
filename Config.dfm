object frmCfg: TfrmCfg
  Left = 388
  Top = 126
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 210
  ClientWidth = 309
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
  object pcMain: TPageControl
    Left = 8
    Top = 8
    Width = 289
    Height = 161
    ActivePage = tsLang
    TabOrder = 0
    object tsMain: TTabSheet
      object lblPath: TLabel
        Left = 8
        Top = 64
        Width = 265
        Height = 13
        AutoSize = False
        ParentShowHint = False
        ShowHint = True
      end
      object chkSmallWin: TCheckBox
        Left = 8
        Top = 8
        Width = 265
        Height = 17
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object chkPlaySounds: TCheckBox
        Left = 8
        Top = 24
        Width = 265
        Height = 17
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object bttSelectPath: TButton
        Left = 8
        Top = 80
        Width = 75
        Height = 25
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = bttSelectPathClick
      end
      object chkShowTooltips: TCheckBox
        Left = 8
        Top = 40
        Width = 257
        Height = 17
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object tsLang: TTabSheet
      ImageIndex = 1
      object lblListTit: TLabel
        Left = 8
        Top = 8
        Width = 209
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTranslatorTitel: TLabel
        Left = 136
        Top = 60
        Width = 145
        Height = 13
        AutoSize = False
      end
      object lblTranslator: TLabel
        Left = 136
        Top = 112
        Width = 145
        Height = 13
        AutoSize = False
      end
      object lblTranslTit: TLabel
        Left = 136
        Top = 96
        Width = 137
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object listLangs: TListBox
        Left = 8
        Top = 24
        Width = 121
        Height = 105
        ItemHeight = 13
        TabOrder = 0
        OnClick = listLangsClick
      end
    end
  end
  object bttOK: TButton
    Left = 144
    Top = 176
    Width = 75
    Height = 25
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = bttOKClick
  end
  object bttCancel: TButton
    Left = 224
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
end
