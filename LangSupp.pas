unit LangSupp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, comctrls;

type
  TLangSupport = class(TComponent)
  private
     function getLangResHandle: LongWord;
     procedure setSavePath(sp: String);
     function getLangList: TStringList;
     procedure FindResourceDLLs;
  protected
    { Protected-Deklarationen }
  public
     constructor Create(AOwner: TComponent);
     destructor Destroy;
  published
     function LoadStr(StrNr: Integer): String;
     procedure ProcStrings(ProcForm: String);
     procedure setLanguage(LangID:String);
     function getTranslator(LangID: String):String;
     function FigureOutBestLangFile: String;
     property LangResHandle   : LongWord read getLangResHandle;
     property SavePath        : String write setSavePath;
     property LangList        : TStringList read getLangList;
  end;

var LHandle  : LongWord;
    DLLSavePath : String;
    LList    : TStringList;

implementation

uses Main, Config, Scores, UserName, About;

constructor TLangSupport.Create(AOwner: TComponent);
begin
inherited;
//MyOwner := AOwner As TForm;
FindResourceDLLs;
LHandle := hInstance;
end;

destructor TLangSupport.Destroy;
begin
LList.Free;
inherited;
end;

function TLangSupport.getLangResHandle: LongWord;
begin
Result := LHandle;
end;

procedure TLangSupport.setSavePath(sp: String);
begin
DLLSavePath := sp;
end;

function TLangSupport.getLangList: TStringList;
begin
Result := LList;
end;

procedure TLangSupport.ProcStrings(ProcForm: String);
var c : TListColumn;
begin
if ProcForm = 'frmMain' then begin
   with frmMain do begin
       actNewGame.Caption     := LoadStr(1);
       actNewGame.Hint        := LoadStr(2);
       actUndo.Caption        := LoadStr(3);
       actUndo.Hint           := LoadStr(4);
       actRestart.Caption     := LoadStr(5);
       actRestart.Hint        := LoadStr(6);
       actSaveGame.Caption    := LoadStr(7);
       actSaveGame.Hint       := LoadStr(8);
       actLoadGame.Caption    := LoadStr(9);
       actLoadGame.Hint       := LoadStr(10);
       actShowScores.Caption  := LoadStr(11);
       actShowScores.Hint     := LoadStr(12);
       actUpdateGameList.Caption  := LoadStr(13);
       actUpdateGameList.Hint     := LoadStr(14);
       actSelectGame.Caption  := LoadStr(15);
       actSelectGame.Hint     := LoadStr(16);
       actConfig.Caption      := LoadStr(17);
       actConfig.Hint         := LoadStr(18);
       actAbout.Caption       := LoadStr(19);
       actAbout.Hint          := LoadStr(20);
       actHelp.Caption        := LoadStr(21);
       actHelp.Hint           := LoadStr(22);
       acQuit.Caption         := LoadStr(23);
       acQuit.Hint            := LoadStr(24);
       acHide.Caption         := LoadStr(25);
       acHide.Hint            := LoadStr(26);
       acCreateLink.Caption   := LoadStr(27);
       acCreateLink.Hint      := LoadStr(28);
       actLangSearch.Caption  := LoadStr(30);
       actLangSearch.Hint     := LoadStr(31);
       lblPoints.Caption      := LoadStr(29);
       end;
   end;
if ProcForm = 'frmCfg' then begin
   with frmCfg do begin
      frmCfg.Caption          := LoadStr(200);
      tsMain.Caption          := LoadStr(201);
      chkSmallWin.Caption     := LoadStr(202);
      chkSmallWin.Hint        := LoadStr(203);
      chkPlaySounds.Caption   := LoadStr(204);
      chkPlaySounds.Hint      := LoadStr(205);
      chkShowTooltips.Caption := LoadStr(206);
      chkShowTooltips.Hint    := LoadStr(207);
      bttSelectPath.Caption   := LoadStr(208);
      bttSelectPath.Hint      := LoadStr(209);
      lblPath.Hint            := LoadStr(209);
      bttOK.Caption           := LoadStr(210);
      bttOK.Hint              := LoadStr(211);
      bttCancel.Caption       := LoadStr(212);
      bttCancel.Hint          := LoadStr(213);
      tsLang.Caption          := LoadStr(250);
      lblListTit.Caption      := LoadStr(251);
      lblTranslTit.Caption    := LoadStr(252);
      end;
   end;
if ProcForm = 'frmScores' then begin
   with frmScores do begin
      frmScores.Caption       := LoadStr(400);
      bttSendResults.Caption  := LoadStr(401);
      bttSendResults.Hint     := LoadStr(402);
      //bttSwitchState.Caption  := LoadStr(403);
      bttSwitchState.Hint     := LoadStr(404);
      listScores.Items.Clear;
      lblTit1.Caption         := LoadStr(420);
      lblTit2.Caption         := LoadStr(421);
      lblTit3.Caption         := LoadStr(422);
      lblTit4.Caption         := LoadStr(423);
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(424);;
      c.Width                 := ColumnHeaderWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(425);
      c.Width                 := ColumnTextWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(426);
      c.Width                 := ColumnHeaderWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(427);
      c.Width                 := ColumnHeaderWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(428);
      c.Width                 := ColumnHeaderWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(429);
      c.Width                 := ColumnHeaderWidth;
      c                       := listScores.Columns.Add;
      c.Caption               := LoadStr(430);
      c.Width                 := ColumnHeaderWidth;
      end;
   end;
if ProcForm = 'frmUser' then begin
   with frmUser do begin
      frmUser.Caption         := LoadStr(500);
      lblName.Caption         := LoadStr(501);
      editName.Hint           := LoadStr(502);
      lblMail.Caption         := LoadStr(503);
      bttOK.Caption           := LoadStr(504);
      bttOK.Hint              := LoadStr(505);
      bttCancel.Caption       := LoadStr(506);
      bttCancel.Hint          := LoadStr(507);
      end;
   end;
if ProcForm = 'frmAbout' then begin
   with frmAbout do begin
      frmAbout.Caption        := LoadStr(800);
      lblCopyright.Caption    := LoadStr(801);
      lblHomepage.Caption     := LoadStr(812);
      lblEditorInfo.Caption   := LoadStr(815);
      lblEditorLink.Caption   := LoadStr(816);
      lblDedication.Caption   := LoadStr(820);
      bttClose.Caption        := LoadStr(810);
      bttClose.Hint           := LoadStr(811);
      end;
   end;
end;

procedure TLangSupport.FindResourceDLLs;
var SR  : TSearchRec;
    Str : String;
begin
LList := TStringList.Create;
if FindFirst(DLLSavePath+'*.dll', faAnyFile, sr) = 0 then begin
   repeat
   Str := SR.Name;
   Str := Copy(Str,1,Pos('.',Str)-1);
   LList.Add(Str);
   until FindNext(sr) <> 0;
   findClose(sr);
   end;
end;

function TLangSupport.getTranslator(LangID:String):String;
var tHandle: LongWord;
    buffer : array[0..255] of Char;
    tStr   : String;
begin
try
tStr := LangID+'.dll';
tHandle := LoadLibrary(@tStr[1]);
Loadstring(tHandle, 9992, @buffer, 255);
Result := StrPas(buffer);
if tHandle = 0 then Result := LoadStr(253);
FreeLibrary(tHandle);
except
Result := LoadStr(253);
end;
end;

procedure TLangSupport.setLanguage(LangID:String);
var tStr   : String;
begin
if not (lHandle = hInstance) then
   try
   FreeLibrary(lHandle);
   except
   end;
try
if (LangID <> DefaultLang) then begin
   tStr := LangID+'.dll';
   lHandle := LoadLibrary(@tStr[1]);
   frmMain.HelpFile := LoadStr(9991);
end else begin
   lHandle := hInstance;
   frmMain.HelpFile := HelpFileEng;
   end;
except
lHandle := hInstance;
end;
end;

function TLangSupport.FigureOutBestLangFile: String;
var i,y     : Integer;
    tStr0,
    tStr,
    tStr2   : String;
    tHandle : LongWord;
    SysLang : String;
    buffer  : array[0..255] of Char;
    CodeList: TStringList;
begin
{
0407: German (Standard)
0807: German (Swiss)
0c07: German (Austrian)
1007: German (Luxembourg)
1407: German (Liechtenstein)
}
Result := '';
CodeList := TStringList.Create;
SysLang := IntToHex(GetSystemDefaultLangID,4);
for i := 0 to LList.Count-1 do begin
   try
   tStr0 := LList[i];
   tStr  := LList[i] +'.dll';
   tHandle := LoadLibrary(@tStr[1]);
   Loadstring(tHandle, 9990, @buffer, 255);
   tStr2 := StrPas(buffer);
   FreeLibrary(tHandle);
   frmMain.sysComp.Parse(tStr2,';',CodeList);
   for y := 0 to CodeList.Count-1 do begin
      if LowerCase(CodeList[y]) = LowerCase(SysLang) then begin
         Result := tStr0;
         Break;
         end;
      end;
   except
   end;
   end;
CodeList.Free;
end;

function TLangSupport.LoadStr(StrNr: Integer): String;
var buffer: array[0..255] of Char;
begin
Loadstring(lHandle, StrNr, @buffer, 255);
Result := StrPas(buffer);
end;

end.
