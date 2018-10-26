object frmMain: TfrmMain
  Left = 314
  Top = 101
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = panelBack
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Clickomania NG'
  ClientHeight = 335
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object panelBttns: TPicPanel
    Left = 0
    Top = 33
    Width = 49
    Height = 261
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    OnDblClick = ChangeBackTile
    object bttNew: TSpeedButton
      Left = 8
      Top = 36
      Width = 25
      Height = 28
      Action = actNewGame
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttUndo: TSpeedButton
      Left = 8
      Top = 66
      Width = 25
      Height = 28
      Action = actUndo
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttHelp: TSpeedButton
      Left = 8
      Top = 146
      Width = 25
      Height = 28
      Action = actHelp
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttShowScores: TSpeedButton
      Left = 8
      Top = 90
      Width = 25
      Height = 28
      Action = actShowScores
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttSelect: TSpeedButton
      Left = 8
      Top = 8
      Width = 25
      Height = 28
      Action = actSelectGame
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttConfig: TSpeedButton
      Left = 8
      Top = 120
      Width = 25
      Height = 28
      Action = actConfig
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttAbout: TSpeedButton
      Left = 8
      Top = 176
      Width = 25
      Height = 28
      Action = actAbout
      Flat = True
      Layout = blGlyphBottom
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
    object bttQuit: TSpeedButton
      Left = 8
      Top = 208
      Width = 23
      Height = 28
      Action = acQuit
      Flat = True
      NumGlyphs = 3
      ParentShowHint = False
      ShowHint = True
    end
  end
  object panelBottom: TPicPanel
    Left = 0
    Top = 294
    Width = 201
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    OnDblClick = ChangeBackTile
    object lblPoints: TLabel
      Left = 7
      Top = 8
      Width = 6
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object panelBack: TPicPanel
    Left = 49
    Top = 33
    Width = 152
    Height = 261
    Align = alClient
    BevelOuter = bvNone
    Color = 12937777
    TabOrder = 2
    OnDblClick = ChangeBackTile
    object spOutline: TShape
      Left = 8
      Top = 8
      Width = 17
      Height = 17
      Visible = False
    end
    object panelMain: TPicPanel
      Left = 9
      Top = 8
      Width = 136
      Height = 241
      BevelOuter = bvNone
      Color = 12937777
      TabOrder = 0
      Visible = False
    end
  end
  object panelTop: TPicPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    OnDblClick = ChangeBackTile
    OnMouseDown = panelTopMouseDown
    OnMouseMove = panelTopMouseMove
    object lblClickomaniaTitel: TLabel
      Left = 8
      Top = 8
      Width = 219
      Height = 19
      Caption = 'Clickomania next Generation'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnMouseDown = panelTopMouseDown
      OnMouseMove = panelTopMouseMove
    end
  end
  object alMain: TActionList
    Left = 64
    Top = 41
    object actNewGame: TAction
      Category = 'Main'
      Caption = 'Neu'
      Enabled = False
      ShortCut = 78
      OnExecute = actNewGameExecute
    end
    object actUndo: TAction
      Category = 'Main'
      Caption = 'Undo'
      Enabled = False
      ShortCut = 90
      OnExecute = actUndoExecute
    end
    object actRestart: TAction
      Category = 'Main'
      Caption = 'Restart'
      Enabled = False
      ShortCut = 82
      OnExecute = actRestartExecute
    end
    object actSaveGame: TAction
      Category = 'Debug'
      Caption = 'SaveGame'
      ShortCut = 24659
      OnExecute = actSaveGameExecute
    end
    object actLoadGame: TAction
      Category = 'Debug'
      Caption = 'Laden'
      ShortCut = 24652
      OnExecute = actLoadGameExecute
    end
    object actShowScores: TAction
      Category = 'Main'
      Caption = 'Scores'
      Enabled = False
      ShortCut = 83
      OnExecute = actShowScoresExecute
    end
    object actUpdateGameList: TAction
      Category = 'Helper'
      Caption = 'Update Game List'
      ShortCut = 116
      OnExecute = actUpdateGameListExecute
    end
    object actSelectGame: TAction
      Category = 'Main'
      Caption = 'Select Game'
      Enabled = False
      ShortCut = 71
      OnExecute = actSelectGameExecute
    end
    object actConfig: TAction
      Category = 'Main'
      Caption = 'Configuration'
      Enabled = False
      ShortCut = 16451
      OnExecute = actConfigExecute
    end
    object actAbout: TAction
      Category = 'Main'
      Caption = 'About'
      Enabled = False
      ShortCut = 16449
      OnExecute = actAboutExecute
    end
    object actHelp: TAction
      Category = 'Main'
      Caption = 'Hilfe'
      ShortCut = 112
      OnExecute = actHelpExecute
    end
    object acQuit: TAction
      Category = 'Main'
      Caption = 'Quit'
      OnExecute = acQuitExecute
    end
    object acHide: TAction
      Category = 'Helper'
      Caption = 'acHide'
      ShortCut = 27
      OnExecute = acHideExecute
    end
    object acCreateLink: TAction
      Category = 'Helper'
      Caption = 'Create Link to myself'
      ShortCut = 16452
      OnExecute = CreateLinkToMyself
    end
    object actLangSearch: TAction
      Category = 'Helper'
      Caption = 'Look for Languages'
      ShortCut = 16460
      OnExecute = actLangSearchExecute
    end
  end
  object SysComp: TSysComp
    Hide = False
    ProgRoot = '\SOFTWARE\MSC-Soft\Clickomania nextgen'
    Left = 65
    Top = 104
  end
  object popSelectGame: TPopupMenu
    Left = 66
    Top = 136
  end
  object timerPoints: TTimer
    OnTimer = ShowNewScore
    Left = 64
    Top = 170
  end
  object ddeServer: TDdeServerConv
    OnExecuteMacro = ddeServerExecuteMacro
    Left = 66
    Top = 201
  end
  object ddeServerItem: TDdeServerItem
    ServerConv = ddeServer
    Left = 66
    Top = 233
  end
end
