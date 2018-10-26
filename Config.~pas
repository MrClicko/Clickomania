unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, FileCtrl, GameType, LangSupp;

type
  TfrmCfg = class(TForm)
    tsMain: TTabSheet;
    bttOK: TButton;
    bttCancel: TButton;
    chkSmallWin: TCheckBox;
    chkPlaySounds: TCheckBox;
    lblPath: TLabel;
    bttSelectPath: TButton;
    chkShowTooltips: TCheckBox;
    tsLang: TTabSheet;
    lblListTit: TLabel;
    lblTranslTit: TLabel;
    lblTranslator : TLabel;
    listLangs: TListBox;
    pcMain: TPageControl;
    procedure bttOKClick(Sender: TObject);
    procedure bttSelectPathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listLangsClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure SetConfiguration(UsedGame: TGameType);
  end;

var
  Game  : TGameType;
  frmCfg: TfrmCfg;

implementation

uses Main, Scores, UserName, About;

{$R *.DFM}

procedure TfrmCfg.SetConfiguration(UsedGame: TGameType);
begin
Game                  := UsedGame;
chkSmallWin.Checked   := IsSmallWin;
chkPlaySounds.Checked := frmMain.SysComp.ReadRegBool('','Klänge abspielen', true);
lblPath.Caption       := SavePath;
chkShowTooltips.Checked := ShowTooltip;
listLangs.Clear;
listLangs.Items.Assign(LS.LangList);
listLangs.Items.Insert(0, 'English');
end;

procedure TfrmCfg.bttOKClick(Sender: TObject);
begin
IsSmallWin      := chkSmallWin.Checked;
Game.PlaySounds := chkPlaySounds.Checked;
ShowTooltip     := chkShowTooltips.Checked;
if not (listLangs.ItemIndex = -1) then begin
   if listLangs.ItemIndex = 0 then begin
      frmMain.SysComp.SaveRegStr('', 'Programmsprache', '');
      LS.setLanguage(DefaultLang)
   end else begin
      LS.setLanguage(listLangs.Items[listLangs.ItemIndex]);
      frmMain.SysComp.SaveRegStr('', 'Programmsprache', listLangs.Items[listLangs.ItemIndex]);
      end;
   end;
frmMain.syscomp.SaveRegBool('','Kleines Fenster verwenden', IsSmallWin);
frmMain.SysComp.SaveRegBool('','Klänge abspielen', Game.PlaySounds);
if lblPath.Caption <> SavePath then
   if DirectoryExists(lblPath.Caption) then begin
      SavePath := lblPath.Caption;
      frmMain.SysComp.SaveRegStr('', 'Savepath', lblPath.Caption);
      end;
frmMain.SysComp.SaveRegBool('', 'Tooltip zeigen', ShowTooltip);
if not (listLangs.ItemIndex = -1) then frmMain.SetLanguages;
end;

procedure TfrmCfg.bttSelectPathClick(Sender: TObject);
begin
lblPath.Caption := frmMain.SysComp.BrowseDialog(LS.LoadStr(220),0);
MessageDlg(LS.LoadStr(221), mtWarning, [mbOk], 0);
end;

procedure TfrmCfg.FormCreate(Sender: TObject);
begin
LS.ProcStrings(self.Name);
pcMain.ActivePageIndex := 0;
end;

procedure TfrmCfg.listLangsClick(Sender: TObject);
begin
if listLangs.ItemIndex = 0
   then lblTranslator.Caption := 'Matthias Schüssler'
   else lblTranslator.Caption := LS.getTranslator(listLangs.Items[listLangs.ItemIndex]);
end;

end.
