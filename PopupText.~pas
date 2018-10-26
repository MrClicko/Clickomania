unit PopupText;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SysInfo;

type
  TfrmPopupText = class(TForm)
    lblText: TLabel;
    timerClose: TTimer;
    procedure timerCloseTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblTextClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    (*procedure lblTextMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);*)
  private
    procedure SetTransparency(Transparency: Integer);
    procedure CreateParams(VAR Params: TCreateParams); override;
    procedure WMNCHitTest(VAR Msg: TWMNcHitTest); message WM_NCHITTEST;
  public
    procedure SetSize;
  end;

const
    WS_EX_LAYERED = $80000;

{Für die statisch eingebundene Funktion würde die folgende Zeile ausreichen:
function SetLayeredWindowAttributes(hWindow : HWND; crKey : DWORD;  bAlpha : Byte;
   dwFlags : DWORD) : BOOL; stdcall; external user32 name 'SetLayeredWindowAttributes';}

var
  frmPopupText : TfrmPopupText;
  Transp       : Integer;
  DLLHandle    : HModule;
  DLLFunc      : function(hWindow: HWND; crKey: DWORD; bAlpha: Byte; dwFlags:
                 DWORD): BOOL; stdcall;

implementation

uses Main;

{$R *.DFM}

procedure TfrmPopupText.CreateParams(VAR Params: TCreateParams);
begin
// Dies beseitigt die Titelleiste des Fensters.
Inherited CreateParams(Params);
WITH Params DO
   Style := (Style OR WS_POPUP) AND (NOT WS_DLGFRAME);
   {or... Style := Style + WS_POPUP - WS_DLGFRAME; which is the
   equivalent to the above statement}
end;

procedure TfrmPopupText.WMNCHitTest(var msg: TWMNCHitTest);
begin
inherited;
if  (msg.Result = htClient) then  msg.Result := htCaption;
end;

procedure TfrmPopupText.timerCloseTimer(Sender: TObject);
begin
timerClose.Tag := timerClose.Tag + 1;
if timerClose.Tag < 5 then Exit;
dec(Transp,20);
SetTransparency(Transp);
if timerClose.Tag >= 12 then begin
   timerClose.Enabled := false;
   Close;
   end;
end;

procedure TfrmPopupText.FormCreate(Sender: TObject);
var IsWinXPor2k : boolean;
    SysVer      : Double;
begin
// Hier lade ich die Funktion zur Verwendung der Fenster-Transparenz dynamisch.
SysVer := frmMain.syscomp.Systemversion;
IsWinXPor2k := (frmMain.syscomp.System = bsWinNT) AND (SysVer > 4.9);
if IsWinXPor2k then begin
   DLLHandle := LoadLibrary('user32.dll');
   if (DLLHandle <> 0) then try
      @DLLFunc := GetProcAddress(DLLHandle, 'SetLayeredWindowAttributes');
      if Assigned(DLLFunc)
         then SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle,GWL_EXSTYLE) or $80000);
      except end;
   end;
Transp := 196;
SetTransparency(Transp);
end;

procedure TfrmPopupText.FormDestroy(Sender: TObject);
begin
FreeLibrary(DLLHandle);
end;

(*procedure TfrmPopupText.SetTransparency(Transparency: Integer);
begin
{Dies ist die Variante, wenn die DLL statisch ins Programm eingebaut wird.
Das Problem: Das Programm kann unter Windows 98 nicht gestartet werden.
Daher kommt die zweite Variante zur Anwendung, die die DLL dynamisch lädt}
//Byte(255): Fenster solid; Byte(0) Fenster transparent
SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
SetLayeredWindowAttributes(Handle, 0, Byte(Transparency), 2);
end;*)

procedure TfrmPopupText.SetTransparency(Transparency: Integer);
begin
if Assigned(DLLFunc)
   then DLLFunc(Handle, 0, Byte(Transparency), 2);
end;

procedure TfrmPopupText.SetSize;
begin
Transp := 196;
timerClose.Tag :=0;
self.ClientHeight := lblText.Height;
self.ClientWidth  := lblText.Width+4;
SetTransparency(Transp);
end;

procedure TfrmPopupText.lblTextClick(Sender: TObject);
(*var numSendEvents, numRecvEvents: UINT;
    Input: array [1..3] of TInput;
    i, cbSize: Integer;
    Pt, oldPt: TPoint;*)
begin
// Hier versuche ich, einen Klick auf das Fenster weiterzugeben. Was aber nicht klappt, da der Klick nicht aufgerufen wird.
(*
Close;
GetCursorPos(Pt);
//  Pt.x := Form_X;
//  Pt.y := Form_Y;
//Pt := ClientToScreen(Pt);
OutputDebugString(PChar(IntToStr(Pt.x)+', '+IntToStr(Pt.y)));
Pt.x := Round(Pt.x * (65535 / Screen.Width));
Pt.y := Round(Pt.y * (65535 / Screen.Height));
OutputDebugString(PChar(IntToStr(Pt.x)+', '+IntToStr(Pt.y)));
Application.ProcessMessages;
numSendEvents := 3;
for i:=1 to numSendEvents do begin
   Input[i].Itype := INPUT_MOUSE;
   Input[i].mi.dx := pt.x;
   Input[i].mi.dy := pt.y;
   Input[i].mi.mouseData := 0;
   Input[i].mi.time := DateTimeToTimeStamp(Time).Time;
   Input[i].mi.dwExtraInfo := GetMessageExtraInfo;
   end;
Input[1].mi.dwFlags := MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_MOVE;
Input[2].mi.dwFlags := MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN;
Input[3].mi.dwFlags := MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP;
cbSize := SizeOf(Input[1]);
numRecvEvents := SendInput(numSendEvents, Input[1], cbSize);
//if numRecvEvents <> numSendEvents then ShowMessage(SysErrorMessage(GetLastError));
SetCursorPos(oldPt.x, oldPt.y);  *)
end;

end.
