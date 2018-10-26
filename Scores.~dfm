object frmScores: TfrmScores
  Left = 393
  Top = 148
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  ClientHeight = 315
  ClientWidth = 346
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
  object bttSwitchState: TSpeedButton
    Left = 312
    Top = 8
    Width = 23
    Height = 22
    ParentShowHint = False
    ShowHint = True
    OnClick = bttSwitchStateClick
  end
  object panelMain: TPanel
    Left = 8
    Top = 8
    Width = 297
    Height = 73
    TabOrder = 0
    object lblTit1: TLabel
      Left = 0
      Top = 0
      Width = 115
      Height = 13
      AutoSize = False
    end
    object lblTit2: TLabel
      Left = 0
      Top = 16
      Width = 115
      Height = 13
      AutoSize = False
    end
    object lblTit3: TLabel
      Left = 0
      Top = 32
      Width = 115
      Height = 13
      AutoSize = False
    end
    object lblTit4: TLabel
      Left = 0
      Top = 48
      Width = 115
      Height = 13
      AutoSize = False
    end
    object lbl1: TLabel
      Left = 130
      Top = 0
      Width = 32
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 130
      Top = 16
      Width = 32
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 130
      Top = 32
      Width = 32
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 130
      Top = 48
      Width = 32
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object panelList: TPanel
    Left = 8
    Top = 80
    Width = 330
    Height = 185
    BevelOuter = bvNone
    TabOrder = 1
    object listScores: TListView
      Left = 0
      Top = 0
      Width = 330
      Height = 185
      Align = alClient
      Columns = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ReadOnly = True
      ParentFont = False
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = listScoresColumnClick
      OnCompare = listScoresCompare
    end
  end
  object panelWebscore: TPanel
    Left = 8
    Top = 280
    Width = 329
    Height = 28
    BevelOuter = bvNone
    TabOrder = 2
    object bttSendResults: TButton
      Left = 0
      Top = 0
      Width = 169
      Height = 25
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = bttSendResultsClick
    end
  end
  object httpMain: TNMHTTP
    Port = 0
    ReportLevel = 0
    Body = 'Default.htm'
    Header = 'Head.txt'
    HeaderInfo.LocalProgram = 'ClickNGV1'
    InputFileMode = False
    OutputFileMode = False
    ProxyPort = 0
    Left = 184
    Top = 280
  end
  object urlMain: TNMURL
    Left = 216
    Top = 280
  end
end
