unit Scores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  GameType, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  Psock, NMHttp, shellapi, NMURL, LangSupp;

type
  TfrmScores = class(TForm)
    panelMain: TPanel;
    lblTit1: TLabel;
    lblTit2: TLabel;
    lblTit3: TLabel;
    lblTit4: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    panelList: TPanel;
    listScores: TListView;
    bttSwitchState: TSpeedButton;
    panelWebscore: TPanel;
    bttSendResults: TButton;
    httpMain: TNMHTTP;
    urlMain: TNMURL;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure listScoresCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure listScoresColumnClick(Sender: TObject; Column: TListColumn);
    procedure bttSwitchStateClick(Sender: TObject);
    procedure listScoresDrawItem(Sender: TCustomListView; Item: TListItem;
      DrawRect: TRect; State: TOwnerDrawState);
    procedure bttSendResultsClick(Sender: TObject);
  private
    procedure SetWindowState;
    function ListView_GetColumnWidth(hwnd: HWND; iCol: Integer): Integer;
    procedure CalcCRC32(p: Pointer; ByteCount: DWORD; var CRCValue: DWORD);
  public
    procedure Update(G: TGameType; NewEntry: Integer);
    function CRC32(s: string; out CRC32: DWORD): Boolean;
  end;

var
  frmScores : TfrmScores;
  iScore    : TScoreList;
  IsBig     : Boolean;
  EntryToHighlight : Integer;
  Game      : TGameType;

const
  Table: array[0..255] of DWORD = 
    ($00000000, $77073096, $EE0E612C, $990951BA, 
    $076DC419, $706AF48F, $E963A535, $9E6495A3, 
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, 
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91, 
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, 
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7, 
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC, 
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5, 
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172, 
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B, 
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940, 
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59, 
    $26D930AC, $51DE003A, $C8D75180, $BFD06116, 
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F, 
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924, 
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D, 

    $76DC4190, $01DB7106, $98D220BC, $EFD5102A, 
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433, 
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818, 
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01, 
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E, 
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457, 
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C, 
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65, 
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2, 
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB, 
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0, 
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9, 
    $5005713C, $270241AA, $BE0B1010, $C90C2086, 
    $5768B525, $206F85B3, $B966D409, $CE61E49F, 
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, 
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD, 

    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, 
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683, 
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8, 
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1, 
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE, 
    $F762575D, $806567CB, $196C3671, $6E6B06E7, 
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC, 
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5, 
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252, 
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B, 
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, 
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79, 
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236, 
    $CC0C7795, $BB0B4703, $220216B9, $5505262F, 
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, 
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D, 

    $9B64C2B0, $EC63F226, $756AA39C, $026D930A, 
    $9C0906A9, $EB0E363F, $72076785, $05005713, 
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38, 
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21, 
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E, 
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777, 
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C, 
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45, 
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, 
    $A7672661, $D06016F7, $4969474D, $3E6E77DB, 
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, 
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9, 
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, 
    $BAD03605, $CDD70693, $54DE5729, $23D967BF, 
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94, 
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D); 

type 
//----------------------------------crc32---------------------------------- 
  {$IFDEF VER130}           // This is a bit awkward 
    // 8-byte integer 
    TInteger8 = Int64;     // Delphi 5 
  {$ELSE} 
  {$IFDEF VER120} 
    TInteger8 = Int64;     // Delphi 4 
  {$ELSE} 
    TInteger8 = COMP;      // Delphi  2 or 3 
  {$ENDIF} 
  {$ENDIF} 
//----------------------------------crc32---------------------------------- 


implementation

uses Main;

{$R *.DFM}
{$R Score.res}

procedure TfrmScores.Update(G: TGameType; NewEntry: Integer);
var SE : TScoreEntry;
    i  : Integer;
    F  : Double;
    Item : TListItem;
    ShowWebScore : Boolean;
    Score        : TScoreList;
begin
Game := G;
Score := Game.Score;
if not (NewEntry = -2) then EntryToHighlight := NewEntry;
lbl1.Caption := IntToStr(Score.GamesPlayed);
ShowWebScore := not (frmMain.WebScoreURL ='');
if not (panelWebscore.Visible = ShowWebScore) then begin
   panelWebscore.Visible := ShowWebScore;
   SetWindowState;
   end;
if Score.GamesPlayed = 0
   then F := 0
   else F := (Score.StonesLeft / Score.GamesPlayed);
lbl2.Caption := Format('%f',[F]);
if Score.GamesPlayed = 0
   then F := 0
   else F := (Score.TimeTotal / Score.GamesPlayed);
lbl3.Caption := Format('%f',[F]);
lbl4.Caption := IntToStr(Score.NotFinished);
listScores.Items.Clear;
for i := 0 to 9 do begin
   SE := Score.Entries[i];
   listScores.Canvas.Font.Color := clRed;
   if SE.Pt > 0 then begin
      Item := listScores.Items.Add;
      Item.Data := Pointer(i);
      Item.Caption := IntToStr(i+1);
      Item.SubItems.Add(SE.Player);
      Item.SubItems.Add(IntToStr(SE.Pt));
      If Trunc(SE.Date) = Trunc(Now)
         then Item.SubItems.Add(TimeToStr(SE.Date))
         else Item.SubItems.Add(DateToStr(SE.Date));
      {If Trunc(SE.Date) = Trunc(Now)
         then Item.SubItems.Add(FormatDateTime(SE.Date))
         else Item.SubItems.Add(FormatDateTime(SE.Date));}
      Item.SubItems.Add(IntToStr(SE.StonesLeft));
      Item.SubItems.Add(IntToStr(SE.Time));
      Item.SubItems.Add(IntToStr(SE.BiggestGrp));
      end;
   end;
iScore := Score;
listScores.Refresh;
end;

procedure TfrmScores.FormCreate(Sender: TObject);
begin
EntryToHighlight := -1;
self.Left := frmMain.SysComp.ReadRegInt('', 'Score-Left', 300);
self.Top  := frmMain.SysComp.ReadRegInt('', 'Score-Top', 10);
IsBig     := frmMain.SysComp.ReadRegBool('', 'Grosses Score-Fenster', true);
SetWindowState;
listScores.ReadOnly := true;
LS.ProcStrings(self.Name);
listScores.OwnerDraw := true;
listScores.OnDrawItem := listScoresDrawItem;
end;

procedure TfrmScores.FormDestroy(Sender: TObject);
begin
frmMain.SysComp.SaveRegInt('', 'Score-Left', self.Left);
frmMain.SysComp.SaveRegInt('', 'Score-Top', self.Top);
frmMain.SysComp.SaveRegBool('', 'Grosses Score-Fenster', IsBig);
end;

procedure TfrmScores.listScoresCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var SE1, SE2: TScoreEntry;
    C       : Integer;
begin
// Sortiert nach Nummer
if Data = 0 then begin
   Compare := Integer(Item1.Data) - Integer(Item2.Data);
   Exit;
   end;
SE1 := iScore.Entries[Integer(Item1.Data)];
SE2 := iScore.Entries[Integer(Item2.Data)];
// Sortiert nach Name
if Data = 1 then Compare := AnsiCompareText(SE1.Player, SE2.Player);
// Sortiert nach Punkte
if Data = 2 then Compare := SE1.Pt - SE2.Pt;
// Sortiert nach Datum
if Data = 3 then begin
   if (SE2.Date - SE1.Date) > 0
      then C := 1
      else C := 0;
   Compare := C;
   end;
// Sortiert nach Steine
if Data = 4 then Compare := SE1.StonesLeft - SE2.StonesLeft;
// Sortiert nach Zeit
if Data = 5 then Compare := SE1.Time - SE2.Time;
// Sortiert nach bester Zug
if Data = 6 then Compare := SE2.BiggestGrp - SE1.BiggestGrp;
end;

procedure TfrmScores.listScoresColumnClick(Sender: TObject;
  Column: TListColumn);
begin
TListView(Sender).CustomSort(nil, Column.Index);
end;

procedure TfrmScores.bttSwitchStateClick(Sender: TObject);
begin
IsBig := not IsBig;
SetWindowState
end;

procedure TfrmScores.SetWindowState;
begin
panelList.Visible := IsBig;
if not IsBig then begin
   bttSwitchState.Glyph.LoadFromResourceName(hInstance, 'SWITCHLEFT');
   panelMain.SetBounds(4,4,170,68);
   bttSwitchState.Top  := 4;
   bttSwitchState.Left :=178;
   lblTit1.SetBounds(4,4,115,13);
   lblTit2.SetBounds(4,20,115,13);
   lblTit3.SetBounds(4,36,115,13);
   lblTit4.SetBounds(4,52,115,13);
   lbl1.SetBounds(130,4,32,13);
   lbl2.SetBounds(130,20,32,13);
   lbl3.SetBounds(130,36,32,13);
   lbl4.SetBounds(130,52,32,13);
   panellist.Top := 60;
   if panelWebscore.Visible
      then frmScores.Height := 100 + panelWebscore.Height +5
      else frmScores.Height := 100;
   panelWebscore.SetBounds(4,panelMain.Height+8,200,panelWebscore.Height);
   frmScores.Width  := 212;
end else begin
   bttSwitchState.Glyph.LoadFromResourceName(hInstance, 'SWITCHDOWN');
   panelMain.SetBounds(4,4,300,36);
   bttSwitchState.Top  := 4;
   bttSwitchState.Left :=310;
   lblTit1.SetBounds(4,4,115,13);
   lblTit2.SetBounds(4,20,115,13);
   lblTit3.SetBounds(140,4,115,13);
   lblTit4.SetBounds(140,20,115,13);
   lbl1.SetBounds(97,4,32,13);
   lbl2.SetBounds(97,20,32,13);
   lbl3.SetBounds(258,4,32,13);
   lbl4.SetBounds(258,20,32,13);
   panelList.Left := 4;
   panelList.Top := 43;
   panelList.Height := 180;
   if panelWebscore.Visible
      then frmScores.Height := 255 + panelWebscore.Height
      else frmScores.Height := 255;
   panelWebscore.SetBounds(4,panelMain.Height+panelList.Height+12,panelList.Width,panelWebscore.Height);
   frmScores.Width  := 348;
   end;
end;

procedure TfrmScores.listScoresDrawItem(Sender: TCustomListView;
  Item: TListItem; DrawRect: TRect; State: TOwnerDrawState);
var CurrentLeft: Integer;
    i: Integer;
begin
with Sender as TListView do begin
   if EntryToHighlight = Integer(Item.Data)
      then Canvas.Font.Color := clRed
      else Canvas.Font.Color := clBlack;
   CurrentLeft := DrawRect.Left+2;
   //Canvas.TextOut(CurrentLeft, DrawRect.Top, Item.Caption);
   Canvas.TextRect(DrawRect,CurrentLeft,DrawRect.Top,Item.Caption);
   if Item.Subitems.Count = 0 then Exit;
   for i := 1 to Item.SubItems.Count do begin
         // Da ich die Spaltenbreite über ColumnHeaderWidth festlege, funktioniert Columns[i-1].Width nicht.
         Inc(CurrentLeft, ListView_GetColumnWidth(listScores.Handle, i-1));
         // Hier könnte man die Spalte noch einfärben
         //Canvas.Brush.Color := clBlue; Canvas.Pen.Color   := clBlack;
         //Canvas.FillRect(Rect(CurrentLeft,DrawRect.Top, ListView_GetColumnWidth(listScores.Handle, i-1),5));
         Canvas.TextOut(CurrentLeft, DrawRect.Top, Item.SubItems[i-1]);
      end;
   end;
end;

function TfrmScores.ListView_GetColumnWidth(hwnd: HWND; iCol: Integer): Integer;
const LVM_FIRST          = $1000;
      LVM_GETCOLUMNWIDTH      = LVM_FIRST + 29;
begin
Result := Integer( SendMessage(hwnd, LVM_GETCOLUMNWIDTH, iCol, 0) );
end;

procedure TfrmScores.bttSendResultsClick(Sender: TObject);
var ResultPostStr : String;
    ServerAnswer  : String;
    ResultStr     : String;
    ResultPage    : String;
    EncodedName   : String;
    EncodedMail   : String;
    i             : Integer;
    Score         : TScoreEntry;
    CfgString     : String;
    IDString      : String;
    CheckSumStr   : String;
    DatumStr      : String;
    CouldPost     : Boolean;
    CRC           : DWORD;
    function RemoveCommas(InStr: String): String;
    var i : Integer;
    begin
    for i := Length(InStr) downto 1 do
       if InStr[i] = ',' then Delete(InStr,i,1);
    Result := InStr;
    end;
begin
//Game := frmMain.;
{$IFDEF UseLocalWebScores}
{$ELSE}
if EntryToHighlight = -1 then begin
   MessageDlg(LS.LoadStr(435), mtError, [mbOK],0);
   Exit;
   end;
{$ENDIF}
bttSendResults.Enabled  := false;
frmScores.Cursor        := crHourGlass;
httpMain.InputFileMode  := FALSE;
httpMain.OutputFileMode := FALSE;
httpMain.ReportLevel    := Status_Basic;
{$IFDEF UseLocalWebScores}
Score                   := iScore.Entries[0];
{$ELSE}
Score                   := iScore.Entries[EntryToHighlight];
{$ENDIF}
EncodedName             := Score.Player;
urlMain.InputString     := RemoveCommas(EncodedName);
EncodedName             := urlMain.Encode;
EncodedMail             := Score.EMail;
if EncodedMail = '' then EncodedMail  := '%20';
urlMain.InputString     := RemoveCommas(EncodedMail);
EncodedMail             := urlMain.Encode;
IDString                := WriteIDCmd+'='+frmMain.GameName;
CfgString               := WriteGameCfg+'='+IntToStr(Game.NrColumnsOrig)+
                           IntToStr(Game.NrRowsOrig)+
                           IntToStr(Game.NrOfColors);
DatumStr                := FloatToStr(Score.Date);
while Pos(',', DatumStr) > 0 do DatumStr[Pos(',', DatumStr)] := '.';
//CheckSumStr             := WriteChecksum+'='+IntToStr(CRC32(DatumStr, Length(DatumStr)));
CRC32(DatumStr+IntToStr(Score.Pt), CRC);
CheckSumStr             := WriteChecksum+'='+IntToStr(CRC);
// Result-Str: ?Score=Matthias,matthias@clickomania.ch,110,3,22,15
ResultStr               := EncodedName+','+EncodedMail+','+
                           IntToStr(Score.Pt)+','+IntToStr(Score.StonesLeft)+','+
                           IntToStr(Score.Time)+','+IntToStr(Score.BiggestGrp)+','+
                           DatumStr +'&'+IDString+'&'+CfgString+'&'+CheckSumStr;
ResultPostStr := frmMain.WebScoreURL + WriteWebscore+'?'+WriteWSComd+'='+ResultStr;
CouldPost := true;
try
   httpMain.Get(ResultPostStr);
   ServerAnswer := httpMain.Body;
   If Length(ServerAnswer) > 30 then
      ServerAnswer := Copy(ServerAnswer,1,30);
   //ShowMessage(ServerAnswer);
   ResultPage    := frmMain.WebScoreURL + Showscore + '?'+'&'+IDString+'&'+ShowWSStat + '=' + ServerAnswer;
   except
   CouldPost := false;
   MessageDlg(LS.LoadStr(436)+' '+frmMain.WebScoreURL+'.', mtError, [mbOK],0);
   end;
try
   if CouldPost then begin
      //SetState('Seite erfolgreich abgerufen von '+ResultPostStr+'.');
      I := ShellExecute(Handle, 'open', PChar(ResultPage), nil, nil, 9);
      end;
   except
   MessageDlg(LS.LoadStr(437)+frmMain.WebScoreURL+'.', mtError, [mbOK],0);
   end;
bttSendResults.Enabled  := true;
frmScores.Cursor        := crDefault;
end;

procedure TfrmScores.CalcCRC32(p: Pointer; ByteCount: DWORD; var CRCValue: DWORD);
  // The following is a little cryptic (but executes very quickly).
  // The algorithm is as follows: 
  // 1. exclusive-or the input byte with the low-order byte of 
  // the CRC register to get an INDEX 
  // 2. shift the CRC register eight bits to the right 
  // 3. exclusive-or the CRC register with the contents of Table[INDEX] 
  // 4. repeat steps 1 through 3 for all bytes 
var
  i: DWORD;
  q: ^BYTE; 
begin 
  q := p; 
  for i := 0 to ByteCount - 1 do 
  begin 
    CRCvalue := (CRCvalue shr 8) xor 
      Table[q^ xor (CRCvalue and $000000FF)];
    Inc(q) 
  end 
end;

//function TfrmScores.CRC32(const data; count: integer):  LongInt;
function TfrmScores.CRC32(s: string; out CRC32: DWORD): Boolean;
var 
  CRC32Table: DWORD; 
begin 
  // Verify the table used to compute the CRCs has not been modified. 
  // Thanks to Gary Williams for this suggestion, Jan. 2003.
  CRC32Table := $FFFFFFFF; 
  CalcCRC32(Addr(Table[0]), SizeOf(Table), CRC32Table); 
  CRC32Table := not CRC32Table; 

  if CRC32Table <> $6FCF9E13 then ShowMessage('CRC32 Table CRC32 is ' + 
      IntToHex(Crc32Table, 8) + 
      ', expecting $6FCF9E13') 
  else 
  begin 
    CRC32 := $FFFFFFFF; // To match PKZIP 
    if Length(s) > 0  // Avoid access violation in D4 
      then CalcCRC32(Addr(s[1]), Length(s), CRC32); 
    CRC32 := not CRC32; // To match PKZIP 
  end; 
end;

end.

