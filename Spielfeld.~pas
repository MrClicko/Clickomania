unit Spielfeld;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  extctrls, Stein, GameType, GameLog;

const
  AniMoveObj = 30;
  AniShowBmp = 50;

type
  TAniType   = (atFade, atAnimate, atSlide, atBringIn, atBringIn2, atBringIn3, atBringIn4, atShake);
  TMoveType  = (mtForward, mtUndo, mtNotAssigned, mtVertical, mtHorizontal);
  TDirection = (dHorizontal, dVertical);
  PMoveRec = ^TMoveRec;
  TMoveRec = record
    Stein    : TStein;
    Offset   : Integer;
    Direction : TDirection;
    end;
  PMoveStack = ^TMoveStack;
  TMoveStack = record
    Stein : TStein;
    Undo  : Boolean;
    end;
  PBringInRec = ^TBringInRec;
  TBringInRec = record
    Stein : TStein;
    Dest  : TPoint;
    Anicounts: Integer;
    Etappe: Integer;
    end;
  TGameWonEvent         = procedure(Sender : TObject) of object;
  TGameIsOverEvent      = procedure(Sender : TObject) of object;
  TMoveStartEvent       = procedure(Sender : TObject) of object;
  TGameHasStarted       = procedure(Sender : TObject) of object;
  TAnimationStarted     = procedure(Sender : TObject) of object;
  TSpielfeld = class(TCustomControl)
  private
     NrOfCols,
     NrRows,
     NrColumns,
     StoneHeight,
     StoneWidth   : Integer;
     Balls        : TImageList;
     CanIUndo     : Boolean;
     GameIsOver   : Boolean;
     DoingMove    : Boolean;
     GameLog      : TGameLog;
     RecordList   : TList;
     BIList       : TList;
     AniTimer     : TTimer;
     FrameCounter : Integer;
     Bg           : TBitmap;
     iBGColor     : TColor;
     iDT          : TDrawType;
     iBestMove    : Integer;
     StartTime,
     EndTime      : TDateTime;
     CurrentAniOpts     : TMoveType;
     StonesToAnimate    : TList;
     FPA                : Integer;
     AniInfo            : TAnimationInfo;
     ActionInfo         : TActionInfo;
     FOnWon             : TGameWonEvent;
     FOnGameIsOver      : TGameIsOverEvent;
     FOnNoMovePossible  : TNoMovePossibleEvent;
     FOnMoveStart       : TMoveStartEvent;
     FMoveDone          : TMoveDoneEvent;
     FGameStarted       : TGameHasStarted;
     FAnimationStarted  : TAnimationStarted;
     function getNrOfCols : Integer;
     procedure setNrOfCols(Nrs: Integer);
     function getRows : Integer;
     procedure setRows(Nrs: Integer);
     function getCols : Integer;
     procedure setCols(Nrs: Integer);
     function getSteinHoehe: Integer;
     procedure setSteinHoehe(Nr: Integer);
     function getSteinBreite: Integer;
     procedure setSteinBreite(Nr: Integer);
     procedure setBallsList(List: TImageList);
     function getGameState: Boolean;
     function getUndoState: Boolean;
     function IsMoveInProgress: Boolean;
     function getFPA : Integer;
     procedure setFPA(NewFPA: Integer);
     function getAnimationInfo: TAnimationInfo;
     procedure setAnimationInfo(AI: TAnimationInfo);
     function getActions: TActionInfo;
     procedure setActions(Acts: TActionInfo);
     function getBGColor: TColor;
     procedure setBGColor(C: TColor);
     function getBackground: TBitmap;
     procedure setBackground(Bmp: TBitmap);
     procedure setDrawType(dt : TDrawType);
     function getStonesLeft: Integer;
     function getBestMove: Integer;
     function getTime: Integer;
     function getNrOfMoves : Integer;
     function getGameLog: TGameLog;
     procedure CreateMoveList;
     procedure CreateColumnMoveList;
     procedure CheckState;
     procedure ResizeField;
     procedure GetColumnStones(InList: TList; Column: Integer; AddDeleted: Boolean);
     procedure MoveStones(List: TList; DoBackup: TMoveType);
     procedure PlayRecordList;
     procedure FadeStones(Sender: TObject);
     procedure AnimateStones(Sender: TObject);
     procedure SlideStones(Sender: TObject);
     procedure BringInStones(Sender: TObject);
     procedure BringInStones2(Sender: TObject);
     procedure BringInStones3(Sender: TObject);
     procedure BringInStones4(Sender: TObject);
     procedure ShakeStones(Sender: TObject);
     procedure ExecAnimation(AniType: TAniType; AniOpts: TMoveType; STAList: TList);
     procedure WaitForAnimationToTerminate;
     procedure GameWon; virtual;
     procedure GameIsOverEvent; virtual;
     procedure OnMoveHasStarted; virtual;
     procedure OnGameHasStarted; virtual;
     procedure OnAnimationHasStarted; virtual;
     function getPoints: Integer;
     function getBonusState: Boolean;
     function getBonus: Integer;
  protected
     procedure Paint; override;
  public
    CallerStone: TStein;
    DeleteList : TList;
    MoveList   : TList;
    ColumnList : TList;
    ActionLists: TList;
    Creating   : Boolean;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
    procedure Fill;
    procedure UpdateNbs;
    procedure ProcMove(OverrideMoveList: Boolean);
    procedure DoUndo;
    procedure DoRestart;
    procedure AddActionToRecordList(Stein: TStein);
  published
    property NrOfColors       : Integer read getNrOfCols write setNrOfCols;
    property Rows             : Integer read getRows write setRows;
    property Columns          : Integer read getCols write setCols;
    property Width;
    property Height;
    property Background       : TBitmap read getBackground write SetBackground;
    property BgColor          : TColor read getBGcolor write setBGcolor;
    property DrawType         : TDrawType write setDrawType;
    property Steinhoehe       : Integer read getSteinHoehe write setSteinHoehe;
    property Steinbreite      : Integer read getSteinbreite write setSteinBreite;
    property BallsList        : TImageList write setBallsList;
    property IsGameOver       : Boolean read getGameState;
    property CanUndo          : Boolean read getUndoState;
    property MoveInProgress   : Boolean read IsMoveInProgress;
    property FramePerAnimation: Integer read getFPA write setFPA;
    property Animations       : TAnimationInfo read getAnimationInfo write setAnimationInfo;
    property ActionStones     : TActionInfo read getActions write setActions;
    property OnWon            : TGameWonEvent    read FOnWon write FOnWon;
    property OnGameIsOver     : TGameIsOverEvent read FOnGameIsOver write FOnGameIsOver;
    property OnNoMovePossible : TNoMovePossibleEvent read FOnNoMovePossible write FOnNoMovePossible;
    property OnMoveStart      : TMoveStartEvent read FOnMoveStart write FOnMoveStart;
    property OnMoveDone       : TMoveDoneEvent read FMoveDone write FMoveDone;
    property OnGameStarted    : TGameHasStarted read FGameStarted write FGameStarted;
    property OnAnimationStarted: TAnimationStarted read FAnimationStarted write FAnimationStarted;
    property StonesLeft       : Integer read getStonesLeft;
    property BestMove         : Integer read getBestMove;
    property Time             : Integer read getTime;
    property CountMoves       : Integer read getNrOfMoves;
    property CurrentLog       : TGameLog read getGameLog;
    property Points           : Integer read getPoints;
    property GotBonus         : Boolean read getBonusState;
    property Bonus            : Integer read getBonus;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Matthias', [TSpielfeld]);
end;

constructor TSpielfeld.Create(AOwner: TComponent);
begin
inherited create(AOwner);
Creating := true;
// Standardwerte, sollten vom aufrufenden Programm überschrieben werden.
NrOfCols    := 5;
NrRows      := 18;
NrColumns   := 10;
StoneHeight := 25;
StoneWidth  := 25;
FPA         := 4;
GameIsOver  := false;
DoubleBuffered := true;
GameLog     := TGameLog.Create(self);
RecordList  := TList.Create;
BILIst      := TList.Create;
ActionLists := TList.Create;
//ActionList  := TList.Create;
AniTimer    := TTimer.Create(self);
AniTimer.Enabled  := false;
DoingMove   := false;
iBestMove   := 0;
EndTime     := 0;
ResizeField;
end;

destructor TSpielfeld.Destroy;
var i : Integer;
begin
try;
GameLog.Free;
RecordList.Free;
except; end;
try
for i := self.ControlCount -1 downto 0 do
   self.Controls[i].Free;
except; end;
inherited;
end;

function TSpielfeld.getNrOfCols : Integer;
begin
Result := NrOfCols;
end;

procedure TSpielfeld.setNrOfCols(Nrs: Integer);
begin
NrOfCols := Nrs;
end;

function TSpielfeld.getRows : Integer;
begin
Result := NrRows;
end;

procedure TSpielfeld.setRows(Nrs: Integer);
begin
NrRows := Nrs;
ResizeField;
end;

function TSpielfeld.getCols : Integer;
begin
Result := NrColumns;
end;

procedure TSpielfeld.setCols(Nrs: Integer);
begin
NrColumns   := Nrs;
ResizeField;
end;

function TSpielfeld.getSteinbreite: Integer;
begin
Result := StoneWidth;
end;

procedure TSpielfeld.setSteinBreite(Nr: Integer);
begin
StoneWidth := Nr;
ResizeField;
end;

function TSpielfeld.getSteinHoehe: Integer;
begin
Result := StoneHeight;
end;

procedure TSpielfeld.setSteinHoehe(Nr: Integer);
begin
StoneHeight := Nr;
ResizeField;
end;

procedure TSpielfeld.ResizeField;
begin
Width  := NrColumns *StoneWidth;
Height := NrRows *StoneHeight;
end;

function TSpielfeld.GetUndoState:Boolean;
begin;
CanIUndo := (GameLog.Count > 0) and not GameIsOver;
Result := CanIUndo;
end;

function TSpielfeld.GetGameState: Boolean;
begin;
Result := GameIsOver;
end;

function TSpielfeld.IsMoveInProgress: Boolean;
begin
Result := DoingMove;
end;

function TSpielfeld.getFPA : Integer;
begin
Result := FPA;
end;

procedure TSpielfeld.setFPA(NewFPA: Integer);
begin
FPA   := NewFPA;
ResizeField;
end;

function TSpielfeld.getAnimationInfo: TAnimationInfo;
begin
Result := AniInfo;
end;

procedure TSpielfeld.setAnimationInfo(AI: TAnimationInfo);
begin
AniInfo := AI;
end;

function TSpielfeld.getActions: TActionInfo;
begin
Result := ActionInfo;
end;

procedure TSpielfeld.setActions(Acts: TActionInfo);
begin
ActionInfo := Acts;
end;

function TSpielfeld.getBGColor: TColor;
begin
Result := iBGColor;
end;

procedure TSpielfeld.setBGColor(C: TColor);
begin
iBGColor := C;
end;

function TSpielfeld.getBackground: TBitmap;
begin
Result := BG;
end;

procedure TSpielfeld.setBackground(Bmp: TBitmap);
begin
BG := Bmp;
end;

procedure TSpielfeld.setDrawType(dt : TDrawType);
begin
iDT := dt;
end;

procedure TSpielfeld.setBallsList(List: TImageList);
begin
Balls := List;
end;

function TSpielfeld.getStonesLeft: Integer;
begin
Result := self.ControlCount;
end;

function TSpielfeld.getBestMove: Integer;
begin
Result := iBestMove;
end;

function TSpielfeld.getTime: Integer;
var e : TDateTime;
    std, min, days, sek, ms: Word;
begin
if EndTime = 0
   then e := Now
   else e := EndTime;
if e >= StartTime then days := Trunc(e-StartTime); // ganze Tage feststellen
DecodeTime((e-StartTime), std, min, sek, ms);      // Stunden und Minuten decodieren
std := days * 24 + std;                            // Stunden korrigieren
Result := (days*86400)+(std*3600)+(min*60)+ sek;
end;

function TSpielfeld.getNrOfMoves : Integer;
begin
Result := GameLog.Count;
end;

function TSpielfeld.getGameLog: TGameLog;
begin
Result := GameLog;
end;

procedure TSpielfeld.Fill;
var Stein : TStein;
    i, y  : Integer;
    Counter: Integer;
    BIRec : PBringInRec;
    AniType : Byte;
begin
Counter := 1;
Randomize;
AniType := Random(4)+1;
//AniType := 4;
for y := 0 to NrRows-1 do begin
    for i := 0 to NrColumns-1 do begin
      Stein := TStein.Create(self, Balls, ActionInfo);
      with Stein do begin
         Parent := self;
         Visible := false;
         Stein.DrawType := iDT;
         Name := 'Stein'+IntToStr(Counter);
         Nummer := Counter;
         //SetBounds(i*StoneWidth, y*StoneHeight, StoneHeight, StoneWidth);
         Stein.Width := StoneWidth;
         Stein.Height := StoneHeight;
         Stein.OnNoMovePossible := FOnNoMovePossible;
         Stein.OnMoveDone       := FMoveDone;
         // für BringIn-Animation
         New(BIRec);
         BIRec.Stein := Stein;
         BIRec.Etappe := 1;
         Case AniType of
            1: BIRec.Anicounts := y*StoneHeight div 40+Random(10);
            2: BIRec.Anicounts := 4;
            3: BIRec.Anicounts := 6;
            4: BIRec.Anicounts := 1;
            end;
         BIRec.Dest := Point(i*StoneWidth, y*StoneHeight);
         BIList.Add(BIRec);
         end;
      Inc(Counter);
      end;
   end;
DoingMove := true;
Case AniType of
   1: ExecAnimation(atBringIn, mtNotAssigned, BIList);
   2: ExecAnimation(atBringIn2, mtNotAssigned, BIList);
   3: ExecAnimation(atBringIn3, mtNotAssigned, BIList);
   4: ExecAnimation(atBringIn4, mtNotAssigned, BIList);
   end;
Creating := false;
StartTime := now;
BIList.Free;
UpdateNbs;
DoingMove := false;
FGameStarted(self);
end;

procedure TSpielfeld.Paint;
begin
if not ((iDT = dtHideBack) and Creating)
   then self.Canvas.Draw(0,0,BG);
end;

procedure TSpielfeld.UpdateNbs;
var i,y : Integer;
    Stein,
    Oben, links, rechts, unten: TStein;
    LinksP, TopP : Integer;
begin
for i := 0 to self.ControlCount -1 do begin
   Stein  := self.Controls[i] As TStein;
   Links := nil; Oben := nil; Unten := nil; rechts := nil;
   for y := 0 to self.ControlCount -1 do begin
      LinksP := TStein(self.Controls[y]).Left; Topp := TStein(self.Controls[y]).Top;
      if (LinksP = Stein.Left - StoneWidth) AND (Topp = Stein.Top) then Links := TStein(self.Controls[y]);
      if (LinksP = Stein.Left) AND (Topp = Stein.Top - StoneHeight) then Oben := TStein(self.Controls[y]);
      if (LinksP = Stein.Left) AND (Topp = Stein.Top + StoneHeight) then Unten := TStein(self.Controls[y]);
      if (LinksP = Stein.Left + StoneWidth) AND (Topp =  Stein.Top) then Rechts := TStein(self.Controls[y]);
      end;
   (* Alternative, die (aufgrund der falschen Bound-Einstellung?) nicht funktionierte.
   Stein  := self.Controls[i] As TStein;
   Links  := self.ControlAtPos(Point(Stein.Left - StoneWidth, Stein.Top),false) As TStein;
   Oben   := self.ControlAtPos(Point(Stein.Left,              Stein.Top - StoneHeight),false) As TStein;
   Unten  := self.ControlAtPos(Point(Stein.Left,              Stein.Top + StoneHeight),false) As TStein;
   Rechts := self.ControlAtPos(Point(Stein.Left + StoneWidth+20, Stein.Top),false) As TStein;
   if Stein.Nummer = Rechts.Nummer then Rechts := nil;
   if Stein.Nummer = Unten.Nummer then Unten := nil;*)
   Stein.setNb([Oben, Links, Rechts, Unten]);
   end;
end;

procedure TSpielfeld.GetColumnStones(InList: TList; Column: Integer; AddDeleted: Boolean);
var i,y,z : Integer;
    PLeft, PTop : Integer;
    Stein1, Stein2       : TStein;
    found   : Boolean;
begin
InList.Clear;
PLeft := Column * StoneWidth;
for i := NrRows-1 downto 0 do begin
    PTop := i * StoneHeight;
    for y := 0 to self.ControlCount -1 do begin
       Stein1  := self.Controls[y] As TStein;
       if (Stein1.Left = PLeft) AND (Stein1.Top = PTop) then begin
          if AddDeleted then InList.Add(Stein1);
          if not AddDeleted then begin
             for z := 0 to DeleteList.Count -1 do begin
                found := false;
                Stein2 := DeleteList[z];
                if (Stein2.Nummer = Stein1.Nummer) then begin
                   found := true;
                   break;
                   end;
                end;
             if not found then InList.Add(Stein1);
             end;
          end;
       end;
    end;
end;

procedure TSpielfeld.ProcMove(OverrideMoveList: Boolean);
var i       : Integer;
    Stein1  : TStein;
    UndoRec : PLogRec;
    MT      : TMoveType;
    List    : TList;
    GotBonus: Integer;
begin
//if DeleteList.Count = 0 then Exit;
GotBonus := 0;
DoingMove := true;
FOnMoveStart(self);
{Undo: Es wird für jeden Zug je eine MoveList, ColumnList und DeleteList gebraucht.
Diese werden vom Stein direkt erzeugt, weil sie schon für die Verarbeitung, die
noch vom Stein durchgeführt wird, gebraucht werden.}
if not OverrideMoveList then begin
   CreateMoveList;
   CreateColumnMoveList;
   end;
// ActionStones animieren
for i := 0 to ActionLists.Count-1 do begin
   List := ActionLists[i];
   if List.Count > 0 then begin
      case (CallerStone.ActionType.ActType) of
         atRocketTop, atRocketBottom: MT := mtVertical
         else                         MT := mtHorizontal;
         end;
      ExecAnimation(atShake, MT, List)
      end;
   List.Free;
   end;
// Gelöschte Steine animieren
if AniInfo.UseAnimations then ExecAnimation(atAnimate, mtForward, DeleteList)
                         else ExecAnimation(atFade, mtForward, DeleteList);
// Gelöschte Steine weg
for i := 0 to DeleteList.Count-1 do begin
   Stein1 := DeleteList[i];
   // Für den Bonus zählen, ob ein Stein darunter war
   case (Stein1.ActionType.ActType) of atRock: Inc(GotBonus,StoneKillBonus); end;
   {Ich will den Stein nicht löschen, sondern fürs Undo aufheben
   Stein1.Destroy;}
   Stein1.Parent := nil;
   end;
// Steine runterschieben
MoveStones(MoveList, mtForward);
// Steine rüberschieben
MoveStones(ColumnList, mtForward);
self.Repaint;
// Undo
New(UndoRec);
UndoRec.DeletedStones := DeleteList;
UndoRec.MovedCols     := MoveList;
UndoRec.MovedRows     := ColumnList;
UndoRec.Bonus         := GotBonus;
GameLog.Add(UndoRec);
// Schluss
UpdateNbs;
CheckState;
GetUndoState;
if DeleteList.Count > iBestMove then iBestMove := DeleteList.Count;
DoingMove := false;
PlayRecordList;
end;

procedure TSpielfeld.MoveStones(List: TList; DoBackup: TMoveType);
begin
ExecAnimation(atSlide, DoBackup, List);
end;

procedure TSpielfeld.CreateMoveList;
var i, y, z : Integer;
    Stein1,
    Stein2  : TStein;
    OffsetCounter : Integer;
    MoveRec      : PMoveRec;
    Found        : Boolean;
    CurrCol      : TList;
begin
//MoveList.Clear;
CurrCol := TList.Create;
for i := 0 to NrColumns-1 do begin
   OffsetCounter := 0;
   GetColumnStones(CurrCol, i,true);
   for y := 0 to CurrCol.Count -1 do begin
      Stein1 := CurrCol[y];
      // Stein-Effekte...
      // if Stein1.ActionType.IsAction and (Stein1.ActionType.ActType = atRock) then continue;
      Found := false;
      for z := 0 to DeleteList.Count -1 do begin
         Stein2 := TStein(DeleteList[z]);
         if (Stein1.Nummer = Stein2.Nummer) then begin
            Inc(OffsetCounter);
            Found := true;
            Continue;
            end;
         end;
      if not Found and (OffsetCounter > 0) then begin
         New(MoveRec);
         MoveRec.Stein := Stein1;
         MoveRec.Direction := dVertical;
         MoveRec.Offset := OffsetCounter;
         MoveList.Add(MoveRec);
         end;
      end;
   end;
end;

procedure TSpielfeld.CreateColumnMoveList;
var i, y: Integer;
    Stein1 : TStein;
    RowToDeleteCounter: Integer;
    MoveRec       :  PMoveRec;
    CurrCol          : TList;
begin
RowToDeleteCounter := 0;
//ColumnList.Clear;
CurrCol := TList.Create;
for i := 0 to NrColumns-1 do begin
   GetColumnStones(CurrCol, i, false);
   if CurrCol.Count = 0 then begin
      Inc(RowToDeleteCounter);
   end else begin
      if RowToDeleteCounter > 0 then begin
         for y := 0 to CurrCol.Count-1 do begin
            New(MoveRec);
            Stein1 := CurrCol[y];
            MoveRec.Stein := Stein1;
            MoveRec.Offset := RowToDeleteCounter;
            MoveRec.Direction := dHorizontal;
            ColumnList.Add(MoveRec);
            end;
         end;
      end;
   end;
CurrCol.Free;
end;

procedure TSpielfeld.CheckState;
var i : Integer;
    Stein : TStein;
    CountUniNbs : Integer;
    CountActStones : Integer;
begin
// Spiel gewonnen?
CountUniNbs := 0;
CountActStones := 0;
if self.ControlCount = 0 then begin
   EndTime := now;
   FOnWon(Self);
   GameIsOver := true;
   Self.Enabled := false;
   Exit;
   end;
// Spiel fertig?
for i := 0 to self.ControlCount -1 do begin
   Stein  := self.Controls[i] As TStein;
   Inc(CountUniNbs, Stein.UniNeighbours);
   if Stein.ActionType.IsAction and
      not ((Stein.ActionType.ActType = atRock) or (Stein.ActionType.ActType = atEarthQuake))
      then Inc(CountActStones);
   end;
if (CountUniNbs = 0) and (CountActStones = 0) then begin
   GameIsOver := true;
   Self.Enabled := false;
   EndTime := now;
   FOnGameIsOver(self);
   end;
end;

procedure TSpielfeld.GameWon;
begin
if Assigned(FOnWon) then FOnWon(Self);
end;

procedure TSpielfeld.GameIsOverEvent;
begin
if Assigned(FOnGameIsOver) then FOnGameIsOver(Self);
end;

procedure TSpielfeld.OnMoveHasStarted;
begin
if Assigned(FOnMoveStart) then FOnMoveStart(Self);
end;

procedure TSpielfeld.OnGameHasStarted;
begin
if Assigned(FGameStarted) then FGameStarted(Self);
end;

procedure TSpielfeld.OnAnimationHasStarted;
begin
if Assigned(FAnimationStarted) then FAnimationStarted(Self);
end;

procedure TSpielfeld.DoUndo;
var UndoRec : PLogRec;
    AddList : TList;
    i       : Integer;
    Stein   : TStein;
begin
if GameLog.Count = 0 then Exit;
if Self.MoveInProgress Then begin
   AddActionToRecordList(nil);
   Exit;
   end;
DoingMove := true;
UndoRec := GameLog[GameLog.Count-1];
MoveStones(UndoRec.MovedCols, mtUndo);
MoveStones(UndoRec.MovedRows, mtUndo);
AddList := UndoRec.DeletedStones;
// Steine zurückholen
for i := 0 to AddList.Count -1 do begin
   Stein := TStein(AddList[i]);
   Stein.Parent := self;
   Stein.Visible := false; {Stein soll erst nach dem Einblenden sichtbar sein}
   end;
// Fürs Debugging: Hier kann man die Rückwärts-Animationen testen
//AniInfo.PlayBackwards := true;
if AniInfo.UseAnimations and AniInfo.PlayBackwards
   then ExecAnimation(atAnimate, mtUndo, AddList)
   else ExecAnimation(atFade, mtUndo, AddList);
// Undo-Eintrag löschen
GameLog.Delete(GameLog.Count-1);
UpdateNbs;
GetUndoState;
DoingMove := false;
FMoveDone(self);
PlayRecordList;
end;

procedure TSpielfeld.DoRestart;
var i,
    FPABack : Integer;
begin
FPABAck :=  FPA;
if FPA >= 4 then FPA := FPA - 2;
for i := 0 to GameLog.Count-1 do DoUndo;
FPA := FPABack;
end;

procedure TSpielfeld.AddActionToRecordList(Stein: TStein);
var MS      : PMoveStack;
begin
New(MS);
MS.Stein := Stein;
MS.Undo := (Stein = nil);
RecordList.Add(MS);
end;

procedure TSpielfeld.PlayRecordList;
var MS      : PMoveStack;
    Stein   : TStein;
begin
if GameLog.Count = 0 then begin
   RecordList.Clear;
   Exit;
   end;
if RecordList.Count = 0 then Exit;
try
MS := RecordList[0];
RecordList.Delete(0);
if MS.Undo then DoUndo;
if not Ms.Undo then begin
   Stein := MS.Stein;
   if not (Stein.Parent = nil) then Stein.PlayMe;
   end;
except end;
end;

procedure TSpielfeld.ExecAnimation(AniType: TAniType; AniOpts: TMoveType; STAList: TList);
begin
AniTimer.Interval := AniMoveObj;
FrameCounter := 1;
StonesToAnimate := STAList;
CurrentAniOpts := AniOpts;
if AniType = atFade    then AniTimer.OnTimer := FadeStones;
if AniType = atAnimate then begin
   AniTimer.Interval := AniShowBmp;
   AniTimer.OnTimer := AnimateStones;
   end;
if AniType = atSlide   then AniTimer.OnTimer := SlideStones;
if AniType = atBringIn then AniTimer.OnTimer := BringInStones;
if AniType = atBringIn2 then AniTimer.OnTimer := BringInStones2;
if AniType = atBringIn3 then AniTimer.OnTimer := BringInStones3;
if AniType = atBringIn4 then AniTimer.OnTimer := BringInStones4;
if AniType = atShake   then begin
   AniTimer.Interval := AniShowBmp;
   AniTimer.OnTimer := ShakeStones;
   end;
AniTimer.Enabled := true;
WaitForAnimationToTerminate;
end;

procedure TSpielfeld.WaitForAnimationToTerminate;
begin
try
while AniTimer.Enabled do
   Application.ProcessMessages;
except
end;
end;

procedure TSpielfeld.FadeStones(Sender: TObject);
var i : Integer;
    Stein1 : TStein;
begin
for i := 0 to StonesToAnimate.Count -1 do begin
   Stein1 := StonesToAnimate[i];
   Stein1.Fade((CurrentAniOpts = mtForward), FrameCounter);
   end;
Inc(FrameCounter);
if (FrameCounter = FPA+1) then AniTimer.Enabled := false;
end;

procedure TSpielfeld.AnimateStones(Sender: TObject);
var i      : Integer;
    Stein1 : TStein;
    Bmp    : TBitmap;
    BmpNr  : Integer;
    Restore: Boolean;
begin
for i := 0 to StonesToAnimate.Count-1 do begin
   Stein1 := StonesToAnimate[i];
   Bmp := TBitmap.Create;
   Bmp.Transparent := True;
   Bmp.TransparentColor := clFuchsia;
   // Bilder müssen ohne Transparenz in der ImageList gespeichert sein (Fuchsia = Fuchsia)
   if AniInfo.SeparateColor then begin
      if (CurrentAniOpts = mtForward)
         then BmpNr := ((Stein1.MyType* AniInfo.CountFrames)-1) + FrameCounter
         else BmpNr := ((Stein1.MyType+1)* AniInfo.CountFrames) - FrameCounter;
      end else begin
      if (CurrentAniOpts = mtForward)
         then BmpNr := FrameCounter-1
         else BmpNr := AniInfo.CountFrames-FrameCounter;
      end;
   Restore := (CurrentAniOpts = mtUndo) and (FrameCounter > AniInfo.CountFrames);
   AniInfo.AniList.GetBitmap(BmpNr, Bmp);
   Stein1.Animate(Restore, Bmp);
   Bmp.Free;
   end;
Inc(FrameCounter);
if CurrentAniOpts = mtForward then begin
   if (FrameCounter = AniInfo.CountFrames+1) then AniTimer.Enabled := false;
end else begin
   if (FrameCounter = AniInfo.CountFrames +2) then AniTimer.Enabled := false;
   end;
end;

procedure TSpielfeld.SlideStones(Sender: TObject);
var i       : Integer;
    Stein1  : TStein;
    MoveRec : PMoveRec;
    Offset  : Integer;
begin
for i := StonesToAnimate.Count-1 downto 0 do begin
   MoveRec := (StonesToAnimate[i]);
   if (CurrentAniOpts = mtForward) then begin
      if MoveRec.Direction = dVertical
         then Offset := +(MoveRec.Offset * StoneHeight)
         else Offset := -(MoveRec.Offset * StoneWidth);
   end else begin
      if MoveRec.Direction = dVertical
         then Offset := -(MoveRec.Offset * StoneHeight)
         else Offset := +(MoveRec.Offset * StoneWidth);
      end;
   if FrameCounter < FPA
      then Offset := Trunc(Offset / FPA)
      else Offset := Offset - Trunc(Offset / FPA)* (FPA-1);
   Stein1 := MoveRec.Stein;
   if MoveRec.Direction = dVertical
      then Stein1.Top := Stein1.Top + Offset
      else Stein1.Left := Stein1.Left + Offset;
   end;
Inc(FrameCounter);
if (FrameCounter = FPA+1) then AniTimer.Enabled := false;
end;

procedure TSpielfeld.BringInStones(Sender: TObject);
var BIRec       : PBringInRec;
    Stein       : TStein;
    i           : Integer;
    Horizontaloffset : Double;
begin
FAnimationStarted(self);
//Stein := nil;
if BIList.Count = 0 then begin
   AniTimer.Enabled := false;
   Exit;
   end;
for i := 0 to (NrColumns*2)-1 do begin
   if ((BIList.Count-1 - i) < 0) then break;
   BIRec := BIList[BIList.Count-1-i];
   Stein := BIRec.Stein;
   if (BiRec.AniCounts = 0) then begin
      Stein.Top := (BIRec.Dest.y);
      Stein.Left := (BIRec.Dest.x)
   end else begin
      if (BIRec.Etappe = BiRec.AniCounts) then begin
         Stein.Top := (BIRec.Dest.y);
         Stein.Left := (BIRec.Dest.x)
         end else begin
         Stein.Top  := (Trunc(BIRec.Dest.y / BiRec.AniCounts) * BIRec.Etappe);
         if BIRec.Dest.y > 0 then begin
            Horizontaloffset := ((Stein.Top+200) / (BIRec.Dest.y+200));
         end else begin
            Horizontaloffset := 1;
            end;
         Stein.Left := Trunc((BIRec.Dest.x) * Horizontaloffset);
         end;
      end;
   BIRec.Etappe := BIRec.Etappe +1;
   Stein.Visible := true;
   if (Stein.Top = BIRec.Dest.y) then
      BIList.Delete(BIList.Count-1-i);
   end;
self.Repaint;
end;

procedure TSpielfeld.BringInStones2(Sender: TObject);
var BIRec       : PBringInRec;
    Stein       : TStein;
    i           : Integer;
begin
FAnimationStarted(self);
if BIList.Count = 0 then begin
   AniTimer.Enabled := false;
   Exit;
   end;
for i := BIList.Count-1 downto 0 do begin
   BIRec := BIList[i];
   Stein := BIRec.Stein;
   if (((Stein.Nummer-1)  mod NrColumns) > (FrameCounter-1)) then Continue;
   Stein.Left := BIRec.Dest.x;
   Stein.Top := BIRec.Dest.y;
   BIRec.Etappe := BIRec.Etappe +1;
   Stein.Width := Trunc(StoneWidth * (BIRec.Etappe / BiRec.AniCounts));
   Stein.Height := Trunc(StoneHeight * (BIRec.Etappe / BiRec.AniCounts));
   Stein.Visible := true;
   if (BIRec.Etappe = BiRec.AniCounts) then BIList.Delete(i);
   end;
Inc(FrameCounter);
self.Repaint;
end;

procedure TSpielfeld.BringInStones3(Sender: TObject);
var BIRec       : PBringInRec;
    Stein       : TStein;
    i           : Integer;
    Offset      : Integer;
begin
FAnimationStarted(self);
if BIList.Count = 0 then begin
   AniTimer.Enabled := false;
   Exit;
   end;
for i := BIList.Count-1 downto 0 do begin
   if Random(3) = 0 then Continue;
   BIRec := BIList[i];
   Stein := BIRec.Stein;
   Stein.Top := BIRec.Dest.y;
   BIRec.Etappe := BIRec.Etappe +1;
   //Offset := Trunc(BIRec.Dest.x*2 * ((BiRec.AniCounts-BIRec.Etappe) / BiRec.AniCounts));
   if ((Stein.Nummer-1)  mod NrColumns) < (NrColumns div 2) then begin
      Offset := Trunc((BIRec.Dest.x+StoneWidth*2) * ((BiRec.AniCounts-BIRec.Etappe) / BiRec.AniCounts));
      Stein.Left := BIRec.Dest.x - Offset
   end else begin
      Offset := Trunc(((Self.Width - BIRec.Dest.x)+StoneWidth*2) * ((BiRec.AniCounts-BIRec.Etappe) / BiRec.AniCounts));
      Stein.Left := BIRec.Dest.x + Offset;
      end;
   Stein.Visible := true;
   if (BIRec.Etappe = BiRec.AniCounts) then BIList.Delete(i);
   end;
Inc(FrameCounter);
self.Repaint;
end;

procedure TSpielfeld.BringInStones4(Sender: TObject);
var BIRec       : PBringInRec;
    Stein       : TStein;
    i           : Integer;
    Counter     : Integer;
begin
FAnimationStarted(self);
Counter := 0;
if BIList.Count = 0 then begin
   AniTimer.Enabled := false;
   Exit;
   end;
for i := BIList.Count-1 downto 0 do begin
   BIRec := BIList[i];
   Stein := BIRec.Stein;
   Stein.Left := BIRec.Dest.x;
   Stein.Top := BIRec.Dest.y;
   Stein.Visible := true;
   BIList.Delete(i);
   if Counter >= 3 then break;
   Inc(Counter);
   end;
Inc(FrameCounter);
self.Repaint;
end;

procedure TSpielfeld.ShakeStones(Sender: TObject);
var Stein : TStein;
    i     : Integer;
    Offset: Integer;
begin
for i := 0 to StonesToAnimate.Count-1 do begin
   Stein := StonesToAnimate[i];
   if Stein = nil then Continue;
   if (FrameCounter = 1) or (FrameCounter = 6)
      then Offset := 5
      else Offset := 10;
   if CurrentAniOpts = mtVertical then begin
      if FrameCounter mod 2 = 0
         then Stein.Top := Stein.Top -Offset
         else Stein.Top := Stein.Top +Offset;
   end else begin
      if FrameCounter mod 2 = 0
         then Stein.Left := Stein.Left -Offset
         else Stein.Left := Stein.Left +Offset;
      end;
   Stein.BringToFront;
   end;
Inc(FrameCounter);
if (FrameCounter = 7) then AniTimer.Enabled := false;
end;

function TSpielfeld.getPoints;
var Playtime : Integer;
    pt       : Integer;
begin
pt := 0;
Playtime := getTime;
if Playtime < 0 then PlayTime := 0;
pt := ((NrRows * NrColumns+1)-self.ControlCount)*10 - GameLog.Count +
        GameLog.BonusPoints + iBestMove - Playtime;
if (self.ControlCount = 0) then pt := Round(pt * 1.2);
Result := pt;
end;

function TSpielfeld.getBonusState: Boolean;
begin
Result := GameLog.BonusState;
end;

function TSpielfeld.getBonus: Integer;
begin
Result := GameLog.BonusPoints;
end;

end.
