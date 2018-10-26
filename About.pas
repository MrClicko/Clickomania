unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, JPEG, shellapi;

type
  TfrmAbout = class(TForm)
    panelMain: TPanel;
    bttClose: TButton;
    lblVers: TLabel;
    paintLogo: TPaintBox;
    lblCopyright: TLabel;
    lblDedication: TLabel;
    lblHomepage: TLabel;
    lblEditorInfo: TLabel;
    lblEditorLink: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure paintLogoPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenWebLink(Sender: TObject);
  private
    procedure LoadJPEGfromRes(JPEG: String; Bitmap: TBitmap);
  public
    { Public-Deklarationen }
  end;

var
  frmAbout: TfrmAbout;
  ProgLogo : TBitmap;

implementation

uses Main;

{$R *.DFM}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
LS.ProcStrings(self.Name);
ProgLogo := TBitmap.Create;
LoadJPEGfromRes('PROGLOGO', ProgLogo);
lblVers.Caption := 'Vers. '+frmMain.sysComp.ProcessVersion(Application.ExeName, 'FileVersion');
end;

procedure TfrmAbout.LoadJPEGfromRes(JPEG: String; Bitmap: TBitmap);
var JPGImg : TJPEGImage;
    JPGStream: TResourceStream;
begin
JPGImg:= TJPEGImage.Create;
JPGStream:= TResourceStream.Create(hInstance, PChar(JPEG), RT_RCDATA);
JPGImg.LoadFromStream(JPGStream);
Bitmap.Assign(JPGImg);
JPGImg.Free;
JPGStream.Free;
end;

procedure TfrmAbout.paintLogoPaint(Sender: TObject);
begin
paintLogo.Canvas.Draw(1,1, ProgLogo);
end;

procedure TfrmAbout.FormDestroy(Sender: TObject);
begin
ProgLogo.Free;
end;

procedure TfrmAbout.OpenWebLink(Sender: TObject);
var i : Integer;
    tStr: String;
begin
if Sender = lblHomepage   then tStr := LS.LoadStr(813);
if Sender = lblEditorLink then tStr := LS.LoadStr(817);
I := ShellExecute(Handle, 'open', PChar(tStr), nil, nil, 9);
if i <= 32 then
      MessageDlg(LS.LoadStr(830)+tStr+'".', mtError, [mbOk], 0);
end;

end.
