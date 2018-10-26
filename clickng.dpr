program clickng;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Stein in 'Stein.pas',
  Spielfeld in 'Spielfeld.pas',
  GameType in 'GameType.pas',
  SysInfo in '..\Komponenten\TSystem\SysInfo.pas',
  Scores in 'Scores.pas' {frmScores},
  ComCtrls in 'D:\Borland 5\Delphi5\Source\Vcl\comctrls.pas',
  PopupText in 'PopupText.pas' {frmPopupText},
  UserName in 'UserName.pas' {frmUser},
  Config in 'Config.pas' {frmCfg},
  About in 'About.pas' {frmAbout},
  hh in '..\Komponenten\TSystem\hh.pas',
  LangSupp in 'LangSupp.pas',
  StoneStat in 'StoneStat.pas',
  GameLog in 'GameLog.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Clickomania! next generation';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmScores, frmScores);
  Application.Run;
end.
