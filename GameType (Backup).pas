unit GameType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  mmsystem, JPEG, FileCtrl, UserName, Forms;

const
  FileID     = 'ClickomaniaNG-Datei.Version1';
  ScoreID    = 'ClickomaniaNG-Score.Version1';
  DefExt     = '.cng';
  ScoreExt   = '.csc';
  Default    = 'default';
  PrimeGame  = 'PrimeGame';
  NrOfScores = 9;
  NrOfActTypes= 7;

type
  TSoundType = (stStart, stWon, stOver, stMove, stNoMove, stUndo, stRestart);
  TDrawType  = (dtShowBack, dtHideBack);
  TActionType= (atBomb, atRocketLeft, atRocketRight, atRocketTop, atRocketBottom,
                atRock, atEarthQuake);
{  TActionType= (atBomb, atRocketLeft, atRocketRight, atRocketTop, atRocketBottom,
                atRock, atEarthQuake, atWhirl, atColorBomb);}
  TScoreEntry  = record
    Pt          : Integer;
    Player      : String;
    EMail       : String;
    Date        : TDate;
    StonesLeft  : Integer;
    Time        : Integer;
    BiggestGrp  : Integer;
    end;
  TScoreList = record
    GamesPlayed,
    StonesTotal,
    TimeTotal,
    StonesLeft,
    NotFinished  : Integer;
    Entries      : array[0..NrOfScores] of TScoreEntry;
    end;
  TAnimationInfo = record
    UseAnimations : boolean;
    PlayBackwards : boolean;
    SeparateColor : boolean;
    CountFrames   : Integer;
    AniList       : TImageList;
    end;
  TActionInfo = record
    Activate  : boolean;
    TypeList  : Set of TActionType;
    Frequ     : Integer;
    end;
  TGameType = class(TComponent)
  private
    NrOfCols    : Integer;
    NrOfRows    : Integer;
    NrOfColumns : Integer;
    RowOrig     : Integer;
    ColumnsOrig : Integer;
    StoneHeight : Integer;
    StoneWidth  : Integer;
    Balls       : TImageList;
    FPA         : Integer;
    GName       : String;
    Desc        : String;
    iBGColor    : TColor;
    Back        : TBitmap;
    JPEGBack    : TJPEGImage;
    IsJPEG      : Boolean;
    UserBack    : String;
    iDT         : TDrawType;
    AniInfo     : TAnimationInfo;
    iSoundState : Boolean;
    lHandle     : LongWord;
    DefaultGame : Boolean;
    ScoreURL    : String;
    MSWAVStart, MSWAVWon, MSWAVOver, MSWAVMove, MSWAVNoMove, MSWAVUndo, MSWAVRestart
                : TMemoryStream;
    ScoreFile   : String;
    ScoreList   : TScoreList;
    Path        : String;
    UName       : String[30];
    UMail       : String[50];
    Actions     : TActionInfo;
    function getGameName: String;
    procedure setGameName(GN : String);
    function getDesc: String;
    procedure setDesc(B: String);
    function getBack: TBitmap;
    procedure setBack(B: TBitmap);
    function getJPGbg: TJPEGImage;
    procedure setJPGbg(JPGbg: TJPEGImage);
    function getJPEGstate: Boolean;
    procedure setJPEGstate(JPGstate: Boolean);
    function getBGColor: TColor;
    procedure setBGColor(C: TColor);
    function getDrawType: TDrawType;
    procedure setDrawType(dt : TDrawType);
    function getAnimationInfo: TAnimationInfo;
    procedure setAnimationInfo(AI : TAnimationInfo);
    function getNrOfCols: Integer;
    procedure setNrOfCols(Nr: Integer);
    function getRows: Integer;
    procedure setRows(Nr: Integer);
    function getCols: Integer;
    procedure setCols(Nr: Integer);
    function getRowsOrig: Integer;
    function getColumnsOrig: Integer;
    function getSteinHoehe: Integer;
    procedure setSteinHoehe(Nr: Integer);
    function getSteinBreite: Integer;
    procedure setSteinBreite(Nr: Integer);
    function getBallsList: TImageList;
    function getFPA: Integer;
    procedure setFPA(Nr: Integer);
    function getUserBack: String;
    procedure setUserBack(UBack : String);
    function getPlaySoundState: Boolean;
    procedure setPlaySoundsState(State: Boolean);
    procedure setActions(Act: TActionInfo);
    function getActions: TActionInfo;
    function getNrOfActionTypes: Integer;
    function getWebScoreURL: String;
    procedure setWebScoreURL(NewScoreURL: String);
    function getScore: TScoreList;
    function getUsername: String;
    procedure setUserName(UN: String);
    function getUserMail: String;
    procedure setUserMail(UM: String);
    procedure setSavePath(SP : String);
    procedure setLangHandle(lh : LongWord);
    function getDefaultGameState: Boolean;
    procedure setDefaultGameState(DGS: Boolean);
    procedure ReadInGame;
    function ReadString(Stream: TFileStream): String;
    procedure WriteString(Stream: TFileStream; s: string);
    function ReadID(Stream: TFileSTream): Integer;
    procedure WriteID(Stream: TFileSTream; ID: Integer);
    procedure ReadJPEG(F: TFileStream; J: TJPEGImage);
    procedure WriteJPEG(IDNR: Integer; F: TFileStream; J: TJPEGImage);
    procedure ReadSound(F: TFileSTream; S: TMemoryStream);
    procedure WriteSound(IDNr: Integer; F: TFileSTream; S: TMemoryStream);
    procedure ReadImageList(F: TFileSTream; IL: TImageLIst);
    procedure WriteImageList(F: TFileSTream; IL: TImageLIst);
    procedure CreateEmptyScore;
    procedure ReadScore;
    procedure WriteScore;
    function LoadStr(StrNr: Integer): String;
  protected
  public
    procedure SaveGameToFile;
    procedure LoadGameFromFile;
    procedure PlaySound(SoundID: TSoundType);
    procedure SetSound(Sound: TMemoryStream; ID: TSoundType);
    function getSoundSize(ID: TSoundType): Integer;
    procedure DeleteSound(ID: TSoundType);
    function SaveScores(Pts, StLeft, Playtime, NrOfMoves, BestMove: Integer; Finished: Boolean): Integer;
    constructor Create(AOwner: TComponent; Name: String; SavePath: String);virtual;
    destructor Destroy;override;
  published
    property GameName         : String read getGameName write setGameName;
    property Beschreibung     : String read getDesc write setDesc;
    property NrOfColors       : Integer read getNrOfCols write setNrOfCols;
    property Rows             : Integer read getRows write setRows;
    property Columns          : Integer read getCols write setCols;
    property NrRowsOrig       : Integer read getRowsOrig;
    property NrColumnsOrig    : Integer read getColumnsOrig;
    property Steinhoehe       : Integer read getSteinHoehe write setSteinHoehe;
    property Steinbreite      : Integer read getSteinbreite write setSteinBreite;
    property BallsList        : TImageList read getBallsList;
    property FramesPerAnimation: Integer read getFPA write setFPA;
    property Background       : TBitmap read getBack write setBack;
    property JPEGbg           : TJPEGImage read getJPGbg write setJPGbg;
    property UseJPEGback      : Boolean read getJPEGstate write setJPEGstate;
    property UseThisBack      : String read getUserBack write setUserBack;
    property BgColor          : TColor read getBGcolor write setBGcolor;
    property DrawType         : TDrawType read getDrawType write setDrawType;
    property Animations       : TAnimationInfo read getAnimationInfo write setAnimationInfo;
    property PlaySounds       : Boolean read getPlaySoundState write setPlaySoundsState;
    property SavePath         : String write setSavePath;
    property Score            : TScoreList read getScore;
    property UserName         : String read getUsername write setUsername;
    property UserMail         : String read getUsermail write setUsermail;
    property ActionStones     : TActionInfo read getActions write setActions;
    property CountActionTypes : Integer read getNrOfActionTypes;
    property WebScoreURL      : String read getWebScoreURL write setWebScoreURL;
    property LangHandle       : LongWord write setLangHandle;
    property IsDefaultGame    : Boolean read getDefaultGameState write setDefaultGameState;
  end;

procedure Register;

{$R balls.res}

implementation

procedure Register;
begin
  RegisterComponents('Matthias', [TGameType]);
end;

constructor TGameType.Create(AOwner: TComponent; Name: String; SavePath: String);
begin
inherited Create(AOwner);
Path        := '';
Path        := SavePath;
iBGColor    := clNone;
Balls       := TImageList.Create(self);
Balls.Name  := 'Balls';
AniInfo.AniList      := TImageList.Create(self);
AniInfo.AniList.Name := 'Animations';
Back        := TBitmap.Create;
GName       := Name;
iDT         := dtHideBack;
//iDT       := dtShowBack;
IsJPEG      := true;
iSoundState := true;
DefaultGame := true;
ScoreFile   := Path+GName+ScoreExt;
MSWAVStart  := TMemoryStream.Create;
MSWAVWon    := TMemoryStream.Create;
MSWAVOver   := TMemoryStream.Create;
MSWAVMove   := TMemoryStream.Create;
MSWAVNoMove := TMemoryStream.Create;
MSWAVUndo   := TMemoryStream.Create;
MSWAVRestart:= TMemoryStream.Create;
JPEGBack    := TJPEGImage.Create;
if Name = '[New]' then Exit;
ReadInGame;
if not FileExists(ScoreFile)
   then CreateEmptyScore
   else ReadScore;
end;

destructor TGameType.Destroy;
begin
Balls.Free;
AniInfo.AniList.Free;
Back.Free;
MSWAVStart.Free;
MSWAVWon.Free;
MSWAVOver.Free;
MSWAVMove.Free;
MSWAVNoMove.Free;
MSWAVUndo.Free;
MSWAVRestart.Free;
JPEGBack.Free;
Inherited destroy;
end;

function TGameType.getGameName: String;
begin
Result := GName;
end;

procedure TGameType.setGameName(GN : String);
begin
GName := GN;
end;

function TGameType.getDesc: String;
begin
Result := Desc;
end;

procedure TGameType.setDesc(B: String);
begin
Desc := B;
end;

function TGameType.getBack: TBitmap;
begin
Result := Back;
end;

procedure TGameType.setBack(B: TBitmap);
begin
Back := B;
end;

function TGameType.getJPGbg: TJPEGImage;
begin
Result := JPEGBack;
end;

procedure TGameType.setJPGbg(JPGbg: TJPEGImage);
begin
JPEGBack := JPGbg;
end;

function TGameType.getBGColor: TColor;
begin
Result := iBGColor;
end;

function TGameType.getJPEGstate: Boolean;
begin
Result := IsJPEG;
end;

procedure TGameType.setJPEGstate(JPGstate: Boolean);
begin
IsJPEG := JPGstate;
end;

procedure TGameType.setBGColor(C: TColor);
begin
iBGColor := C;
end;

function TGameType.getDrawType: TDrawType;
begin
Result := iDT;
end;

procedure TGameType.setDrawType(dt : TDrawType);
begin
iDT := dt;
end;

function TGameType.getAnimationInfo: TAnimationInfo;
begin
Result := AniInfo;
end;

procedure TGameType.setAnimationInfo(AI : TAnimationInfo);
begin
AniInfo := AI;
end;

function TGameType.getNrOfCols: Integer;
begin
Result := NrOfCols;
end;

procedure TGameType.setNrOfCols(Nr: Integer);
begin
NrOfCols := Nr;
end;

function TGameType.getRows: Integer;
begin
Result := NrOfRows;
end;

procedure TGameType.setRows(Nr: Integer);
begin
NrOfRows := Nr;
end;

function TGameType.getCols: Integer;
begin
Result := NrOfColumns;
end;

procedure TGameType.setCols(Nr: Integer);
begin
NrOfColumns := Nr;
end;

function TGameType.getRowsOrig: Integer;
begin
{Diese Funktion gibt die Original-Spielfeldkonfiguration zurück, wenn die
Grösse durch ein User-Bild verändert wurde}
Result := RowOrig;
end;

function TGameType.getColumnsOrig: Integer;
begin
{Diese Funktion gibt die Original-Spielfeldkonfiguration zurück, wenn die
Grösse durch ein User-Bild verändert wurde}
Result := ColumnsOrig;
end;

function TGameType.getSteinHoehe: Integer;
begin
Result := StoneHeight;
end;

procedure TGameType.setSteinHoehe(Nr: Integer);
begin
StoneHeight := Nr;
end;

function TGameType.getSteinBreite: Integer;
begin
Result := StoneWidth;
end;

procedure TGameType.setSteinBreite(Nr: Integer);
begin
StoneWidth := Nr;
end;

function TGameType.getBallsList: TImageList;
begin
Result := Balls;
end;

function TGameType.getFPA: Integer;
begin
Result := FPA;
end;

procedure TGameType.setFPA(Nr: Integer);
begin
FPA := Nr;
end;

function TGameType.getUserBack: String;
begin
Result := UserBack;
end;

procedure TGameType.setActions(Act: TActionInfo);
begin
Actions := Act;
end;

function TGameType.getActions: TActionInfo;
begin
Result := Actions;
end;

function TGameType.getNrOfActionTypes: Integer;
var i : TActionType;
begin
//Result := NrOfActTypes;
Result := 0;
for I := Low(TActionType) to High(TActionType) do Inc(Result);
end;

function TGameType.getWebScoreURL: String;
begin
Result := ScoreURL;
end;

procedure TGameType.setWebScoreURL(NewScoreURL: String);
begin
ScoreURL := NewScoreURL;
end;

procedure TGameType.setLangHandle(lh : LongWord);
begin
lHandle := lh;
end;

function TGameType.getDefaultGameState: Boolean;
begin
Result := DefaultGame;
end;

procedure TGameType.setDefaultGameState(DGS: Boolean);
begin
DefaultGame := DGS;
end;

procedure TGameType.setUserBack(UBack : String);
var Str   : String;
    Scale : Double;
    Bmp   : TBitmap;
begin
// Das in der Skin gespeicherte Hintergrundbild durch externe Datei ersetzen
try
UserBack := UBack;
Str := UBack;
Bmp := TBitmap.Create;
Str := LowerCase(Copy(Str,Pos('.',Str)+1,1000));
if (Str = 'jpg') or (Str = 'jpeg') then begin
   JPEGBack.LoadFromFile(UBack);
   Bmp.Assign(JPEGBack);
   end;
if (Str = 'bmp') then begin
   Bmp.LoadFromFile(Uback);
   end;
Scale := (Bmp.Height * Bmp.Width) / ((NrOfColumns * StoneWidth) * (NrOfRows * StoneHeight));
Scale := sqrt(scale);
NrOfColumns := Round((Bmp.Width / Scale) / StoneWidth);
NrOfRows    := Round((Bmp.Height / Scale) / StoneHeight);
Back.Height := NrOfRows * StoneWidth;
Back.Width := NrOfColumns * StoneHeight;
//Back.Canvas.StretchDraw(Rect(0,0,Back.Width,Back.Height), Bmp);
Back.Canvas.StretchDraw(Back.Canvas.ClipRect, Bmp);
Bmp.Free;
except
raise Exception.Create(Format(LoadStr(600),[Uback]));
end;
end;

function TGameType.getPlaySoundState: Boolean;
begin
Result := iSoundState;
end;

procedure TGameType.setPlaySoundsState(State: Boolean);
begin
iSoundState := State;
end;

procedure TGameType.SetSound(Sound: TMemoryStream; ID: TSoundType);
begin
if ID = stStart    then MSWAVStart.CopyFrom(Sound, Sound.Size);
if ID = stMove     then MSWAVMove.CopyFrom(Sound,Sound.Size);
if ID = stUndo     then MSWAVUndo.CopyFrom(Sound,Sound.Size);
if ID = stRestart  then MSWAVRestart.CopyFrom(Sound,Sound.Size);
if ID = stNoMove   then MSWAVNoMove.CopyFrom(Sound,Sound.Size);
if ID = stWon      then MSWAVWon.CopyFrom(Sound,Sound.Size);
if ID = stOver     then MSWAVOver.CopyFrom(Sound,Sound.Size);
end;

function TGameType.getSoundSize(ID: TSoundType): Integer;
begin
if ID = stStart    then Result := MSWAVStart.Size;
if ID = stMove     then Result := MSWAVMove.Size;
if ID = stUndo     then Result := MSWAVUndo.Size;
if ID = stRestart  then Result := MSWAVRestart.Size;
if ID = stNoMove   then Result := MSWAVNoMove.Size;
if ID = stWon      then Result := MSWAVWon.Size;
if ID = stOver     then Result := MSWAVOver.Size;
end;

procedure TGameType.DeleteSound(ID: TSoundType);
begin
if ID = stStart    then MSWAVStart.Clear;
if ID = stMove     then MSWAVMove.Clear;
if ID = stUndo     then MSWAVUndo.Clear;
if ID = stRestart  then MSWAVRestart.Clear;
if ID = stNoMove   then MSWAVNoMove.Clear;
if ID = stWon      then MSWAVWon.Clear;
if ID = stOver     then MSWAVOver.Clear;
end;

function TGameType.getScore: TScoreList;
begin
Result := ScoreList;
end;

function TGameType.getUsername: String;
begin
Result := UName;
end;

procedure TGameType.setUserName(UN: String);
begin
UName := UN;
end;

function TGameType.getUserMail: String;
begin
Result := UMail;
end;

procedure TGameType.setUserMail(UM: String);
begin
UMail := UM;
end;

procedure TGameType.setSavePath(SP : String);
begin
Path := SP;
end;

procedure TGameType.ReadInGame;
var Bmp : TBitmap;
    i   : Integer;
begin
try
if GName = Default then begin
   NrOfCols    := 5;
   NrOfRows    := 12;
   NrOfColumns := 8;
   StoneHeight := 25;
   StoneWidth  := 25;
   FPA         := 4;
   iDT         := dtHideBack;
   Desc        := LoadStr(601);
   AniInfo.UseAnimations := false;
   AniInfo.PlayBackwards := false;
   //Actions.Activate      := false;
   Actions.Frequ         := 20;
   WebScoreURL           := LoadStr(602);
   // T E S T   D E R   A C T I O N S
   (*Actions.Activate      := true;
   Actions.TypeList      := [atBomb, atRocketLeft, atRocketRight, atRocketTop, atRocketBottom, atRock, atEarthQuake];*)
   {NrOfCols    := 5;
   NrOfRows    := 16;
   NrOfColumns := 10;
   StoneHeight := 23;
   StoneWidth  := 22;
   FPA         := 4;
   iDT         := dtShowBack;
   IsJPEG      := true;
   Desc        := 'Classic-Clickomania-Partie';
   AnimateStones := true;
   BAniStones  := false;}
   //Test der Internet-Score:
   {NrOfCols    := 4;
   Desc        := 'Posttest (Internet-Web-Scores)';
   WebScoreURL := 'http://localhost/Delphi/Clickomania_NG/Stuff/Posttest/';
   //WebScoreURL := 'http://www.clickomania.ch/clickng-posttest/';}

end else begin
   LoadGameFromFile;
   end;
{$IFDEF UseLocalWebScores}
WebScoreURL := 'http://localhost/Delphi/Clickomania_NG/Stuff/Posttest/';
{$ENDIF}
Balls.Height := StoneHeight;
Balls.Width  := StoneWidth;
Bmp := TBitmap.Create;
{Beim Standard-Game muss die TImageList hier erzeugt werden. Ansonsten wird sie
aus der cng-Datei geladen.}
if GName = Default then begin
   {if not (FindResource(hInstance, 'Back', RT_BITMAP) = 0)
      then Back.LoadFromResourceName(hInstance, 'Back');}
   {if IsJPEG then begin
      JPEGBack.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\Back-Classic.jpg');
      Back.Assign(JPEGback);
   end else begin
      Back.LoadFromFile('Back-demo.bmp');
      end;
   MSWavMove.LoadFromFile('E:\Delphi\Clickomania\Code43\Smash2.wav');
   MSWavUndo.LoadFromFile('E:\Delphi\Clickomania\Code43\Undo.WAV');
   MSWavWon.LoadFromFile('E:\Delphi\Clickomania\Code43\Won.WAV');
   MSWavNoMove.LoadFromFile('E:\Delphi\Clickomania\Code43\Nohit.wav');
   MSWavOver.LoadFromFile('E:\Delphi\Clickomania\Code43\End.WAV');
   for i := 0 to NrOfCols-1 do begin
      Case i of
         0: Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\ClassicGruen.bmp');
         1: Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\ClassicRot.bmp');
         2: Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\ClassicBlue.bmp');
         3: Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\ClassicOrange.bmp');
         4: Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\ClassicBrown.bmp');
         end;
      Balls.Add( Bmp, nil);
      end;
   for i := 0 to 3 do begin
      Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Classic-CNG\Break'+IntToStr(i+1)+'.BMP');
      if i = 0 then begin
         AniInfo.AniList.Width := Bmp.Width;
         AniInfo.AniList.Height:= Bmp.Height;
         end;
      SAniList.Add(Bmp,nil);
      end;}
   for i := 0 to NrOfCols-1 do begin
      Bmp.LoadFromResourceName(hInstance, 'Ball'+IntToStr(i+1));
      //Balls.AddMasked(Bmp,clFuchsia);
      Balls.Add( Bmp, nil);
      end;
   // T E S T   D E R   A C T I O N S
   (*Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_bomb.bmp');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_MissileLeft.BMP');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_MissileRight.BMP');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_MissileTop.BMP');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_MissileBottom.BMP');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_block.bmp');
   Balls.Add( Bmp, nil);
   Bmp.LoadFromFile('E:\Delphi\Clickomania_NG\Stuff\Act_Earthquake.bmp');
   Balls.Add( Bmp, nil);*)
   end;
Bmp.Free;
except
raise Exception.Create(Format(LoadStr(603), [GName]));
end;
end;

procedure TGameType.SaveGameToFile;
var FS : TFileStream;
begin
try
FS := TFileStream.Create(Path+GName+DefExt, fmCreate);
WriteString(FS, FileID);
WriteID(FS,1);
WriteString(FS,GName);
WriteID(FS,2);
WriteString(FS,Desc);
WriteID(FS,3);
FS.Write(NrOfCols, SizeOf(NrOfCols));
WriteID(FS,4);
FS.Write(NrOfRows, SizeOf(NrOfRows));
WriteID(FS,5);
FS.Write(NrOfColumns, SizeOf(NrOfColumns));
WriteID(FS,6);
FS.Write(StoneHeight, SizeOf(StoneHeight));
WriteID(FS,7);
FS.Write(StoneWidth, SizeOf(StoneWidth));
WriteID(FS,8);
FS.Write(FPA, SizeOf(FPA));
WriteID(FS,9);
//FS.WriteComponent(Balls);
WriteImageList(FS, Balls);
WriteID(FS,10);
FS.Write(IsJPEG, SizeOf(IsJPEG));
if not (Back = nil) then
   if not Back.Empty then begin
      if not IsJPEG then begin
         WriteID(FS,11);
         Back.SaveToStream(FS);
      end else begin
         WriteJPEG(11, FS, JPEGBack);
         end;
      end;
WriteID(FS,12);
FS.Write(iBGColor, SizeOf(TColor));
WriteID(FS,13);
FS.Write(iDT, SizeOf(TDrawType));
WriteSound(14, FS, MSWAVStart);
WriteSound(15, FS, MSWAVWon);
WriteSound(16, FS, MSWAVOver);
WriteSound(17, FS, MSWAVMove);
WriteSound(18, FS, MSWAVNoMove);
WriteSound(19, FS, MSWAVUndo);
WriteSound(20, FS, MSWAVRestart);
if AniInfo.UseAnimations then begin
   WriteID(FS,21);
   FS.Write(AniInfo.UseAnimations, SizeOf(AniInfo.UseAnimations));
   FS.Write(AniInfo.PlayBackwards, SizeOf(AniInfo.PlayBackwards));
   FS.Write(AniInfo.SeparateColor, SizeOf(AniInfo.SeparateColor));
   FS.Write(AniInfo.CountFrames, SizeOf(AniInfo.CountFrames));
   WriteImageList(FS, AniInfo.AniList);
   //FS.WriteComponent(AniInfo.AniList);
   end;
if Actions.Activate then begin
   WriteID(FS,22);
   FS.Write(Actions.Activate, SizeOf(Actions.Activate));
   FS.Write(Actions.TypeList, SizeOf(Actions.TypeList));
   FS.Write(Actions.Frequ, SizeOf(Actions.Frequ));
   end;
if not (WebScoreURL = '') then begin
   WriteID(FS,30);
   WriteString(FS,WebScoreURL);
   end;
If not DefaultGame then begin
   WriteID(FS,31);
   FS.Write(DefaultGame, SizeOf(DefaultGame));
   end;
FS.Free;
except
raise Exception.Create(LoadStr(604));
end;
end;

procedure TGameType.LoadGameFromFile;
var FS : TFileStream;
    Str : String;
    ID  : Integer;
    //Bmp : TBitmap;
    //i   : Integer;
begin
try
FS := TFileStream.Create(Path+GName+DefExt, fmOpenRead);
Str := ReadString(FS);
if not (Str = FileID) then begin
   // Stille Exception ohne Fehlermeldung
   GName := default;
   ReadInGame;
   Exit;
   end;
while FS.Position < FS.Size do begin
   ID := ReadID(FS);
   case ID of
       1: GName := ReadString(FS);
       2: Desc  := ReadString(FS);
       3: FS.Read(NrOfCols,SizeOf(NrOfCols));
       4: FS.Read(NrOfRows,SizeOf(NrOfRows));
       5: FS.Read(NrOfColumns,SizeOf(NrOfColumns));
       6: FS.Read(StoneHeight,SizeOf(StoneHeight));
       7: FS.Read(StoneWidth,SizeOf(StoneWidth));
       8: FS.Read(FPA,SizeOf(FPA));
       9: begin
          //FS.ReadComponent(Balls);
          ReadImageList(FS, Balls);
          end;
      10: FS.Read(IsJPEG, SizeOf(IsJPEG));
      11: begin
          if not IsJPEG then begin
             Back.LoadFromStream(FS);
          end else begin
             ReadJPEG(FS, JPEGBack);
             Back.Assign(JPEGBack);
             end;
          end;
      12: FS.Read(iBGColor, SizeOf(TColor));
      13: FS.Read(iDT, SizeOf(TDrawType));
      14: ReadSound(FS, MSWAVStart);
      15: ReadSound(FS, MSWAVWon);
      16: ReadSound(FS, MSWAVOver);
      17: ReadSound(FS, MSWAVMove);
      18: ReadSound(FS, MSWAVNoMove);
      19: ReadSound(FS, MSWAVUndo);
      20: ReadSound(FS, MSWAVRestart);
      21: begin
          FS.Read(AniInfo.UseAnimations, SizeOf(AniInfo.UseAnimations));
          FS.Read(AniInfo.PlayBackwards, SizeOf(AniInfo.PlayBackwards));
          FS.Read(AniInfo.SeparateColor, SizeOf(AniInfo.SeparateColor));
          FS.Read(AniInfo.CountFrames, SizeOf(AniInfo.CountFrames));
          {ReadComponent hat unter Windows 2000/ME nicht funktioniert und
          leere Bitmaps zurückgeliefert. Daher mach ichs über ReadImageList/WriteImageList}
          ReadImageList(FS, AniInfo.AniList);
          //FS.ReadComponent(AniInfo.AniList);
          end;
      22: begin
          FS.Read(Actions.Activate, SizeOf(Actions.Activate));
          FS.Read(Actions.TypeList, SizeOf(Actions.TypeList));
          FS.Read(Actions.Frequ, SizeOf(Actions.Frequ));
          end;
      30: WebScoreURL := ReadString(FS);
      31: FS.Read(DefaultGame, SizeOf(DefaultGame));
      end;
   end;
RowOrig      := NrOfRows;
ColumnsOrig  := NrOfColumns;
FS.Free;
except
   GName := default;
   //raise Exception.Create('Konnte dieses Spiel nicht einlesen. Standardspiel wird verwendet.');
   ReadInGame;
end;
end;

procedure TGameType.WriteString(Stream: TFileStream; s: string);
var L : Integer;
begin
L := Length(s);
Stream.Write(L, SizeOf(L));
Stream.Write(PChar(s)^, Length(s));
end;

function TGameType.ReadString(Stream: TFileStream): String;
var L : Integer;
    //Buffer : PChar;
    Buffer     : array[0..256] of char;
begin
FillChar(Buffer, SizeOf(Buffer), #0);
Stream.Read(L, SizeOf(L));
Stream.Read(Buffer,L);
Result := StrPas(Buffer);
end;

procedure TGameType.WriteID(Stream: TFileSTream; ID: Integer);
begin
Stream.Write(ID,SizeOf(ID));
end;

function TGameType.ReadID(Stream: TFileSTream): Integer;
begin
Stream.Read(Result,SizeOf(Integer));
end;

procedure TGameType.ReadJPEG(F: TFileStream; J: TJPEGImage);
var Len : Integer;
    tempMS : TMemoryStream;
begin
tempMS := TMemorySTream.Create;
F.Read(Len, SizeOf(Len));
tempMS.CopyFrom(F, Len);
//tempMS.SaveToFile('e:\temp\test2.jpg');
//Wenn hier die Position nicht auf 0 gesetzt wird, gibt J.LoadFromStream Mist!
tempMS.Position := 0;
J.LoadFromStream(tempMS);
tempMS.Free;
end;

procedure TGameType.WriteJPEG(IDNr: Integer; F: TFileStream; J: TJPEGImage);
var Len : Integer;
    tempMS : TMemoryStream;
begin
if not (J = nil) then begin
   WriteID(F, IDNr);
   tempMS := TMemoryStream.Create;
   J.SaveToStream(tempMS);
   tempMS.Position := 0;
   Len := tempMS.Size;
   F.Write(Len,Sizeof(Len));
   tempMS.SaveToStream(F);
   //tempMS.SaveToFile('e:\temp\test.jpeg');
   tempMS.Free;
   end;
end;

procedure TGameType.WriteSound(IDNr: Integer; F: TFileSTream; S: TMemoryStream);
var Len : Integer;
begin
if S.Size > 0 then begin
   WriteID(F, IDNr);
   Len := S.Size;
   F.Write(Len,Sizeof(Len));
   S.SaveToStream(F);
   end;
end;

procedure TGameType.ReadSound(F: TFileSTream; S: TMemoryStream);
var Len : Integer;
begin
F.Read(Len, SizeOf(Len));
S.CopyFrom(F, Len);
end;

procedure TGameType.ReadImageList(F: TFileSTream; IL: TImageLIst);
var i : Integer;
    Bmp : TBitmap;
    CBmp : Integer;
begin
Bmp := TBitmap.Create;
F.Read(CBmp, SizeOf(CBmp));
for i := 0 to CBmp-1 do begin
   Bmp.LoadFromStream(F);
   if i = 0 then begin
      IL.Width := Bmp.Width;
      IL.Height := Bmp.Height;
      end;
   IL.Add(Bmp,nil);
   end;
Bmp.Free;
end;

procedure TGameType.WriteImageList(F: TFileSTream; IL: TImageLIst);
var i : Integer;
    Bmp : TBitmap;
    CBmp : Integer;
begin
Bmp := TBitmap.Create;
CBmp := IL.Count;
F.Write(CBmp, SizeOf(CBmp));
for i := 0 to CBmp -1 do begin
   IL.GetBitmap(i, Bmp);
   Bmp.SaveToStream(F);
   end;
Bmp.Free;
end;

procedure TGameType.PlaySound(SoundID: TSoundType);
    function PlayWave(Sound: TMemoryStream): Boolean;
    begin
    Result := sndPlaySound(Sound.Memory, SND_MEMORY+SND_ASYNC);
    end;
begin
if not iSoundState then Exit;
Case SoundID of
    stStart  : PlayWave(MSWAVStart);
    stRestart: PlayWave(MSWAVRestart);
    stMove   : PlayWave(MSWAVMove);
    stUndo   : PlayWave(MSWAVUndo);
    stWon    : PlayWave(MSWAVWon);
    stNoMove : PlayWave(MSWAVNoMove);
    stOver   : PlayWave(MSWAVOver);
    end;
end;

procedure TGameType.CreateEmptyScore;
var i : Integer;
begin
ScoreList.GamesPlayed := 0;
ScoreList.StonesTotal := 0;
ScoreList.StonesLeft  := 0;
ScoreList.NotFinished := 0;
ScoreList.TimeTotal   := 0;
for i := 0 to NrOfScores do
   with ScoreList.Entries[i] do begin
      Pt         := 0;
      Player     := ''; //IntToStr(i);
      EMail      := '';
      Date       := now;
      StonesLeft := NrOfRows * NrOfColumns;
      Time       := 0;
      BiggestGrp := 0;
      end;
end;

function TGameType.SaveScores(Pts, StLeft, Playtime, NrOfMoves, BestMove: Integer;
   Finished: Boolean): Integer;
var i  : Integer;
    Place : Integer;
begin
Place := -1;
if Pts < 0 then Pts := 0;
with ScoreList do begin
   GamesPlayed := GamesPlayed + 1;
   StonesTotal := StonesTotal + (NrOfRows * NrOfColumns);
   StonesLeft  := StonesLeft + StLeft;
   if not Finished then NotFinished := NotFinished +1;
   TimeTotal   := TimeTotal+Playtime;
   end;
for i := 0 to NrOfScores do
   if Pts > ScoreList.Entries[i].Pt then begin
      Place := i;
      break;
      end;
Result := Place;
if Place > -1 then begin
   if (frmUser = nil) then Application.CreateForm(TfrmUser, frmUser);
   if UName = '' then UName := LoadStr(605);
   frmUser.editName.Text := UName;
   frmUser.editMail.Text := UMail;
   frmUser.ShowModal;
   if frmUser.ModalResult = mrOK then begin
      UName := frmUser.editName.Text;
      UMail := frmUser.editMail.Text;
      end;
   if (UName = '') then UName := LoadStr(605);
   for i := NrOfScores-1 downto Place do
      ScoreList.Entries[i+1] := ScoreList.Entries[i];
      with ScoreList.Entries[Place] do begin
         Pt         := Pts;
         Player     := UName;
         EMail      := UMail;
         Date       := now;
         StonesLeft := StLeft;
         Time       := Playtime;
         BiggestGrp := BestMove;
         end;
   end;
WriteScore;
end;

procedure TGameType.ReadScore;
var MS     : TFileStream;
    i      : Integer;
    IsVersion0 : Boolean;
    tStr       : String;
begin
try
MS := TFileStream.Create(ScoreFile, fmOpenRead or fmShareDenyNone);
// E-Mail ist erst in der Score-File-Version 1 enthalten, daher diese Unterscheidung
tStr := ReadString(MS);
IsVersion0 := not (tStr = ScoreID);
if IsVersion0 then MS.Position := 0;
MS.Read(ScoreList.GamesPlayed, SizeOf(Integer));
MS.Read(ScoreList.StonesTotal, SizeOf(Integer));
MS.Read(ScoreList.TimeTotal, SizeOf(Integer));
MS.Read(ScoreList.StonesLeft, SizeOf(Integer));
MS.Read(ScoreList.NotFinished, SizeOf(Integer));
for i := 0 to NrOfScores do begin
   MS.Read(ScoreList.Entries[i].Pt,SizeOf(Integer));
   //FillChar(Buffer, SizeOf(Buffer), #0);
   //MS.Read(L, SizeOf(L));
   //MS.Read(Buffer,L);
   //ScoreList.Entries[i].Player := StrPas(Buffer);
   ScoreList.Entries[i].Player := ReadString(MS);
   //FillChar(Buffer, SizeOf(Buffer), #0);
   //MS.Read(L, SizeOf(L));
   //MS.Read(Buffer,L);
   if not IsVersion0 then ScoreList.Entries[i].EMail := ReadString(MS);
   // ScoreList.Entries[i].EMail := StrPas(Buffer);
   MS.Read(ScoreList.Entries[i].Date, SizeOf(TDateTime));
   MS.Read(ScoreList.Entries[i].StonesLeft, SizeOf(Integer));
   MS.Read(ScoreList.Entries[i].Time, SizeOf(Integer));
   MS.Read(ScoreList.Entries[i].BiggestGrp, SizeOf(Integer));
   end;
MS.Free;
except
if not (MS = nil) then MS.Free;
MessageDlg(LoadStr(606), mtError, [mbOK],0);
DeleteFile(ScoreFile);
end;
end;

procedure TGameType.WriteScore;
var MS : TFileStream;
    i  : Integer;
begin
MS := TFileStream.Create(ScoreFile, fmCreate);
WriteString(MS,ScoreID);
MS.Write(ScoreList.GamesPlayed, SizeOf(Integer));
MS.Write(ScoreList.StonesTotal, SizeOf(Integer));
MS.Write(ScoreList.TimeTotal, SizeOf(Integer));
MS.Write(ScoreList.StonesLeft, SizeOf(Integer));
MS.Write(ScoreList.NotFinished, SizeOf(Integer));
for i := 0 to NrOfScores do begin
   MS.Write(ScoreList.Entries[i].Pt,SizeOf(Integer));
   WriteString(MS, ScoreList.Entries[i].Player);
   //L := Length(ScoreList.Entries[i].Player);
   //MS.Write(L, SizeOf(L));
   //MS.Write(PChar(ScoreList.Entries[i].Player)^, L);
   WriteString(MS, ScoreList.Entries[i].EMail);
   //L := Length(ScoreList.Entries[i].EMail);
   //MS.Write(L, SizeOf(L));
   //MS.Write(PChar(ScoreList.Entries[i].EMail)^, L);
   MS.Write(ScoreList.Entries[i].Date, SizeOf(TDateTime));
   MS.Write(ScoreList.Entries[i].StonesLeft, SizeOf(Integer));
   MS.Write(ScoreList.Entries[i].Time, SizeOf(Integer));
   MS.Write(ScoreList.Entries[i].BiggestGrp, SizeOf(Integer));
   end;
MS.Free;
end;

function TGameType.LoadStr(StrNr: Integer): String;
var buffer: array[0..255] of Char;
begin
Loadstring(lHandle, StrNr, @buffer, 255);
Result := StrPas(buffer);
end;

end.

