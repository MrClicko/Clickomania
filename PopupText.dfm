object frmPopupText: TfrmPopupText
  Left = 574
  Top = 250
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsNone
  ClientHeight = 103
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Scaled = False
  OnClick = lblTextClick
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblText: TLabel
    Left = 0
    Top = 0
    Width = 7
    Height = 29
    Alignment = taCenter
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    OnClick = lblTextClick
  end
  object timerClose: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timerCloseTimer
    Left = 16
    Top = 56
  end
end
